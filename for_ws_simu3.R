library(ggplot2)

df <- function(sim){
  data <- read.table(paste(sim, ".csv",sep=""), header=TRUE, sep=",")
  max <- apply(data, 2, max)
  return(data.frame(population=seq(from=10,to=600,by=10),max=max))
}

p <- ggplot() + scale_shape_manual(name="Type", values=c(2,3,4,22)) +
  geom_smooth(data = df("result_ws_simu3_1"), aes(x=population,y=max)) +
  geom_point(data = df("result_ws_simu3_1"), aes(x=population, y=max, shape='max1')) +
  geom_smooth(data = df("result_ws_simu3_2"), aes(x=population,y=max)) +
  geom_point(data = df("result_ws_simu3_2"), aes(x=population, y=max, shape='max2')) +
  geom_smooth(data = df("result_ws_simu3_3"), aes(x=population,y=max)) +
  geom_point(data = df("result_ws_simu3_3"), aes(x=population, y=max, shape='max3')) +
  geom_smooth(data = df("result_ws_simu3_4"), aes(x=population,y=max)) +
  geom_point(data = df("result_ws_simu3_4"), aes(x=population, y=max, shape='max4')) +
  scale_y_continuous("queue size") +
  scale_x_continuous("population")

print(df)
print(p)
ggsave(file = "result_ws_simu3.png", plot=p)