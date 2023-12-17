install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz)

data("Groceries")

classifier <- apriori(Groceries, parameter = list(support=0.0004, confidence=0.2))
itemFrequencyPlot(Groceries, topN=10)

plot(classifier, method="graph", measure="confidence", shading = "lift")
