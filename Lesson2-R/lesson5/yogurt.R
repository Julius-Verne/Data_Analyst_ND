#Load Yogurt Dataset 
yg <- read.csv("yogurt.csv")
## Turn the id from int to a factor. 
yg$id <- factor(yg$id)

summary(yg)
str(yg)


#Load Libraries
library(ggplot2)
library(dplyr)


## First Histogram
# Price.

ggplot(aes(x = price),
       data = yg) + 
  geom_histogram(binwidth = 2)

?transform

yg <- transform(yg, all.purchases = strawberry + blueberry + pina.colada + plain + mixed.berry)
summary(yg$all.purchases)


#Data per house
purchases.house <- group_by(yg, id)
purchases.house <- summarise(purchases.house,
                             money_spent = sum(price),
                             yogurt_bought = sum(all.purchases),
                             n = n())

head(purchases.house)
summary(purchases.house)

#Price / Time
ggplot(aes(x = time, y = price),
       data = yg) +
  geom_jitter(alpha = 0.1)


#Create Samples of Data
set.seed(1884)
sample.ids <- sample(levels(yg$id),16)

ggplot(aes(x = time, y = price),
       data = subset(yg, id %in% sample.ids)) +
  facet_wrap(~ id) + 
  geom_line() +
  geom_point(aes(size = all.purchases), pch = 1)
