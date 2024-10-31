#join the manoeuvre flags
sent3b_anom <- inner_join(sent3b_res, sent3b_res_data, by = "date")
# Parameters
bin_size <- 5  # Number of adjacent time points to combine in each bin

# List of variables to analyze based on the flag column names
variables <- c("eccentricity", "argument of perigee", "inclination", "mean anomaly", "Brouwer mean motion", "right ascension")

# Create bins
sent3b_anom <- sent3b_anom %>%
  arrange(datetime) %>%
  mutate(bin_id = (row_number() - 1) %/% bin_size)

# Aggregate flags within each bin for each variable using AND logic
sent3b_binned_anom <- sent3b_anom %>%
  group_by(bin_id) %>%
  summarise(
    date_bin = min(date),
    across(all_of(paste0(variables, "_flag")), 
           ~ ifelse(all(.x == 1), 1, 0), 
           .names = "flag_{sub('_flag$', '', .col)}"),
    .groups = 'drop'
  )


# Initialize the 'true_maneuver' column in 'sent3b_binned_anom' as FALSE
sent3b_binned_anom$true_maneuver <- numeric(nrow(sent3b_binned_anom))

# Loop through each maneuver date and each bin
for (i in 1:nrow(sent3b_tle_parsed_time)) {
  for (j in 1:(nrow(sent3b_binned_anom) - 1)) {  # Loop until the second-last row in 'sent3b_binned_anom'
    # Check if the maneuver date falls between the current bin and the next bin
    if (sent3b_tle_parsed_time$date[i] >= sent3b_binned_anom$date_bin[j] & sent3b_tle_parsed_time$date[i] < sent3b_binned_anom$date_bin[j + 1]) {
      sent3b_binned_anom$true_maneuver[j] <- 1
    }
  }
}

# Calculate performance metrics for each variable
# Create a list to store metrics for each variable
metrics_list <- map_dfr(variables, function(var) {
  sent3b_binned_anom %>%
    summarise(
      TP = sum(get(paste0("flag_", var)) == 1 & true_maneuver == 1),
      FP = sum(get(paste0("flag_", var)) == 1 & true_maneuver == 0),
      FN = sum(get(paste0("flag_", var)) == 0 & true_maneuver == 1),
      TN = sum(get(paste0("flag_", var)) == 0 & true_maneuver == 0),
      Variable = var
    ) %>%
    mutate(
      Precision = TP / (TP + FP),
      Recall = TP / (TP + FN)
    )
})

# Print results
print(metrics_list)
