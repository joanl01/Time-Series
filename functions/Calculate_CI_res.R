calculate_CI_res <- function(res){
  mean_res <- mean(res, na.rm = TRUE)
  sd_res <- sd(res, na.rm = TRUE)
  n <- length(res)
  
  CI_low <- mean_res - 2 * sd_res/sqrt(n)
  CI_up  <- mean_res + 2 * sd_res/sqrt(n)
  return(c(CI_low, CI_up))
}