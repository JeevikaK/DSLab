data <- data.frame(
  x = c(2,2,8,5,7,6,1,4,3),
  y = c(10,5,4,8,5,4,2,9,9)
)

dist_matrix <- dist(data, method = 'euclidean')

cluster <- hclust(dist_matrix, method = "average")

plot(cluster)
abline(h=100, col='green')

fit <- cutree(cluster, k = 3)
table(fit)
