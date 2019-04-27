# importing the dataset
dataSet = read.csv('Data.csv')

# taking care of the missing data
dataSet$Age = ifelse(is.na(dataSet$Age),
                     ave(
                       dataSet$Age,
                       FUN = function(x)
                         mean(x, na.rm = TRUE)
                     ),
                     dataSet$Age)

dataSet$Salary = ifelse(is.na(dataSet$Salary),
                        ave(
                          dataSet$Salary,
                          FUN = function(x)
                            mean(x, na.rm = TRUE)
                        ),
                        dataSet$Salary)

# Encoding categorical data
dataSet$Country = factor(
  dataSet$Country,
  levels = c('France', 'Spain', 'Germany'),
  labels = c(1, 2, 3)
)

dataSet$Purchased = factor(dataSet$Purchased,
                           levels = c('Yes', 'No'),
                           labels = c(1, 0))

# Splitting dataset into train and test data
set.seed(123)
split = sample.split(dataSet$Purchased, SplitRatio = 0.8)
training_set = subset(dataSet, split == TRUE)
test_set = subset(dataSet, split == FALSE)

# Scaling
training_set[, 2:3] = scale(training_set[, 2:3])
test_set[, 2:3] = scale(test_set[, 2:3])
