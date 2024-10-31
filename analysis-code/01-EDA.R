# EDA : Plots
# Load required packages
pacman::p_load(tidyverse, tseries, forecast, here, readr, skimr)

# Read in unpropagated data of desired satellites : 
#Sentinel-3A, 
sent3a <- read_csv(here::here("satellite_data",
                              "orbital_elements",
                              "unpropagated_elements_Sentinel-3A.csv"))
#Sentinel-6A 
sent6a <- read_csv(here::here("satellite_data",
                              "orbital_elements",
                              "unpropagated_elements_Sentinel-6A.csv"))
#Sentinel 3B
sent3b <- read_csv(here::here("satellite_data",
                              "orbital_elements",
                              "unpropagated_elements_Sentinel-3B.csv"))


# EDA : Summary Statistics
# Sentinel-3A
skimr::skim(sent3a) 
# Big jump from p75 to p100 in eccentricity, argument of perigee, mean anomaly
# Maybe a little bit in right ascension

# Sentinel-6A
skimr::skim(sent6a)
# 4th quartile has really high value in eccentricity, argument of perigee
# Big jump of values from p0 p25 in eccentricity
# Big jump of values from p75 p100 in mean anomaly & brouwer mean motion
# Could see some anomaly in Brouwer mean motion 


# Sentinel 3B
skimr::skim(sent3b)
# Big jump in p75 to p100 in eccentricity, argument of perigee
# Maybe right ascension


# Plot scatter plots of time over each parameter
# Sentinel-3A Eccentricity
sent3a |> ggplot(aes(x = ...1, y = eccentricity)) + geom_point() +
  labs(title = "Eccentricity of Sentinel-3A satellite over time", 
       x  = "Time",
       y = "Eccentricity") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                axis.text = element_text(size = 30),
                                                axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3A-Eccentricity-vs-time.pdf"),
      plot = last_plot(),
      width = 16,
      height = 9,
      units = "in",
      dpi = 500)
# Sentinel-3A Argument of Perigee
sent3a |> ggplot(aes(x = ...1, y = `argument of perigee`)) + geom_point() +
  labs(title = "Argument of Perigee of Sentinel-3A satellite over time", 
       x  = "Time",
       y = "Argument of Perigee") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                      axis.text = element_text(size = 30),
                                                      axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3A-Argument-of-Perigee-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Sentinel-3A Inclination
sent3a |> ggplot(aes(x = ...1, y = inclination)) + geom_point() +
  labs(title = "Inclination of Sentinel-3A satellite over time", 
       x  = "Time",
       y = "Inclination") + theme_bw() + theme(plot.title = element_text(size = 30),
                                               axis.text = element_text(size = 30),
                                               axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3A-Inclination-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)
# Sentinel-3A Mean Anomaly
sent3a |> ggplot(aes(x = ...1, y = `mean anomaly`)) + geom_point() +
  labs(title = "Mean Anomaly of Sentinel-3A satellite over time", 
       x  = "Time",
       y = "Mean Anomaly") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                axis.text = element_text(size = 30),
                                                axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3A-Mean-Anomaly-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Sentinel-3A Mean Anomaly
sent3a |> ggplot(aes(x = ...1, y = `Brouwer mean motion`)) + geom_point() +
  labs(title = "Brouwer Mean Motion of Sentinel-3A satellite over time", 
       x  = "Time",
       y = "Brouwer Mean Motion") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                       axis.text = element_text(size = 30),
                                                       axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3A-Brouwer-Mean_Motion-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)


# Sentinel-3A Right Ascension
sent3a |> ggplot(aes(x = ...1, y = `right ascension`)) + geom_point() +
  labs(title = "Right Ascension of Sentinel-3A satellite over time", 
       x  = "Time",
       y = "Right Ascension") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                   axis.text = element_text(size = 30),
                                                   axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3A-Right-Ascension-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)




# Plot scatter plots of time over each parameter
# Sentinel-6A Eccentricity
sent6a |> ggplot(aes(x = ...1, y = eccentricity)) + geom_point() +
  labs(title = "Eccentricity of Sentinel-6A satellite over time", 
       x  = "Time",
       y = "Eccentricity") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                axis.text = element_text(size = 30),
                                                axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-6A-Eccentricity-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)
# Sentinel-6A Argument of Perigee
sent6a |> ggplot(aes(x = ...1, y = `argument of perigee`)) + geom_point() +
  labs(title = "Argument of Perigee of Sentinel-6A satellite over time", 
       x  = "Time",
       y = "Argument of Perigee") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                       axis.text = element_text(size = 30),
                                                       axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-6A-Argument-of-Perigee-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Sentinel-6A Inclination
sent6a |> ggplot(aes(x = ...1, y = inclination)) + geom_point() +
  labs(title = "Inclination of Sentinel-6A satellite over time", 
       x  = "Time",
       y = "Inclination") + theme_bw() + theme(plot.title = element_text(size = 30),
                                               axis.text = element_text(size = 30),
                                               axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-6A-Inclination-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)
# Sentinel-6A Mean Anomaly
sent6a |> ggplot(aes(x = ...1, y = `mean anomaly`)) + geom_point() +
  labs(title = "Mean Anomaly of Sentinel-6A satellite over time", 
       x  = "Time",
       y = "Mean Anomaly") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                axis.text = element_text(size = 30),
                                                axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-6A-Mean-Anomaly-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)

# Sentinel-6A Mean Anomaly
sent6a |> ggplot(aes(x = ...1, y = `Brouwer mean motion`)) + geom_point() +
  labs(title = "Brouwer Mean Motion of Sentinel-6A satellite over time", 
       x  = "Time",
       y = "Brouwer Mean Motion") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                       axis.text = element_text(size = 30),
                                                       axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-6A-Brouwer-Mean_Motion-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)


# Sentinel-6A Right Ascension
sent6a |> ggplot(aes(x = ...1, y = `right ascension`)) + geom_point() +
  labs(title = "Right Ascension of Sentinel-6A satellite over time", 
       x  = "Time",
       y = "Right Ascension") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                   axis.text = element_text(size = 30),
                                                   axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-6A-Right-Ascension-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)



# Sentinel-3B Eccentricity
sent3b |> ggplot(aes(x = ...1, y = eccentricity)) + geom_point() +
  labs(title = "Eccentricity of Sentinel-3B satellite over time", 
       x  = "Time",
       y = "Eccentricity") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                axis.text = element_text(size = 30),
                                                axis.title = element_text(size = 30))
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
       y = "Argument of Perigee") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                       axis.text = element_text(size = 30),
                                                       axis.title = element_text(size = 30))
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
       y = "Inclination") + theme_bw() + theme(plot.title = element_text(size = 30),
                                               axis.text = element_text(size = 30),
                                               axis.title = element_text(size = 30))
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
       y = "Mean Anomaly") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                axis.text = element_text(size = 30),
                                                axis.title = element_text(size = 30))
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
       y = "Brouwer Mean Motion") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                       axis.text = element_text(size = 30),
                                                       axis.title = element_text(size = 30))
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
       y = "Right Ascension") + theme_bw() + theme(plot.title = element_text(size = 30),
                                                   axis.text = element_text(size = 30),
                                                   axis.title = element_text(size = 30))
# Save plot in the pretty pictures folder, in the EDA plots directory
ggsave(here::here("pretty-pictures", "EDA-plots", 
                  "Sentinel-3B-Right-Ascension-vs-time.pdf"),
       plot = last_plot(),
       width = 16,
       height = 9,
       units = "in",
       dpi = 500)



