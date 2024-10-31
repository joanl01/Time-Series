# Function to calculate confidence intervals for residuals
calculate_CI <- function(model) {
  residuals <- model$residuals
  
  # Ensure residuals are numeric
  if (!is.numeric(residuals)) {
    stop("Residuals are not numeric. Check the model.")
  }
  
  mean_res <- mean(residuals, na.rm = TRUE)
  sd_res <- sd(residuals, na.rm = TRUE)
  n <- length(residuals)
  
  CI_low <- mean_res - 3 * sd_res/sqrt(n)
  CI_up  <- mean_res + 3 * sd_res/sqrt(n)
  
  return(c(CI_low, CI_up))
}
