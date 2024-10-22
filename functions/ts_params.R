ts_params <- function(satellite_data) {
  # Convert parameters to time series
  params <- satellite_data %>%
    select(eccentricity, `argument of perigee`, inclination, `mean anomaly`, 
           `Brouwer mean motion`, `right ascension`) %>%
    map(~ ts(.))
}