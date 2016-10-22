
credit <- read.csv('../../data/raw-credit.csv')

#transforming categorical variables into dummy variables
temp_credit <- model.matrix(Balance ~ ., data = credit)

#remove unnecessary column of 1's, add a Balance column from raw data

new_credit <- cbind(temp_credit[,-1], Balance = credit[,"Balance"])

#scale the data
scaled_credit <- scale(new_credit, center = TRUE, scale = TRUE)

#export the scaled final data
write.csv(scaled_credit, '../../data/Credit.csv')