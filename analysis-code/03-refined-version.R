# Load required packages
pacman::p_load(tidyverse, tseries, forecast, here, readr, skimr, lubridate)
fs::dir_ls(here::here("functions")) |> walk(source)

# Read in unpropagated data of desired satellites
sent3a <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-3A.csv"))
sent3b <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-3B.csv"))
sent6a <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-6A.csv"))
# Take off first 60 days of data

sent3a <- sent3a[-1:-301,]
sent6a <- sent6a[-1:-24,]
sent3b <- sent3b[-1:-231,]


sent3a <- sent3a %>% mutate(year = year(...1)) %>% filter(year < 2022)

# Convert each parameter to time series
sent3a_params <- ts_params(sent3a)
sent6a_params <- ts_params(sent6a)
sent3b_params <- ts_params(sent3b)

# Fit ARIMA models to each parameter
sent3a_arima <- map(sent3a_params, auto.arima)
sent6a_arima <- map(sent6a_params, auto.arima)
sent3b_arima <- map(sent3b_params, auto.arima)



data <- sent3a_params$`Brouwer mean motion`
arima013 <- arima(data, order = c(0,1,3))
arima013$aic
arima014 <- arima(data, order = c(0,1,4))
arima014$aic
arima313 <- arima(data, order = c(3,1,3))
arima313$aic
arima314 <- arima(data, order = c(3,1,4))
arima314$aic
adf.test(data)



# data2 <- sent3a_params$`mean anomaly`
# arima111 <- arima(data2, order = c(1,1,1))
# arima111$aic

# arima213 <- arima(data2, order = c(2,1,))
# arima213$aic


# Plot original vs fitted for each parameter (Sentinel-3A example)
sent3a_fitted <- map(sent3a_arima, ~ .x$fitted)
sent3a_arima$`Brouwer mean motion` <- arima014
sent3a_fitted$`Brouwer mean motion` <- fitted(arima014)
sent3a_params_names <- names(sent3a_params)
for (i in seq_along(sent3a_params_names)) {
  ts.plot(sent3a_params[[i]], sent3a_fitted[[i]], col = c("black", "blue"),
          main = paste("sent3a", "-", sent3a_params_names[i]),
          ylab = sent3a_params_names[i])
}


# Calculate confidence intervals for all parameters in Sentinel3A
sent3a_CIs <- map(sent3a_arima, calculate_CI)
sent3a_CI_df <- sent3a_CIs %>%
  set_names(names(sent3a_arima)) %>%
  map_df(~ tibble(CI_low = .[1], CI_up = .[2]), .id = "parameter")

bmm_sent6a <- sent6a_params$`Brouwer mean motion`
arima200 <- arima(bmm_sent6a, order = c(2,0,0))
# Similarly, calculate confidence intervals for Sentinel-6A and Sentinel-3B
sent6a_arima$`Brouwer mean motion` <- arima200
sent6a_CIs <- map(sent6a_arima, calculate_CI)
sent6a_CI_df <- sent6a_CIs %>%
  set_names(names(sent6a_arima)) %>%
  map_df(~ tibble(CI_low = .[1], CI_up = .[2]), .id = "parameter")

sent3b_CIs <- map(sent3b_arima, calculate_CI)
sent3b_CI_df <- sent3b_CIs %>%
  set_names(names(sent3b_arima)) %>%
  map_df(~ tibble(CI_low = .[1], CI_up = .[2]), .id = "parameter")

# Apply to the Sentinel-3A dataset (Process residuals and flags)
sent3a_res_data <- process_residuals_and_flags(sent3a_arima)

# Similarly, apply to Sentinel-6A and Sentinel-3B
sent6a_res_data <- process_residuals_and_flags(sent6a_arima)
sent3b_res_data <- process_residuals_and_flags(sent3b_arima)

sent3a_res_data$date <- as.Date(sent3a$...1)
sent6a_res_data$date <- as.Date(sent6a$...1)
sent3b_res_data$date <- as.Date(sent3b$...1)
