library(pls)
credit_train <- read.csv('../../data/train-set-data.csv')
credit_test <- read.csv('../../data/test-set-data.csv')

credit_train <- credit_train[,-(1:3)]
credit_test <- credit_test[,-(1:3)]
#run the pcr on the training data
set.seed(42)
pcr_mod <- pcr(Balance ~ ., data = credit_train, alpha=0, 
               scale=FALSE, validation="CV")

#find best model
best_pcr_number <- which.min(pcr_mod$validation$PRESS)
best_pcr <- pcr_mod$coefficients[,1,best_pcr_number]

#calculate the MSE using the test data
pcr_pred <- predict(pcr_mod, credit_test, ncomp = best_pcr_number)
pcr_mse <- mean((pcr_pred - credit_test[,"Balance"]) ^ 2)

#plot the pcr
png('../../images/pcr-plot.png')
validationplot(pcr_mod, val.type = "MSEP")
dev.off()

#run the pcr on the full data
credit <- read.csv('../../data/Credit.csv')
credit_x <- model.matrix(Balance~., credit)[,-(1:3)]
credit_y <- credit$Balance
pcr_final <- pcr(credit_y ~ credit_x, scale = FALSE, 
                 ncomp = best_pcr_number)

pcr_coefficients <- pcr_final$coefficients[,1,best_pcr_number]

rdata_output <- '../../data/best-pcr.RData'
save(best_pcr, pcr_coefficients, pcr_mse, file = rdata_output)
