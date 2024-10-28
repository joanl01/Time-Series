calculate_CI_res <- function(res, sig_lvl = 0.05){
  mean_res <- mean(res, na.rm = TRUE)
  sd_res <- sd(res, na.rm = TRUE)
  n <- length(res)
  
  CI_low <- mean_res - qnorm(1- sig_lvl) * sd_res / sqrt(n)
  CI_up  <- mean_res + qnorm(1-sig_lvl) * sd_res / sqrt(n)
  return(c(CI_low, CI_up))
}