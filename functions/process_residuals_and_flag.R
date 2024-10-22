process_residuals_and_flags <- function(arima_models) {
  # Safely extract residuals from each ARIMA model
  extract_residuals <- function(model) {
    # If model is an ARIMA object, it should have residuals
    if (is.list(model) && !is.null(model$residuals)) {
      return(model$residuals)
    } else {
      stop("Model does not have residuals")
    }
  }
  
  # Extract residuals from each ARIMA model
  residuals_list <- map(arima_models, extract_residuals)
  
  # Calculate confidence intervals for each parameter
  CI_list <- map(arima_models, calculate_CI)
  
  # Create a residuals data frame with all parameters
  res_data <- residuals_list %>%
    set_names(names(arima_models)) %>%
    bind_cols()
  
  # Add flag column to res_data for each parameter
  for (param in names(res_data)) {
    CI_low <- CI_list[[param]][1]
    CI_up  <- CI_list[[param]][2]
    res_data[[paste0(param, "_flag")]] <- flag_outliers(res_data[[param]], CI_low, CI_up)
  }
  
  return(res_data)
}
