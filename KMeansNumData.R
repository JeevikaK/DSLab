install.packages("cluster")
install.packages("ClusterR")

library(cluster)
library(ClusterR)

data <- data.frame(
          x = c(2,2,8,5,7,6,1,4,3),
          y = c(10,5,4,8,5,4,2,9,9)
)

head(data)

kmeans_model <- kmeans(data, nstart = 20, centers = 3)

kmeans_model$centers

clusplot(data, kmeans_model$cluster, main=paste("Numerical Data"), color = TRUE)
