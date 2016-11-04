library(glmnet)
#import the train and test sets
credit_train <- read.csv('../../data/train-set-data.csv')
credit_test <- read.csv('../../data/test-set-data.csv')

grid <- 10^seq(10, -2, length=100)
train_x <- model.matrix(Balance~.,credit_train)[,-(1:4)]
train_y <- credit_train$Balance

test_x <- model.matrix(Balance~., credit_test)[,-(1:4)]
test_y <- credit_test$Balance

#set seed to the best seed to ensure reproducibility
set.seed(42)

#perform ridge regression on training data
ridge_mod <- cv.glmnet(train_x,
                       train_y, alpha=0, lambda=grid,
                       intercept=FALSE, standardize=FALSE)

rdata_output <- '../../data/best-ridge.RData'

#find the best lambda
best_ridge_number <- which(ridge_mod$lambda == ridge_mod$lambda.min)
#coefficients of best model
best_ridge <- ridge_mod$glmnet.fit$beta[,best_ridge_number]

#plot the cross-validation errors in terms of the tuning parameter
plot(ridge_mod)

#calculate the MSE
ridge_pred <- predict(ridge_mod, s = best_ridge_number,
                      newx = test_x)
ridge_mse <- mean((ridge_pred - test_y)^2)

#refit the model to the full data
credit <- read.csv('../../data/Credit.csv')

credit_x <- model.matrix(Balance~., credit)[,-(1:3)]
credit_y <- credit$Balance

credit_full <- glmnet(credit_x, credit_y, alpha=0)
credit_pred <- predict(credit_full, s = best_ridge_number, type="coefficients")

#save the relevant data to best-ridge.RData
save(best_ridge, credit_pred, best_ridge_number, ridge_mse,
     file = rdata_output)
