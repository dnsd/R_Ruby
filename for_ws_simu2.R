library(ggplot2)

data <- read.table("result_ws_simu2.csv", header = TRUE, sep = ",")
mean <- colMeans(data)
median <- apply(data, 2, median)
max <- apply(data, 2, max)
df <- data.frame(facilities = seq(from=1, to=30), mean=mean, median=median, max=max)

p <- ggplot(data=df) + scale_shape_manual(name="Type", values=c(2,3,4)) +
    geom_smooth(aes(x=facilities, y=mean)) +
    geom_point(aes(x=facilities, y=mean, shape="mean")) +
    geom_smooth(aes(x=facilities, y=median)) +
    geom_point(aes(x=facilities, y=median, shape="median")) +
    geom_smooth(aes(x=facilities, y=max)) +
    geom_point(aes(x=facilities, y=max, shape="max")) +
    scale_y_continuous("queue size") +
    scale_x_continuous("number of facilities in a restroom")

print(df)
print(p)
ggsave(file = "result_ws_simu2.png", plot=p)

dev.off()
