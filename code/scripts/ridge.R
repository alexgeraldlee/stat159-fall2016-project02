library(glmnet)
credit_train <- read.csv('../../data/train-set-data.csv')

grid <- 10^seq(10, -2, length=100)
train_x <- model.matrix(Balance~.,credit_train)[,-1]
train_y <- credit_train$Balance

set.seed(42)
ridge_mod <- cv.glmnet(train_x,
                       train_y, alpha=0, lambda=grid,
                       intercept=FALSE, standardize=FALSE)

rdata_output <- '../../data/best-ridge.RData'
best_ridge_number <- which(ridge_mod$lambda == ridge_mod$lambda.min)
best_ridge <- ridge_mod$glmnet.fit$beta[,best_ridge_number]
save(best_ridge, file = rdata_output)

#plot the cross-validation errors in terms of the tuning parameter
plot(ridge_mod$lambda, ridge_mod$cvm)
