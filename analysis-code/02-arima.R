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

