# Multiple Linear Regression

# Importing the dataset
dataset = read.csv('web_traffic.csv')

# Encoding categorical data
dataset$month = factor(dataset$month,
                       levels = c('1', '2', '3', '4', '5', '6', '7'),
                       labels = c(1, 2, 3, 4, 5, 6, 7))

dataset$dayofweek = factor(dataset$dayofweek,
                       levels = c('1', '2', '3', '4', '5', '6', '7'),
                       labels = c(1, 2, 3, 4, 5, 6, 7))

dataset$holiday = factor(dataset$holiday,
                       levels = c('0', '1'),
                       labels = c(1, 2))

# Splitting the dataset into the Training set and Test set
install.packages('caTools')
library(caTools)



set.seed(123)
split = sample.split(dataset$traffic, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = traffic ~ .,
               data = training_set)

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

# Visualizeing the Linear Regression results
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$dayofweek, y = dataset$traffic),
             color = 'red') + 
  geom_line(aes(x = dataset$dayofweek, y = predict(regressor, newdata = dataset)),
            color = 'blue') + 
  ggtitle('Daily Traffic (Linear Regression)') +
  xlab('Day of the Week') +
  ylab('Traffic')

y_pred_df = as.data.frame(y_pred)