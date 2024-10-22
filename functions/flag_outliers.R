# Function to flag residuals based on confidence intervals
flag_outliers <- function(residuals, CI_low, CI_up) {
  flags <- ifelse(residuals >= CI_low & residuals <= CI_up, 0, 1)
  return(flags)
}