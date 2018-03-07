library(ggplot2)
library(dplyr)

data(diamonds)

head(diamonds)
str(diamonds)

ggplot(aes(x = volume, y = price),
       data = set2) + 
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm")

?geom_smooth

diamonds$volume <- diamonds$x * diamonds$y * diamonds$z 

?quantile

set1 <- subset(diamonds, diamonds$volume <= 800)
set1
set2 <- subset(set1, set1$volume >= 0)

quantile(set2$volume, probs = (0.01))

cor.test(set2$volume, set2$price)

?cor.test

summary(diamonds$volume)

count(diamonds$volume==0)

order_clarity <- group_by(diamonds, clarity)

dm_order_clarity <- summarise(order_clarity, 
                            price_mean = mean(price),
                            price_median = median(as.numeric(price)),
                            n = n())
