library(pls)
#import the train and test sets
credit_train <- read.csv('../../data/train-set-data.csv')[,-(1:3)]
credit_test <- read.csv('../../data/test-set-data.csv')[,-(1:3)]

#set seed to the best seed to ensure reproducibility
set.seed(41)

#perform lasso regression on training data
plsr_mod <- plsr(Balance~., 
                 data = credit_train, 
                 validation ="CV", 
                 scale = FALSE,
                 standardize = FALSE)
save(plsr_mod, file = '../../data/best-plsr.RData')

#find the best lambda
best_plsr_number <- which.min(plsr_mod$validation$PRESS)
best_plsr <- plsr_mod$coefficients[,1,best_plsr_number]

#calculate the MSE using the test data
plsr_pred <- predict(plsr_mod, credit_test, ncomp = best_plsr_number)
plsr_mse <- mean((plsr_pred - credit_test[,"Balance"]) ^ 2)

#plot the plsr
png('../../images/plsr-plot.png')
validationplot(plsr_mod, val.type = "MSEP")
dev.off()

#run the plsr on the full data
credit <- read.csv('../../data/Credit.csv')
credit_x <- model.matrix(Balance~., credit)[,-(1:3)]
credit_y <- credit$Balance
plsr_final <- plsr(credit_y ~ credit_x, scale = FALSE, 
                 ncomp = best_plsr_number)

plsr_coefficients <- plsr_final$coefficients[,1,best_plsr_number]

rdata_output <- '../../data/best-plsr.RData'
save(best_plsr, plsr_coefficients, plsr_mse, file = rdata_output)
