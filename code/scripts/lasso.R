library(glmnet)
#import the train and test sets
train <- read.csv('../../data/train-set-data.csv')[,-(1:3)]
test <- read.csv('../../data/test-set-data.csv')[,-(1:3)]

grid <- 10^seq(10, -2, length=100)

train_x <- model.matrix(Balance~.,train)[,-1]
train_y <- train$Balance

test_x <- model.matrix(Balance~., test)[,-1]
test_y <- test$Balance

#set seed to the best seed to ensure reproducibility
set.seed(42)

#perform lasso regression on training data
lasso_mod <- cv.glmnet(train_x, train_y, 
                     intercept = FALSE, 
                     standardize = FALSE, 
                     lambda = grid, 
                     alpha = 1)
save(lasso_mod, file = '../../data/best-lasso.RData')

#find the best lambda
best_lasso_number <- which(lasso_mod$lambda == lasso_mod$lambda.min)

#coefficients of best model
best_lasso <- lasso_mod$glmnet.fit$beta[,best_lasso_number]

#plot the cross-validation errors in terms of the tuning parameter
plot(lasso_mod)

#calculate the MSE
lasso_pred <- predict(lasso_mod, s = best_lasso_number, 
                      newx = test_x)
lasso_mse <- mean((lasso_pred - test_y)^2)

#refit the model to the full data
credit <- read.csv('../../data/Credit.csv')[,-(1:2)]

credit_x <- model.matrix(Balance~., credit)[,-1]
credit_y <- credit$Balance

credit_full <- glmnet(credit_x, credit_y, alpha = 1)
credit_pred <- predict(credit_full, s = best_lasso_number, type="coefficients")

#save the relevant data to best-lasso.RData
save(best_lasso, credit_pred, best_lasso_number, lasso_mse, 
     file = '../../data/best-lasso.RData')


