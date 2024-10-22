# Load required packages
pacman::p_load(tidyverse, tseries, forecast, here, readr, skimr)
fs::dir_ls(here::here("functions")) |> walk(source)

# Read in unpropagated data of desired satellites
jason1 <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Jason-1.csv"))
jason2 <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Jason-2.csv"))
sent3b <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-3B.csv"))

# Convert each parameter to time series
jason1_params <- ts_params(jason1)
jason2_params <- ts_params(jason2)
sent3b_params <- ts_params(sent3b)

# Fit ARIMA models to each parameter
jason1_arima <- map(jason1_params, auto.arima)
jason2_arima <- map(jason2_params, auto.arima)
sent3b_arima <- map(sent3b_params, auto.arima)

# Plot original vs fitted for each parameter (Jason-1 example)
jason1_fitted <- map(jason1_arima, ~ .x$fitted)
jason1_params_names <- names(jason1_params)
for (i in seq_along(jason1_params_names)) {
  ts.plot(jason1_params[[i]], jason1_fitted[[i]], col = c("black", "blue"),
          main = paste("Jason1", "-", jason1_params_names[i]),
          ylab = jason1_params_names[i])
}

# Calculate confidence intervals for all parameters in Jason-1
jason1_CIs <- map(jason1_arima, calculate_CI)
jason1_CI_df <- jason1_CIs %>%
  set_names(names(jason1_arima)) %>%
  map_df(~ tibble(CI_low = .[1], CI_up = .[2]), .id = "parameter")

# Similarly, calculate confidence intervals for Jason-2 and Sentinel-3B
jason2_CIs <- map(jason2_arima, calculate_CI)
jason2_CI_df <- jason2_CIs %>%
  set_names(names(jason2_arima)) %>%
  map_df(~ tibble(CI_low = .[1], CI_up = .[2]), .id = "parameter")

sent3b_CIs <- map(sent3b_arima, calculate_CI)
sent3b_CI_df <- sent3b_CIs %>%
  set_names(names(sent3b_arima)) %>%
  map_df(~ tibble(CI_low = .[1], CI_up = .[2]), .id = "parameter")

# Apply to the Jason-1 dataset (Process residuals and flags)
jason1_res_data <- process_residuals_and_flags(jason1_arima)

# Similarly, apply to Jason-2 and Sentinel-3B
jason2_res_data <- process_residuals_and_flags(jason2_arima)
sent3b_res_data <- process_residuals_and_flags(sent3b_arima)

df <- jason1_res_data %>% select(eccentricity_flag, 
                                 `argument of perigee_flag`,
                                 inclination_flag,
                                 `mean anomaly_flag`,
                                 `Brouwer mean motion_flag`,
                                 `right ascension_flag`)

df$eccentricity_flag
df$`argument of perigee_flag`
df$inclination_flag
df$`mean anomaly_flag`
df$`Brouwer mean motion_flag`
df$`right ascension_flag`
