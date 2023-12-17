install.packages("caTools")
install.packages("randomForest")

library(caTools)
library(randomForest)

data <- data.frame(read.csv("C:/MSRIT/7th Sem/DSC Lab/Datasets/HealthDataset.csv", header = TRUE, sep = ','))
head(data)

split <- sample.split(data, SplitRatio = 0.7)

train <- subset(data, split=='TRUE')
test <- subset(data, split=='FALSE')

set.seed(200)
classifier <- randomForest(x=train[-5], y=train$Disease, ntree = 500)
classifier

predict_data = predict(classifier, newdata = test[-5])
predict_data

cm <- table(test[,5], predict_data)
cm

plot(classifier)
importance(classifier)

varImpPlot(classifier)
