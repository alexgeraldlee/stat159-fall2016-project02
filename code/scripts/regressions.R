credit <- read.csv('../../data/Credit.csv')
raw_credit <- read.csv('../../data/raw-credit.csv')

#choose training set

#set the "Random" seed
set.seed(42)

#sample the data based on the seed
train_set <- sample(1:400, 300)

train_set_data <- credit[train_set,]
test_set_data <- credit[-train_set,]

#export to .csv
write.csv(train_set_data, file = '../../data/train-set-data.csv')
write.csv(test_set_data, file = '../../data/test-set-data.csv')

#multiple regression using Original Least Squares
credit_ols <- lm(Balance ~ Income + Limit + Rating + Cards + Age + 
     Education + Gender + Student + Married + Ethnicity, 
   data = raw_credit)

credit_ols_summary <- summary(credit_ols)


sink('../../data/credit-ols-coefficients.txt')
cat("Coefficients of OLS Regression on Balance\n")
round(credit_ols_summary$coefficients, 4)
sink()