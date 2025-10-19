###############################################
# Stroke Prediction Model in R
# Author: Adnan Ayub
###############################################

# Install and load packages
install.packages(c("tidyverse", "caret", "randomForest", "e1071", "xgboost"))
library(tidyverse)
library(caret)
library(randomForest)
library(e1071)
library(xgboost)

# Load dataset
data <- read_csv("healthcare-dataset-stroke-data.csv")

# Preprocessing
data <- data %>% select(-id)
data$bmi <- as.numeric(data$bmi)
data$bmi[is.na(data$bmi)] <- mean(data$bmi, na.rm = TRUE)
data <- data %>% mutate(across(c(gender, ever_married, work_type, Residence_type, smoking_status, stroke), as.factor))

# Split data
set.seed(123)
train_index <- createDataPartition(data$stroke, p = 0.8, list = FALSE)
train_data <- data[train_index, ]
test_data  <- data[-train_index, ]

# Random Forest Model
rf_model <- randomForest(stroke ~ ., data = train_data, ntree = 200)
rf_pred <- predict(rf_model, test_data)

# Logistic Regression Model
log_model <- glm(stroke ~ ., data = train_data, family = binomial)
log_pred <- predict(log_model, test_data, type = "response")
log_pred_class <- ifelse(log_pred > 0.5, 1, 0)

# XGBoost Model
x_train <- model.matrix(stroke ~ . -1, data = train_data)
y_train <- as.numeric(train_data$stroke) - 1
x_test  <- model.matrix(stroke ~ . -1, data = test_data)
y_test  <- as.numeric(test_data$stroke) - 1
xgb_model <- xgboost(data = x_train, label = y_train, nrounds = 100, objective = "binary:logistic")
xgb_pred <- predict(xgb_model, x_test)
xgb_pred_class <- ifelse(xgb_pred > 0.5, 1, 0)

# Evaluate
rf_cm <- confusionMatrix(rf_pred, test_data$stroke)
log_cm <- confusionMatrix(as.factor(log_pred_class), test_data$stroke)
xgb_cm <- confusionMatrix(as.factor(xgb_pred_class), test_data$stroke)

cat("Random Forest Accuracy:", rf_cm$overall["Accuracy"], "\n")
cat("Logistic Regression Accuracy:", log_cm$overall["Accuracy"], "\n")
cat("XGBoost Accuracy:", xgb_cm$overall["Accuracy"], "\n")

# Save model
saveRDS(rf_model, "final_stroke_rf_model.rds")
