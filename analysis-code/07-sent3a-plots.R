# Load necessary libraries
pacman::p_load(tidyverse, pROC, PRROC,caret, yardstick)
# Ensure all anomaly flags are binary (0 or 1) and 'true_maneuver' is logical
sent3a_binned_anom <- sent3a_binned_anom %>%
  mutate(across(starts_with("flag_"), ~ ifelse(. > 0, 1, 0)))

# List of anomaly flag variables
variables <- c("flag_eccentricity", "flag_argument of perigee", "flag_inclination", 
               "flag_mean anomaly", "flag_Brouwer mean motion", "flag_right ascension")

# Initialize lists to store plots for each variable
roc_plots <- list()
pr_plots <- list()
auc <- list()
# Loop through `length<-.factor`()# Loop through each variable to calculate and plot ROC and Precision-Recall curves
for (var in variables) {
  
  # Define predictions and true labels
  predictions <- as.numeric(sent3a_binned_anom[[var]])  # Ensure binary numeric format (0 and 1)
  true_labels <- as.numeric(sent3a_binned_anom$true_maneuver)  # Convert logical to numeric for consistency
  
  # Compute ROC Curve
  roc_obj <- roc(true_labels,predictions)
  auc[var] <- auc(roc_obj)
  # Plot ROC Curve
  roc_plot <- ggroc(roc_obj) +
    ggtitle(paste("ROC Curve for", var)) +
    xlab("False Positive Rate") +
    ylab("True Positive Rate") + theme_bw() + 
    geom_abline(intercept = 1, slope = 1,
                color = "darkgrey", linetype = "dashed")
  roc_plots[[var]] <- roc_plot
}

# Display ROC and Precision-Recall plots for each variable
print(roc_plots)
auc


plot(pr.curve(sent3a_binned_anom$`flag_Brouwer mean motion`,
              sent3a_binned_anom$true_maneuver, curve = TRUE),
     main = "Precision-Recall Curve for Brouwer mean motion")
