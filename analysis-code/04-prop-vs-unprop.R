# Load required packages
pacman::p_load(tidyverse, tseries, forecast, here, readr, skimr)
fs::dir_ls(here::here("functions")) |> walk(source)

# Read in unpropagated data of desired satellites
sent3a <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-3A.csv"))
sent3b <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-3B.csv"))
sent6a <- read_csv(here::here("satellite_data", "orbital_elements", "unpropagated_elements_Sentinel-6A.csv"))

# Read in propagated data of desired satellites
sent3a_prop <- read_csv(here::here("satellite_data", "orbital_elements", "propagated_elements_Sentinel-3A.csv"))
sent3b_prop <- read_csv(here::here("satellite_data", "orbital_elements", "propagated_elements_Sentinel-3B.csv"))
sent6a_prop <- read_csv(here::here("satellite_data", "orbital_elements", "propagated_elements_Sentinel-6A.csv"))

# Take the difference between unpropagated and propagated
sent3a_res <- sent3a[-1,] - sent3a_prop
sent3b_res <- sent3b[-1,] - sent3b_prop
sent6a_res <- sent6a[-1,] - sent6a_prop

# Apply the function to the residuals
CI_sent3a_res <- map(sent3a_res, calculate_CI_res)
CI_sent3b_res <- map(sent3b_res, calculate_CI_res)
CI_sent6a_res <- map(sent6a_res, calculate_CI_res)


