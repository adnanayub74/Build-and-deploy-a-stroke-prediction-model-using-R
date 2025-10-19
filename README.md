[README.md](https://github.com/user-attachments/files/22989933/README.md)
# Adnan Stroke Model

This project builds and deploys a **Stroke Prediction Model in R** using machine learning methods.

## 📊 Dataset
The dataset (`healthcare-dataset-stroke-data.csv`) contains 5110 records of patient information with the goal to predict whether a patient is likely to have a stroke.

## 🧠 Methods Used
- Logistic Regression
- Random Forest
- XGBoost

## ⚙️ How to Run in RStudio
1. Open **RStudio**.
2. Open the file `stroke-prediction.Rmd`.
3. Click **Knit** → Select **HTML**.
4. Wait until the full analysis report generates.

## ▶️ Running Manually (Console Mode)
1. Open RStudio Console or Terminal.
2. Run the following command:
   ```r
   source("stroke-prediction.R")
   ```

## 📦 Required Packages
- tidyverse  
- caret  
- randomForest  
- e1071  
- xgboost

If missing, run:
```r
source("packages.R")
```


## ✨ Author
**Adnan Ayub**
