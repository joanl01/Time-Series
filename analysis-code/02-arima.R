# Fit ARIMA 
# Load required packages
pacman::p_load(tidyverse, tseries, forecast, here, readr, skimr)

# Read in unpropagated data of desired satellites : 
#Jason-1, 
jason1 <- read_csv(here::here("satellite_data",
                              "orbital_elements",
                              "unpropagated_elements_Jason-1.csv"))
#Jason-2 
jason2 <- read_csv(here::here("satellite_data",
                              "orbital_elements",
                              "unpropagated_elements_Jason-2.csv"))
#Sentinel 3B
sent3b <- read_csv(here::here("satellite_data",
                              "orbital_elements",
                              "unpropagated_elements_Sentinel-3B.csv"))


# For each parameter, convert to ts
# Jason-1
jason1_ecc <- ts(jason1$eccentricity)
jason1_aop <- ts(jason1$`argument of perigee`)
jason1_inc <- ts(jason1$inclination)
jason1_meananom <- ts(jason1$`mean anomaly`)
jason1_bmm <- ts(jason1$`Brouwer mean motion`)
jason1_ra <- ts(jason1$`right ascension`)



jason1_ecc_M1 <- auto.arima(jason1_ecc)
jason1_aop_M1 <- auto.arima(jason1_aop)
jason1_inc_M1 <- auto.arima(jason1_inc)
jason1_meananom_M1 <- auto.arima(jason1_meananom)
jason1_bmm_M1 <- auto.arima(jason1_bmm)
jason1_ra_M1 <- auto.arima(jason1_ra)


ts.plot(jason1_ecc, jason1_ecc_M1$fitted, col = c("black", "blue"))
ts.plot(jason1_aop, jason1_aop_M1$fitted, col = c("black", "blue"))
ts.plot(jason1_inc, jason1_inc_M1$fitted, col = c("black", "blue"))
ts.plot(jason1_meananom, jason1_meananom_M1$fitted, col = c("black", "blue"))
ts.plot(jason1_bmm, jason1_bmm_M1$fitted, col = c("black", "blue"))
ts.plot(jason1_ra, jason1_ra_M1$fitted, col = c("black", "blue"))


CI_ecc_low <- mean(jason1_ecc_M1$residuals) - qnorm(0.925)*sd(jason1_ecc_M1$residuals)/sqrt(length(jason_ecc_M1$residuals))
CI_ecc_up <- mean(jason1_ecc_M1$residuals) + qnorm(0.925)*sd(jason1_ecc_M1$residuals)/sqrt(length(jason_ecc_M1$residuals))

jason1_res_data <- data.frame(
  eccentricity = jason1_ecc_M1$residuals,
  argument_of_perigee = jason1_aop_M1$residuals,
  inclination = jason1_inc_M1$residuals,
  mean_anomaly = jason1_meananom_M1$residuals,
  right_ascension = jason1_ra_M1$residuals,
  flag = NA
)

for (i in 1:nrow(jason1_res_data)) {
  if (CI_ecc_low <= jason1_res_data$eccentricity[i] &  jason1_res_data$eccentricity[i] <= CI_ecc_up) {
    jason1_res_data$flag[i] <-  0
  } else if(CI_ecc_low >= jason1_res_data$eccentricity[i] | 
            jason1_res_data$eccentricity[i] >= CI_ecc_up) {
    jason1_res_data$flag[i] <-  1}
}


