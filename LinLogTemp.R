install.packages("caTools")
install.packages("ggplot2")
install.packages("Metrics")

library(caTools)
library(Metrics)
library(ggplot2)
library(ROCR)

weather <- data.frame(
            temperature = c(25, 28, 30, 27, 35, 40, 31, 32, 28, 36),
            humidity = c(60, 65, 69, 63, 78, 80, 65, 66, 62, 75),
            rainy_day = c(0, 1, 1, 0, 1, 1, 0, 0, 0, 1)
)

head(weather)

split <- sample.split(weather, SplitRatio = 0.7)
train <- subset(weather, split=='TRUE')
test <- subset(weather, split=='FALSE')

classifier <- lm(formula = humidity~temperature, data = weather)

predict_data = predict(classifier, newdata = test)
predict_data

rmse(test$humidity, predict_data)

ggplot() + geom_point(aes(x=train$temperature, y=train$humidity)) + geom_line(aes(x=train$temperature, y=predict(classifier, newdata = train)))

ggplot() + geom_point(aes(x=test$temperature, y=test$humidity)) + geom_line(aes(x=test$temperature, y=predict(classifier, newdata = test)))

logistic <- glm(formula = rainy_day~humidity+temperature, data = weather, family = binomial(link = 'logit'))

logistic_predict <- predict(logistic, newdata = test, type = 'response')
logistic_predict

logistic_predict <- ifelse(logistic_predict>0.5, 1, 0)
logistic_predict

cm <- table(logistic_predict, test$rainy_day)
cm

ROCRPred <- prediction(test$rainy_day, logistic_predict)
ROCRPerf <- performance(ROCRPred, measure="tpr", x.measure="fpr")

plot(ROCRPerf)

auc <- performance(ROCRPred, measure = "auc")
auc
