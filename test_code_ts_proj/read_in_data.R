# Define Data Path
pacman::p_load(tidyverse)
#bbi_paths <- paste0("FLARE", sprintf("%03d", 1:11), "_", c("HJ", "DC", "TM", "BP", "JT", "JA", "JH", "AP", "AJ", "KL", "JS"), "_data/garmin-device-bbi")
satellite_prop_paths <- paste0("propagated_elements_", c("CryoSat-2", "Fengyun-2"),".csv")
satellite_data <- here::here("satellite_data", "orbital_elements")

read_satellite <- function(file){
  df <- read.csv(file)
}

read_satellites <- function(folder){
  fs::dir_ls(folder) |> 
    map(read_satellite) |> 
    list_rbind()
}


sat_data <- map(satellite_data, read_satellites)
sat_data
