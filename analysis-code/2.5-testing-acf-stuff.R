# 3.5 Story version
# Load required packages
pacman::p_load(tidyverse, tseries, forecast, here, readr, skimr)
fs::dir_ls(here::here("functions")) |> walk(source)

# Read in unpropagated data of desired satellites
sent3a <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-3A.csv"))
sent3b <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-3B.csv"))
sent6a <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-6A.csv"))
# Take off first x days of data

sent3a <- sent3a[-1:-301,]
sent6a <- sent6a[-1:-24,]
sent3b <- sent3b[-1:-231,]

sent3a <- sent3a %>% mutate(year = year(...1)) %>% filter(year < 2022)
# Convert each parameter to time series
sent3a_params <- ts_params(sent3a)
sent6a_params <- ts_params(sent6a)
sent3b_params <- ts_params(sent3b)

# Plot ACF, PACF and Augmented Dickey-Fuller-Test
sent3a_bmm_acf <- acf(sent3a_params$`Brouwer mean motion`, plot = FALSE)

par(cex.main = 2)  # Set main title size
plot(sent3a_bmm_acf, main = "ACF plot of Brouwer mean motion for Sentinel-3A",cex.lab= 2, cex.axis=2)

sent3a_bmm_pacf<- pacf(sent3a_params$`Brouwer mean motion`, plot = FALSE)
plot(sent3a_bmm_pacf, main = "PACF plot of Brouwer mean motion for Sentinel-3A", cex.lab= 2, cex.axis=2)
adf.test(sent3a_params$`Brouwer mean motion`)


# ACF decays slowly thus take the first difference
sent3a_bmm_diff <- diff(sent3a_params$`Brouwer mean motion`)
sent3a_bmm_diff_acf <- acf(sent3a_bmm_diff, plot = FALSE)
plot(sent3a_bmm_diff_acf, main = "ACF plot of Brouwer mean motion after first difference for Sentinel-3A",cex.lab= 2, cex.axis=2)
sent3a_bmm_diff_pacf <- pacf(sent3a_bmm_diff, plot = FALSE)
plot(sent3a_bmm_diff_pacf, main = "PACF plot of Brouwer mean motion after first difference for Sentinel-3A",cex.lab= 2, cex.axis=2)
adf.test(sent3a_bmm_diff)



# Plot ACF, PACF and Augmented Dickey-Fuller-Test
sent3a_ma_acf <- acf(sent3a_params$`mean anomaly`, plot = FALSE)
plot(sent3a_ma_acf, main = "ACF plot of Mean Anomaly for Sentinel-3A",cex.lab= 2, cex.axis=2)
sent3a_ma_pacf<- pacf(sent3a_params$`mean anomaly`, plot = FALSE)
plot(sent3a_ma_pacf, main = "PACF plot of Mean Anomaly for Sentinel-3A",cex.lab= 2, cex.axis=2)
adf.test(sent3a_params$`Brouwer mean motion`)


# ACF decays slowly thus take the first difference
sent3a_ma_diff <- diff(sent3a_params$`mean anomaly`, lag = 1 )
sent3a_ma_diff_acf <- acf(sent3a_ma_diff, plot = FALSE)
plot(sent3a_ma_diff_acf, main = "ACF plot of Mean Anomaly after first difference for Sentinel-3A",cex.lab= 2, cex.axis=2)
sent3a_ma_diff_pacf <- pacf(sent3a_ma_diff, plot = FALSE)
plot(sent3a_bmm_diff_pacf, main = "PACF plot of Mean Anomaly after first difference for Sentinel-3A",cex.lab= 2, cex.axis=2)
adf.test(sent3a_bmm_diff)



sent3a_ma_diff <- diff(sent3a_params$`mean anomaly`, lag = 6 )
sent3a_ma_diff_acf <- acf(sent3a_ma_diff, plot = FALSE)
plot(sent3a_ma_diff_acf, main = "ACF plot of Mean Anomaly after 6 differences for Sentinel-3A",cex.lab= 2, cex.axis=2)
sent3a_ma_diff_pacf <- pacf(sent3a_ma_diff, plot = FALSE)
plot(sent3a_ma_diff_pacf, main = "PACF plot of Mean Anomaly after 6 differences for Sentinel-3A",cex.lab= 2, cex.axis=2)
adf.test(sent3a_bmm_diff)


sent3a_ma_diff <- diff(sent3a_params$`mean anomaly`, lag = 12 )
sent3a_ma_diff_acf <- acf(sent3a_ma_diff, plot = FALSE)
plot(sent3a_ma_diff_acf, main = "ACF plot of Mean Anomaly after 12 differences for Sentinel-3A",cex.lab= 2, cex.axis=2)
sent3a_bmm_diff_pacf <- pacf(sent3a_bmm_diff, plot = FALSE)
plot(sent3a_bmm_diff_pacf, main = "PACF plot of Mean Anomaly after 12 differences for Sentinel-3A",cex.lab= 2, cex.axis=2)
adf.test(sent3a_bmm_diff)




# Plot ACF, PACF and Augmented Dickey-Fuller-Test
sent6a_bmm_acf <- acf(sent6a_params$`Brouwer mean motion`, plot = FALSE)
plot(sent6a_bmm_acf, main = "ACF plot of Brouwer mean motion for Sentinel-6A",cex.lab= 2, cex.axis=2)
sent6a_bmm_pacf<- pacf(sent6a_params$`Brouwer mean motion`, plot = FALSE)
plot(sent6a_bmm_pacf, main = "PACF plot of Brouwer mean motion for Sentinel-6A",cex.lab= 2, cex.axis=2)
adf.test(sent6a_params$`Brouwer mean motion`)





# Plot ACF, PACF and Augmented Dickey-Fuller-Test
sent6a_ma_acf <- acf(sent6a_params$`mean anomaly`, plot = FALSE)
plot(sent6a_ma_acf, main = "ACF plot of Mean Anomaly for Sentinel-6A",cex.lab= 2, cex.axis=2)
sent6a_ma_pacf<- pacf(sent6a_params$`mean anomaly`, plot = FALSE)
plot(sent6a_ma_pacf, main = "PACF plot of Mean Anomaly for Sentinel-6A",cex.lab= 2, cex.axis=2)
adf.test(sent6a_params$`Brouwer mean motion`)


# ACF decays slowly thus take the first difference
sent6a_ma_diff <- diff(sent6a_params$`mean anomaly`)
sent6a_ma_diff_acf <- acf(sent6a_ma_diff, plot = FALSE)
plot(sent6a_ma_diff_acf, main = "ACF plot of Mean Anomaly after first difference for Sentinel-6A",cex.lab= 2, cex.axis=2)
sent6a_ma_diff_pacf <- pacf(sent6a_ma_diff, plot = FALSE)
plot(sent6a_bmm_diff_pacf, main = "PACF plot of Mean Anomaly after first difference for Sentinel-6A",cex.lab= 2, cex.axis=2)
adf.test(sent6a_bmm_diff)


