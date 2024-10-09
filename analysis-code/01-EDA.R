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
# Jason-1 Eccentricity
jason1 |> ggplot(aes(x = ...1, y = eccentricity)) + geom_point() +
  labs(title = "Eccentricity of Jason-1 satellite over time", 
       x  = "Time",
       y = "Eccentricity") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-1-Eccentricity-vs-time.pdf"),
      plot = last_plot(),
      width = 16,
      height = 9,
      units = "in",
      dpi = 500)
# Jason-1 Argument of Perigee
jason1 |> ggplot(aes(x = ...1, y = `argument of perigee`)) + geom_point() +
  labs(title = "Argument of Perigee of Jason-1 satellite over time", 
       x  = "Time",
       y = "Argument of Perigee") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-1-Argument-of-Perigee-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Jason-1 Inclination
jason1 |> ggplot(aes(x = ...1, y = inclination)) + geom_point() +
  labs(title = "Inclination of Jason-1 satellite over time", 
       x  = "Time",
       y = "Inclination") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-1-Inclination-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)
# Jason-1 Mean Anomaly
jason1 |> ggplot(aes(x = ...1, y = `mean anomaly`)) + geom_point() +
  labs(title = "Mean Anomaly of Jason-1 satellite over time", 
       x  = "Time",
       y = "Mean Anomaly") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-1-Mean-Anomaly-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Jason-1 Mean Anomaly
jason1 |> ggplot(aes(x = ...1, y = `Brouwer mean motion`)) + geom_point() +
  labs(title = "Brouwer Mean Motion of Jason-1 satellite over time", 
       x  = "Time",
       y = "Brouwer Mean Motion") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-1-Brouwer-Mean_Motion-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)


# Jason-1 Right Ascension
jason1 |> ggplot(aes(x = ...1, y = `right ascension`)) + geom_point() +
  labs(title = "Right Ascension of Jason-1 satellite over time", 
       x  = "Time",
       y = "Right Ascension") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-1-Right-Ascension-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)




# Plot scatter plots of time over each parameter
# Jason-2 Eccentricity
jason2 |> ggplot(aes(x = ...1, y = eccentricity)) + geom_point() +
  labs(title = "Eccentricity of Jason-2 satellite over time", 
       x  = "Time",
       y = "Eccentricity") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-2-Eccentricity-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)
# Jason-2 Argument of Perigee
jason2 |> ggplot(aes(x = ...1, y = `argument of perigee`)) + geom_point() +
  labs(title = "Argument of Perigee of Jason-2 satellite over time", 
       x  = "Time",
       y = "Argument of Perigee") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-2-Argument-of-Perigee-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Jason-2 Inclination
jason2 |> ggplot(aes(x = ...1, y = inclination)) + geom_point() +
  labs(title = "Inclination of Jason-2 satellite over time", 
       x  = "Time",
       y = "Inclination") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-2-Inclination-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)
# Jason-2 Mean Anomaly
jason2 |> ggplot(aes(x = ...1, y = `mean anomaly`)) + geom_point() +
  labs(title = "Mean Anomaly of Jason-2 satellite over time", 
       x  = "Time",
       y = "Mean Anomaly") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-2-Mean-Anomaly-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Jason-2 Mean Anomaly
jason2 |> ggplot(aes(x = ...1, y = `Brouwer mean motion`)) + geom_point() +
  labs(title = "Brouwer Mean Motion of Jason-2 satellite over time", 
       x  = "Time",
       y = "Brouwer Mean Motion") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-2-Brouwer-Mean_Motion-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)


# Jason-2 Right Ascension
jason2 |> ggplot(aes(x = ...1, y = `right ascension`)) + geom_point() +
  labs(title = "Right Ascension of Jason-2 satellite over time", 
       x  = "Time",
       y = "Right Ascension") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Jason-2-Right-Ascension-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)



# Sentinel-3B Eccentricity
sent3b |> ggplot(aes(x = ...1, y = eccentricity)) + geom_point() +
  labs(title = "Eccentricity of Sentinel-3B satellite over time", 
       x  = "Time",
       y = "Eccentricity") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3B-Eccentricity-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)
# Sentinel-3B Argument of Perigee
sent3b |> ggplot(aes(x = ...1, y = `argument of perigee`)) + geom_point() +
  labs(title = "Argument of Perigee of Sentinel-3B satellite over time", 
       x  = "Time",
       y = "Argument of Perigee") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3B-Argument-of-Perigee-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Sentinel-3B Inclination
sent3b |> ggplot(aes(x = ...1, y = inclination)) + geom_point() +
  labs(title = "Inclination of Sentinel-3B satellite over time", 
       x  = "Time",
       y = "Inclination") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3B-Inclination-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)
# Sentinel-3B Mean Anomaly
sent3b |> ggplot(aes(x = ...1, y = `mean anomaly`)) + geom_point() +
  labs(title = "Mean Anomaly of Sentinel-3B satellite over time", 
       x  = "Time",
       y = "Mean Anomaly") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3B-Mean-Anomaly-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Sentinel-3B Mean Anomaly
sent3b |> ggplot(aes(x = ...1, y = `Brouwer mean motion`)) + geom_point() +
  labs(title = "Brouwer Mean Motion of Sentinel-3B satellite over time", 
       x  = "Time",
       y = "Brouwer Mean Motion") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3B-Brouwer-Mean_Motion-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)


# Sentinel-3B Right Ascension
sent3b |> ggplot(aes(x = ...1, y = `right ascension`)) + geom_point() +
  labs(title = "Right Ascension of Sentinel-3B satellite over time", 
       x  = "Time",
       y = "Right Ascension") + theme_bw()
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3B-Right-Ascension-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)



