library(pacman)
pacman::p_load(tidyverse, emmeans, MASS, boot, robustlmm, dplyr, lmtest, fitdistrplus, car, ggpubr, ggplot2, ggthemes, plyr, lme4, RColorBrewer, reshape2, afex, emmeans, psych, lmerTest, compare, rstatix, ggExtra, gridExtra, ggeffects, modelr, boot, stats)
setwd("C:/Users/trb938/OneDrive - University of Copenhagen/MATLAB/Graphpad tables")

#load data
df <- read_csv('auc_diff_table.csv')
df$EventVar <- as.factor(df$EventVar)
df$EventVar <- factor(df$EventVar, levels = c("NREMexclMA_periods_pklocs", "NREM_before_MA_short", "NREM_before_MA_long", "SWS_before_wake_pklocs"))
df$SubjectID <- as.factor(df$SubjectID)


m_h1 <- lmer(formula = NE ~  EventVar + (1|SubjectID), data = df)
m_h2 <- lmer(formula = NE ~  EventVar + (EventVar|SubjectID), data = df)
anova(m_h1, m_h2) # M1 better
summary(m_h1)

# Example usage with your model
check_lmm_assumptions(m_h1)

# Calculate estimated marginal means
emm <- emmeans(m_h1, ~ EventVar)

# Perform pairwise comparisons with Tukey adjustment
pairwise_comparisons <- pairs(emm, adjust = "tukey")

# Print pairwise comparisons
print(pairwise_comparisons)



# Function to check assumptions of linear mixed effects model
check_lmm_assumptions <- function(model) {
  # Linearity
  print("Checking linearity...")
  plot(model)
  
  # Normality of residuals
  print("Checking normality of residuals...")
  residuals <- resid(model)
  
  # Debugging: Simple histogram of residuals
  hist(residuals, breaks = 30, main = "Histogram of Residuals", xlab = "Residuals", col = "blue", border = "black")
  
  # Create histogram with density fits
  hist_data <- data.frame(residuals = residuals)
  ggplot(hist_data, aes(x = residuals)) +
    geom_histogram(aes(y = ..density..), bins = 30, fill = "blue", alpha = 0.5) +
    stat_function(fun = dnorm, args = list(mean = mean(hist_data$residuals), sd = sd(hist_data$residuals)), color = "red", linewidth = 1) +
    stat_function(fun = function(x) dgamma(x - min(hist_data$residuals) + 0.001, shape = 2, scale = 1), color = "green", linewidth = 1) +
    stat_function(fun = function(x) dweibull(x - min(hist_data$residuals) + 0.001, shape = 2, scale = 1), color = "purple", linewidth = 1) +
    stat_function(fun = function(x) dunif(x, min = min(hist_data$residuals), max = max(hist_data$residuals)), color = "orange", linewidth = 1) +
    ggtitle("Histogram of Residuals with Distribution Fits") +
    theme_minimal()
  
  # Homoscedasticity
  print("Checking homoscedasticity...")
  fitted_values <- fitted(model)
  plot(fitted_values, residuals, main = "Residuals vs Fitted Values")
  abline(h = 0, col = "red")
  
  # Breusch-Pagan Test for homoscedasticity
  bptest_result <- bptest(residuals ~ fitted_values)
  print(bptest_result)
  
  # Independence
  print("Checking independence of residuals...")
  acf(residuals, main = "ACF of residuals")
  
  # Random effects
  print("Checking random effects...")
  ranef_model <- ranef(model, condVar = TRUE)
  qqnorm(unlist(ranef_model$SubjectID))
  qqline(unlist(ranef_model$SubjectID))
  
  print("Assumptions check completed.")
}

# Define the function
perform_bootstrap_pairwise <- function(data, formula, group_var, subject_var, R = 1000) {
  # Fit the initial model
  initial_model <- lmer(formula, data = data)
  
  # Define the bootstrapping function
  boot_model <- function(data, indices) {
    d <- data[indices, ]  # Allows boot to select sample
    model <- try(lmer(formula, data = d, control = lmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 1e5))), silent = TRUE)
    if (inherits(model, "try-error")) {
      return(rep(NA, length(fixef(initial_model))))  # Return NA if model fails
    } else {
      emm <- emmeans(model, as.formula(paste("~", group_var)))
      pairs(emm)$estimate  # Return pairwise differences
    }
  }
  
  # Apply bootstrapping with R replications
  results <- boot(data = data, statistic = boot_model, R = R)
  
  # Filter out NA results due to non-converging models
  valid_results <- results$t[!apply(results$t, 1, function(x) any(is.na(x))),]
  
  # Check the number of valid bootstrap samples
  cat("Number of valid bootstrap samples:", nrow(valid_results), "\n")
  
  # Recreate the boot object with only valid results
  boot_results <- results
  boot_results$t <- valid_results
  boot_results$R <- nrow(valid_results)
  
  # Calculate bootstrap confidence intervals for pairwise comparisons
  boot_ci <- function(estimates) {
    apply(estimates, 2, function(col) {
      quantile(col, c(0.025, 0.975))
    })
  }
  
  pairwise_ci <- boot_ci(valid_results)
  
  # Return the bootstrap confidence intervals for pairwise comparisons
  return(pairwise_ci)
}

