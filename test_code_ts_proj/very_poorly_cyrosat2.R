pacman::p_load(tidyverse, lubridate)
# Read the tle_parsed
tle_tle_parsed <- readLines(here::here("satellite_data","manoeuvres", "cs2man.txt"))

# Split tle_parsed by multiple spaces using read.table
tle_parsed <- read.table(text = tle_tle_parsed, header = FALSE, fill = TRUE, 
                         sep = "", strip.white = TRUE)

# View the parsed tle_parsed
print(tle_parsed)

# Rename columns manually
colnames(tle_parsed) <- c("satellite_name",     # Col 1: Satellite identification
                          "beg_man_year",       # Col 2: Beginning of maneuver: Year
                          "beg_man_day",        # Col 3: Beginning of maneuver: Day of year
                          "beg_man_hour",       # Col 4: Beginning of maneuver: hour
                          "beg_man_min",        # Col 5: Beginning of maneuver: minute
                          "end_man_year",       # Col 6: End of maneuver: Year
                          "end_man_day",        # Col 7 : End of maneuver: Day of year
                          "end_man_hour",       # Col 8: End of maneuver: hour
                          "end_man_min",        # Col 9: End of maneuver: minute (last column for topex)
                          "man_parameter_type", # Col 10: Maneuver parameter type
                          "num_burns",          # Col 11: number of burns (N)
                          "med_man_year",       # Col 12: median date of maneuver: Year YYYY
                          "med_man_day"        # Col 13: median date of maneuver: Day of year DDD
                          )
# View the renamed columns
head(tle_parsed)


# Create beginning and end maneuver datetime
tle_parsed$beg_man_datetime <- as_datetime(paste0(tle_parsed$beg_man_year, "-01-01")) +
  days(tle_parsed$beg_man_day) + hours(tle_parsed$beg_man_hour) + minutes(tle_parsed$beg_man_min)

tle_parsed$end_man_datetime <- as_datetime(paste0(tle_parsed$end_man_year, "-01-01")) +
  days(tle_parsed$end_man_day) + hours(tle_parsed$end_man_hour) + minutes(tle_parsed$end_man_min)

# View the tle_parsed
print(tle_parsed)

tle_parsed_time <- tle_parsed |> select(beg_man_datetime, end_man_datetime)

class(tle_parsed_time$beg_man_datetime)

head(df)

# Initialize an empty tibble to store the filtered rows
filtered_df <- tibble()

# Loop over each row in tle_parsed (beg_man_datetime and end_man_datetime)
for (i in 1:nrow(tle_parsed)) {
  # Filter df for the current maneuver time interval
  temp_filtered <- df %>%
    filter(...1 >= tle_parsed_time$beg_man_datetime[i] & ...1 <= tle_parsed_time$end_man_datetime[i])
  
  # Bind the results to the filtered_df
  filtered_df <- bind_rows(filtered_df, temp_filtered)
}

# View the filtered data
print(filtered_df)

df
df |> ggplot(aes(x = ...1, y= `Brouwer mean motion`)) + geom_point() + geom_point(data = filtered_df, aes(x = ...1, y =`Brouwer mean motion`, col = "green"))
