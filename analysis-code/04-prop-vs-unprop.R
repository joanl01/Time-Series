# Load required packages
pacman::p_load(tidyverse, tseries, forecast, here, readr, skimr)
fs::dir_ls(here::here("functions")) |> walk(source)


# Read in propagated data of desired satellites
sent3a_prop <- read_csv(here::here("satellite_data", "orbital_elements", "propagated_elements_Sentinel-3A.csv"))
sent3b_prop <- read_csv(here::here("satellite_data", "orbital_elements", "propagated_elements_Sentinel-3B.csv"))
sent6a_prop <- read_csv(here::here("satellite_data", "orbital_elements", "propagated_elements_Sentinel-6A.csv"))

# Take the first 59 rows of the propagated data
sent3a_prop <- sent3a_prop[-1:-300,]
sent6a_prop <- sent6a_prop[-1:-23,]
sent3b_prop <- sent3b_prop[-1:-230,]


sent3a_prop <- sent3a_prop %>% mutate(year = year(...1)) %>% filter(year < 2022)
# Take the difference between unpropagated and propagated
sent3a_res <- sent3a - sent3a_prop
sent3b_res <- sent3b - sent3b_prop
sent6a_res <- sent6a - sent6a_prop


# Apply the function to the residuals
CI_sent3a_res <- map(sent3a_res, calculate_CI_res)
CI_sent3b_res <- map(sent3b_res, calculate_CI_res)
CI_sent6a_res <- map(sent6a_res, calculate_CI_res)


# Specify the parameters to check
parameters <- c("eccentricity", "argument of perigee", "inclination", 
                "mean anomaly", "Brouwer mean motion", "right ascension")

# Run the function for sent3a_res using CI_sent3a_res
sent3a_res <- add_flag_columns(sent3a_res, CI_sent3a_res, parameters)
sent6a_res <- add_flag_columns(sent6a_res, CI_sent6a_res, parameters)
sent3b_res <- add_flag_columns(sent3b_res, CI_sent3b_res, parameters)


sent3a_res$date <- as.Date(sent3a$...1)
sent3a_res$...1 <- sent3a$...1
names(sent3a_res)[1] <- "datetime"
sent3a_res

sent6a_res$date <- as.Date(sent6a$...1)
sent6a_res$...1 <- sent6a$...1
names(sent6a_res)[1] <- "datetime"
sent6a_res


sent3b_res$date <- as.Date(sent3b$...1)
sent3b_res$...1 <- sent3b$...1
names(sent3b_res)[1] <- "datetime"
sent3b_res




