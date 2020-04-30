# Data Preprocessing

# Set working directory
setwd("C:/Users/Jon/Desktop/Machine Learning A-Z Template Folder/Part 1 - Data Preprocessing")

# Importing the dataset
dataset = read.csv('Data.csv')

# Taking care of missing data
dataset$Age = ifelse(is.na(dataset$Age), #is.na checks to see if missing
                    ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)), #if missing, adds the mean of age
                    dataset$Age)

dataset$Salary = ifelse(is.na(dataset$Salary), #is.na checks to see if missing
                     ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)), #if missing, adds the mean of age
                     dataset$Salary)

# Encoding categorical data
dataset$Country = factor(dataset$Country,
                         levels = c('France', 'Spain', 'Germany'),
                         labels = c(1, 2, 3))
                         
dataset$Purchased = factor(dataset$Purchased,
                         levels = c('No', 'Yes'),
                         labels = c(0, 1))

# Splitting the dataset into the Training set and the Test set
#install.packages('caTools') #<< Download package
#library(caTools) #<< Activate package
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set[, 2:3] = scale(training_set[, 2:3])
test_set[, 2:3] = scale(test_set[, 2:3])
