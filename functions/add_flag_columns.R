# Define a function to add flag columns based on confidence intervals
add_flag_columns <- function(data, CI_data, parameters) {
  
  # Loop through each parameter and add a flag column
  for (param in parameters) {
    # Get the confidence interval for the parameter
    CI_low <- CI_data[[param]][1]
    CI_high <- CI_data[[param]][2]
    
    # Create a flag column name
    flag_col_name <- paste0("flag_", gsub(" ", "_", param))
    
    # Apply within_interval check for each parameter and create flag column
    data[[flag_col_name]] <- ifelse(data[[param]] >= CI_low & data[[param]] <= CI_high, 0, 1)
  }
  
  return(data)
}