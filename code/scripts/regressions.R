credit <- read.csv('../../data/Credit.csv')

#choose training set

#set the "Random" seed
set.seed(42)

train_set <- sample(1:400, 300)

train_set_data <- credit[train_set,]

test_set_data <- credit[-train_set,]

write.csv(train_set_data, file = '../../data/train-set-data.csv')
write.csv(test_set_data, file = '../../data/test-set-data.csv')
