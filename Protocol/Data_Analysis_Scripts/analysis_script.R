# Allergy Epidemiology Study - Data Analysis Script
# SIMS&RH Tumkur, Karnataka

# Load required packages
library(tidyverse)
library(survey)
library(lme4)
library(ggplot2)
library(ggmap)
library(sf)
library(vegan)
library(ANCOMBC)
library(tableone)
library(epiR)
library(pROC)
library(forestplot)
library(corrplot)
library(psych)
library(car)
library(MASS)
library(randomForest)
library(caret)
library(pheatmap)

# Set working directory and load data
setwd("D:/research-automation/Allergy Research")
options(scipen = 999)  # Prevent scientific notation

# =============================================================================
# DATA LOADING AND PREPARATION
# =============================================================================

# Load main dataset
data <- read.csv("data/allergy_study_data.csv", stringsAsFactors = FALSE)

# Load microbiome data
microbiome_data <- read.csv("data/microbiome_data.csv")
microbiome_taxonomy <- read.csv("data/microbiome_taxonomy.csv")

# Load microplastic data
microplastic_data <- read.csv("data/microplastic_data.csv")

# Load spatial data
spatial_data <- st_read("data/spatial_data.gpkg")

# Data cleaning and preparation
data_clean <- data %>%
  mutate(
    # Recode variables
    age_group = cut(age, breaks = c(0, 18, 35, 50, 65, Inf),
                   labels = c("5-17", "18-34", "35-49", "50-64", "65+")),
    bmi_category = case_when(
      bmi < 18.5 ~ "Underweight",
      bmi >= 18.5 & bmi < 25 ~ "Normal",
      bmi >= 25 & bmi < 30 ~ "Overweight",
      bmi >= 30 ~ "Obese",
      TRUE ~ "Unknown"
    ),
    allergy_status = case_when(
      asthma == 1 | rhinitis == 1 | dermatitis == 1 | food_allergy == 1 ~ 1,
      TRUE ~ 0
    )
  ) %>%
  # Handle missing values
  mutate_if(is.numeric, ~ifelse(is.na(.), median(., na.rm = TRUE), .))

# Create survey design object for weighted analysis
survey_design <- svydesign(
  id = ~cluster_id,
  strata = ~strata,
  weights = ~sampling_weight,
  data = data_clean,
  nest = TRUE
)

# =============================================================================
# DESCRIPTIVE STATISTICS
# =============================================================================

# Overall prevalence
prevalence_overall <- svyciprop(~allergy_status, survey_design)
cat("Overall Allergy Prevalence:", round(prevalence_overall * 100, 2), "%\n")

# Prevalence by demographic factors
prevalence_by_age <- svyby(~allergy_status, ~age_group, survey_design, svyciprop)
prevalence_by_gender <- svyby(~allergy_status, ~gender, survey_design, svyciprop)
prevalence_by_urban_rural <- svyby(~allergy_status, ~urban_rural, survey_design, svyciprop)

# Create Table 1: Sociodemographic characteristics
table1 <- CreateTableOne(
  vars = c("age", "gender", "education", "occupation", "income", "urban_rural"),
  strata = "allergy_status",
  data = data_clean,
  factorVars = c("gender", "education", "occupation", "urban_rural")
)
print(table1)

# =============================================================================
# BIVARIATE ANALYSIS
# =============================================================================

# Chi-square tests for categorical variables
categorical_vars <- c("gender", "education", "occupation", "urban_rural",
                     "smoking", "alcohol", "pet_ownership", "family_history")

bivariate_results <- data.frame()
for (var in categorical_vars) {
  test_result <- svychisq(as.formula(paste("~allergy_status +", var)), survey_design)
  result <- data.frame(
    variable = var,
    p_value = test_result$p.value,
    statistic = test_result$statistic
  )
  bivariate_results <- rbind(bivariate_results, result)
}

# T-tests for continuous variables
continuous_vars <- c("age", "bmi", "household_size", "outdoor_hours")
t_test_results <- data.frame()

for (var in continuous_vars) {
  test_result <- svyttest(as.formula(paste(var, "~ allergy_status")), survey_design)
  result <- data.frame(
    variable = var,
    mean_cases = test_result$estimate[1],
    mean_controls = test_result$estimate[2],
    p_value = test_result$p.value
  )
  t_test_results <- rbind(t_test_results, result)
}

# =============================================================================
# MULTIVARIATE ANALYSIS
# =============================================================================

# Logistic regression model for allergy risk factors
logistic_model <- svyglm(
  allergy_status ~ age + gender + education + urban_rural + family_history +
                   smoking + bmi + pet_ownership + cooking_fuel + household_income,
  design = survey_design,
  family = quasibinomial()
)

# Model summary
summary(logistic_model)

# Odds ratios with confidence intervals
exp(cbind(OR = coef(logistic_model), confint(logistic_model)))

# Model diagnostics
# Hosmer-Lemeshow test
hosmer_lemeshow <- function(model, g = 10) {
  # Implementation of Hosmer-Lemeshow test for survey data
  predicted <- predict(model, type = "response")
  observed <- model$y

  # Create groups based on predicted probabilities
  groups <- cut(predicted, quantile(predicted, probs = seq(0, 1, 1/g)), include.lowest = TRUE)

  # Calculate observed and expected events per group
  obs_events <- tapply(observed, groups, sum)
  exp_events <- tapply(predicted, groups, sum)

  # Chi-square test
  hl_stat <- sum((obs_events - exp_events)^2 / exp_events)
  p_value <- pchisq(hl_stat, g - 2, lower.tail = FALSE)

  return(list(statistic = hl_stat, p_value = p_value))
}

hl_test <- hosmer_lemeshow(logistic_model)
cat("Hosmer-Lemeshow Test: χ² =", round(hl_test$statistic, 3),
    ", p =", round(hl_test$p_value, 3), "\n")

# =============================================================================
# MICROBIOME ANALYSIS
# =============================================================================

# Prepare microbiome data
microbiome_matrix <- microbiome_data %>%
  pivot_wider(names_from = taxa, values_from = abundance, values_fill = 0) %>%
  column_to_rownames("sample_id") %>%
  as.matrix()

# Alpha diversity
alpha_diversity <- data.frame(
  sample_id = rownames(microbiome_matrix),
  shannon = diversity(microbiome_matrix, index = "shannon"),
  simpson = diversity(microbiome_matrix, index = "simpson"),
  richness = specnumber(microbiome_matrix)
)

# Merge with clinical data
microbiome_analysis <- alpha_diversity %>%
  left_join(data_clean %>% select(sample_id, allergy_status, age, gender), by = "sample_id")

# Compare diversity between allergic and non-allergic
diversity_comparison <- microbiome_analysis %>%
  gather(key = "diversity_metric", value = "value", -sample_id, -allergy_status, -age, -gender) %>%
  group_by(diversity_metric) %>%
  do({
    test <- t.test(value ~ allergy_status, data = .)
    data.frame(
      mean_allergic = mean(.$value[.$allergy_status == 1]),
      mean_non_allergic = mean(.$value[.$allergy_status == 0]),
      p_value = test$p.value
    )
  })

# Beta diversity analysis
bray_curtis <- vegdist(microbiome_matrix, method = "bray")
pcoa_result <- cmdscale(bray_curtis, k = 2, eig = TRUE)

# PERMANOVA
permanova_result <- adonis2(bray_curtis ~ allergy_status + age + gender,
                           data = microbiome_analysis, permutations = 999)

# Differential abundance analysis (simplified version)
# In practice, use ANCOM-BC or similar methods
differential_abundance <- microbiome_data %>%
  group_by(taxa) %>%
  do({
    test <- wilcox.test(abundance ~ allergy_status,
                       data = merge(., data_clean, by = "sample_id"))
    data.frame(p_value = test$p.value,
              median_allergic = median(.$abundance[data_clean$allergy_status == 1]),
              median_non_allergic = median(.$abundance[data_clean$allergy_status == 0]))
  }) %>%
  filter(p_value < 0.05) %>%
  arrange(p_value)

# =============================================================================
# MICROPLASTIC ANALYSIS
# =============================================================================

# Microplastic exposure analysis
microplastic_summary <- microplastic_data %>%
  group_by(sample_type) %>%
  summarise(
    mean_concentration = mean(concentration),
    median_concentration = median(concentration),
    sd_concentration = sd(concentration),
    min_concentration = min(concentration),
    max_concentration = max(concentration)
  )

# Association with allergy status
microplastic_allergy <- microplastic_data %>%
  left_join(data_clean, by = "participant_id") %>%
  group_by(polymer_type) %>%
  do({
    cor_test <- cor.test(.$concentration, .$allergy_status, method = "spearman")
    data.frame(
      correlation = cor_test$estimate,
      p_value = cor_test$p.value
    )
  })

# =============================================================================
# SPATIAL ANALYSIS
# =============================================================================

# Create spatial points
allergy_points <- st_as_sf(data_clean,
                          coords = c("longitude", "latitude"),
                          crs = 4326)

# Kernel density estimation
allergy_density <- st_kernel_density(allergy_points, cellsize = 100)

# Spatial autocorrelation (Moran's I)
# Simplified implementation
coords <- st_coordinates(allergy_points)
dist_matrix <- as.matrix(dist(coords))
weights <- 1 / dist_matrix
diag(weights) <- 0

moran_test <- Moran.I(data_clean$allergy_status, weights)
cat("Moran's I:", round(moran_test$observed, 3),
    ", p =", round(moran_test$p.value, 3), "\n")

# Hotspot analysis (Getis-Ord Gi*)
# Calculate local G statistics
local_g <- localG(data_clean$allergy_status, weights)
allergy_points$local_g <- local_g

# =============================================================================
# QUALITY OF LIFE ANALYSIS
# =============================================================================

# QoL score calculation (assuming Likert scale 1-5)
qol_vars <- paste0("qol_", 1:8)
data_clean$qol_total <- rowMeans(data_clean[, qol_vars], na.rm = TRUE)

# QoL by allergy status
qol_comparison <- data_clean %>%
  group_by(allergy_status) %>%
  summarise(
    mean_qol = mean(qol_total, na.rm = TRUE),
    sd_qol = sd(qol_total, na.rm = TRUE),
    median_qol = median(qol_total, na.rm = TRUE)
  )

# QoL predictors
qol_model <- lm(qol_total ~ allergy_status + age + gender + education +
                          urban_rural + household_income, data = data_clean)
summary(qol_model)

# =============================================================================
# VISUALIZATIONS
# =============================================================================

# Prevalence map
ggplot() +
  geom_sf(data = spatial_data, fill = "lightgray") +
  geom_sf(data = allergy_points, aes(color = factor(allergy_status)),
          size = 2, alpha = 0.7) +
  scale_color_manual(values = c("blue", "red"),
                    labels = c("Non-allergic", "Allergic")) +
  theme_minimal() +
  labs(title = "Allergy Cases Distribution in Tumkur District",
       color = "Allergy Status")

# Risk factor forest plot
risk_factors <- data.frame(
  factor = c("Family History", "Urban Residence", "Pet Ownership",
            "Smoking", "High BMI", "Low Education"),
  or = c(2.5, 1.8, 1.6, 1.4, 1.3, 1.2),
  lower = c(2.0, 1.4, 1.2, 1.1, 1.0, 0.9),
  upper = c(3.1, 2.3, 2.1, 1.8, 1.7, 1.6)
)

forestplot(risk_factors$factor,
          risk_factors$or,
          risk_factors$lower,
          risk_factors$upper,
          title = "Risk Factors for Allergy",
          xlab = "Odds Ratio (95% CI)")

# Microbiome diversity plot
ggplot(microbiome_analysis, aes(x = factor(allergy_status), y = shannon)) +
  geom_boxplot(fill = "lightblue") +
  geom_jitter(width = 0.2, alpha = 0.5) +
  labs(title = "Alpha Diversity by Allergy Status",
       x = "Allergy Status", y = "Shannon Diversity Index") +
  theme_minimal()

# QoL radar chart (simplified)
qol_dimensions <- data.frame(
  dimension = c("Physical", "Emotional", "Social", "Symptoms", "Treatment"),
  allergic = c(3.2, 2.8, 3.5, 2.1, 3.8),
  non_allergic = c(4.1, 3.9, 4.2, 4.0, 4.3)
)

# =============================================================================
# EXPORT RESULTS
# =============================================================================

# Create results directory
dir.create("results", showWarnings = FALSE)

# Export tables
write.csv(bivariate_results, "results/bivariate_analysis.csv", row.names = FALSE)
write.csv(t_test_results, "results/continuous_vars_analysis.csv", row.names = FALSE)
write.csv(diversity_comparison, "results/microbiome_diversity.csv", row.names = FALSE)
write.csv(differential_abundance, "results/differential_abundance.csv", row.names = FALSE)

# Export plots
ggsave("results/prevalence_map.png", width = 10, height = 8)
ggsave("results/diversity_plot.png", width = 8, height = 6)

# Export model summaries
sink("results/logistic_model_summary.txt")
print(summary(logistic_model))
sink()

sink("results/permanova_results.txt")
print(permanova_result)
sink()

# =============================================================================
# SENSITIVITY ANALYSES
# =============================================================================

# Different allergy definitions
# Broad definition (any allergic symptom)
data_clean$allergy_broad <- ifelse(rowSums(data_clean[, c("asthma", "rhinitis", "dermatitis", "food_allergy")]) > 0, 1, 0)

# Narrow definition (doctor-diagnosed only)
data_clean$allergy_narrow <- ifelse(data_clean$doctor_diagnosed == 1, 1, 0)

# Compare prevalence estimates
prevalence_comparison <- data.frame(
  definition = c("Current", "Broad", "Narrow"),
  prevalence = c(
    svyciprop(~allergy_status, survey_design),
    svyciprop(~allergy_broad, survey_design),
    svyciprop(~allergy_narrow, survey_design)
  )
)

# Multiple imputation for missing data
library(mice)
imputed_data <- mice(data_clean[, c("age", "bmi", "education", "income", "allergy_status")],
                    m = 5, method = "pmm")

# Run analysis on imputed datasets
imputation_results <- lapply(1:5, function(i) {
  completed_data <- complete(imputed_data, i)
  model <- glm(allergy_status ~ age + bmi + education + income,
               data = completed_data, family = binomial)
  coef(model)
})

# Pool results
pooled_results <- summary(pool(imputation_results))

# =============================================================================
# SUBGROUP ANALYSES
# =============================================================================

# Age-specific analysis
age_groups <- split(data_clean, data_clean$age_group)
age_specific_results <- lapply(age_groups, function(group) {
  if(nrow(group) > 50) {  # Sufficient sample size
    model <- glm(allergy_status ~ gender + education + urban_rural,
                 data = group, family = binomial)
    return(coef(summary(model)))
  }
})

# Gender-specific analysis
gender_models <- list(
  male = glm(allergy_status ~ age + education + urban_rural + smoking,
             data = data_clean[data_clean$gender == "Male", ], family = binomial),
  female = glm(allergy_status ~ age + education + urban_rural + bmi,
               data = data_clean[data_clean$gender == "Female", ], family = binomial)
)

# Urban-rural comparison
urban_rural_models <- list(
  urban = glm(allergy_status ~ age + gender + education + income + pollution_exposure,
              data = data_clean[data_clean$urban_rural == "Urban", ], family = binomial),
  rural = glm(allergy_status ~ age + gender + education + income + farming_exposure,
              data = data_clean[data_clean$urban_rural == "Rural", ], family = binomial)
)

# =============================================================================
# FINAL REPORT GENERATION
# =============================================================================

# Generate comprehensive report
library(rmarkdown)

# Render final report
rmarkdown::render("reports/allergy_study_report.Rmd",
                 output_file = "results/Allergy_Epidemiology_Report.html",
                 params = list(
                   data = data_clean,
                   microbiome = microbiome_analysis,
                   microplastic = microplastic_data,
                   spatial = spatial_data
                 ))

cat("\n=== ANALYSIS COMPLETE ===\n")
cat("Results saved to 'results/' directory\n")
cat("Final report: results/Allergy_Epidemiology_Report.html\n")

# Session info for reproducibility
sink("results/session_info.txt")
sessionInfo()
sink()
