fb_data <- read.csv("data/pseudo_facebook.tsv", sep = "\t")
fb_data

str(fb_data)

library(ggplot2)

theme_set(theme_minimal(24))

?max

lessfriend <- fb_data[fb]

ggplot(aes(x = friend_count), data = subset(fb_data, !is.na(gender))) +
  geom_histogram(binwidth = 25) +
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0, 1000, 50))+
  facet_wrap(~gender)


max(fb_data$friend_count)

by(fb_data$friend_count, fb_data$gender, summary)

?subset
