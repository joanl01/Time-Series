# EDA : Plots

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


# EDA : Summary Statistics
# Jason-1
skimr::skim(jason1) 
# Big jump from p75 to p100 in eccentricity, argument of perigee, mean anomaly
# Maybe a little bit in right ascension

# Jason-2
skimr::skim(jason2)
# 4th quartile has really high value in eccentricity, argument of perigee
# Big jump of values from p0 p25 in eccentricity
# Big jump of values from p75 p100 in mean anomaly & brouwer mean motion
# Could see some anomaly in Brouwer mean motion 


# Sentinel 3B
skimr::skim(sent3b)
# Big jump in p75 to p100 in eccentricity, argument of perigee
# Maybe right ascension


# Plot scatter plots of time over each parameter
jason1 |> ggplot(aes(x = ...1, y = eccentricity)) + geom_point() +
  labs(title = "Eccentricity of Jason-1 satellite over time", 
       x  = "Time",
       y = "Eccentricity")

