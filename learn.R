library(tidymodels)
library(tidyverse)

# So I can actually what is going on during logging later on
options(tidymodels.dark=TRUE)

# Defining metrics for both training and testing
metrics <- metric_set(rmse)

# Get the data
life_expectancy <- read_csv('life-expectancy.csv')

# Only consider 2014 (next most recent and nearly complete data) data
life_expectancy <- life_expectancy %>% filter(year == 2014)

# Drop year
life_expectancy <- life_expectancy %>% select(-year)
# life_expectancy <- life_expectancy %>% select(-country)

# population and gdp appear to be highly unreliable
life_expectancy <- life_expectancy %>% select(-gdp, -population)

# Convert status to factor
life_expectancy$status <- as.factor(life_expectancy$status)

# Impute several variables
#
# I'll just use median for everything unless the outcomes are bad
for (column in c(
  'alcohol',
  'hepatitis_b',
  'bmi',
  'total_expenditure',
  'thinness_1_19_years',
  'thinness_5_9_years',
  'income_composition_of_resources',
  'schooling'
)) {
  life_expectancy[[column]] <- ifelse(is.na(life_expectancy[[column]]), median(life_expectancy[[column]], na.rm = TRUE), life_expectancy[[column]])
}

# Split into training and testing datasets 80/20
set.seed(42)
life_expectancy_split <- initial_split(life_expectancy, prop=0.8)
life_expectancy_training <- training(life_expectancy_split)
life_expectancy_test <- testing(life_expectancy_split)

# Create preprocessing recipe for creating dummy variables and leave out country
life_expectancy_recipe <- recipe(life_expectancy ~ ., data=life_expectancy_training) %>%
  step_rm(country) %>%
  step_dummy(all_nominal_predictors())

# Create SVM specification 
svm_specification <- svm_rbf() %>%
  set_mode('regression') %>%
  set_engine('kernlab')

# Create new workflow for CV
svm_workflow <- workflow() %>%
  add_recipe(life_expectancy_recipe) %>%
  add_model(svm_specification)

# Create cross validation folds
set.seed(42)
life_expectancy_folds <- vfold_cv(life_expectancy_training)

# Evaluate performance on training set
print('Evaluating performance on training set:')

svm_resampled <- fit_resamples(
  svm_workflow,
  life_expectancy_folds,
  control=control_resamples(save_pred=TRUE, verbose=TRUE),
  metrics=metrics
)

print(collect_metrics(svm_resampled))
print(collect_predictions(svm_resampled))

# Evaluate performance on test set
print('Evaluating performance on test set:')
  
final_fit <- last_fit(svm_workflow, life_expectancy_split, metrics=metrics)

print(collect_metrics(final_fit))
print(collect_predictions(final_fit))

print('Printing out test predictions:')

test_rows <- life_expectancy[collect_predictions(final_fit)[['.row']], ]
test_predictions <- collect_predictions(final_fit)[['.pred']]
test_rows <- test_rows %>%
  add_column(test_predictions) %>%
  rename(prediction=test_predictions) %>%
  select(country, life_expectancy, prediction)
