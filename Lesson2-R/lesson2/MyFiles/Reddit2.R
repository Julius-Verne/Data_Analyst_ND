reddit <- read.csv("data/reddit.csv")
reddit

summary(reddit)

library(ggplot2)
qplot(data = reddit, x = income.range)

