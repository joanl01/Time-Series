pacman::p_load(tidyverse, lubridate)

# Read the data
tle_data <- readLines(here::here("satellite_data","manoeuvres", "s3aman.txt"))

# Split data by multiple spaces using read.table
tle_parsed <- read.table(text = tle_data, header = FALSE, fill = TRUE, 
                         sep = "", strip.white = TRUE)

# View the parsed data
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
                          "med_man_day",        # Col 13: median date of maneuver: Day of year DDD
                          "med_man_hour",       # Col 14: median date of maneuver: hour HH
                          "med_man_min",        # Col 15: median date of maneuver: minute MM
                          "med_man_sec",        # Col 16: median date of maneuver: second.mlsecond:  SS.mss
                          "boost_duration",     # Col 17: boost duration (sec) [E20.13]
                          "DV_1",               # Col 18: DV(1) (m/s)  [E20.13]
                          "DV_2",               # Col 19: DV(2) (m/s)  [E20.13]
                          "DV_3",               # Col 20: DV(3) (m/s)  [E20.13]
                          "acc_1",              # Col 21: acceleration, acc(1) (10-6m/s2)  [E20.13]
                          "acc_2",              # Col 22: acceleration, acc(2) (10-6m/s2)  [E20.13]
                          "acc_3",              # Col 23: acceleration, acc(3) (10-6m/s2)  [E20.13]
                          "delta_acc_1",        # Col 24: delta acc(1) wrt prediction (10-6m/s2)[E20.13]
                          "delta_acc_2",        # Col 25: delta acc(2) wrt prediction (10-6m/s2)[E20.13]
                          "delta_acc_3",        # Col 26: delta acc(3) wrt prediction (10-6m/s2)[E20.13]
                          "med_man_year_burn2", # Col 27: median date of maneuver: Year YYYY
                          "med_man_day_burn2",  # Col 28: median date of maneuver: Day of year DDD
                          "med_man_hour_burn2", # Col 29: median date of maneuver: hour HH
                          "med_man_min_burn2",  # Col 30: median date of maneuver: minute MM
                          "med_man_sec_burn2",  # Col 31: median date of maneuver: second.mlsecond:  SS.mss
                          "boost_duration_burn2", # Col 32: boost duration (sec) [E20.13]
                          "DV_1_burn2",         # Col 33: DV(1) (m/s)  [E20.13]
                          "DV_2_burn2",         # Col 34: DV(2) (m/s)  [E20.13]
                          "DV_3_burn2",         # Col 35: DV(3) (m/s)  [E20.13]
                          "acc_1_burn2",        # Col 36: acceleration, acc(1) (10-6m/s2)  [E20.13]
                          "acc_2_burn2",        # Col 37: acceleration, acc(2) (10-6m/s2)  [E20.13]
                          "acc_3_burn2",        # Col 38: acceleration, acc(3) (10-6m/s2)  [E20.13]
                          "delta_acc_1_burn2",  # Col 39: delta acc(1) wrt prediction (10-6m/s2)[E20.13]
                          "delta_acc_2_burn2",  # Col 40: delta acc(2) wrt prediction (10-6m/s2)[E20.13]
                          "delta_acc_3_burn2" # Col 41: delta acc(3) wrt prediction (10-6m/s2)[E20.13]
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
sent3a_tle_parsed_time <- tle_parsed_time %>% mutate(date = as.Date(end_man_datetime))
