library(ggplot2)
library(gridExtra)
data(diamonds)

summary(diamonds)

str(diamonds)

by(diamonds$price,diamonds$color, summary)

?diamonds


ggplot(aes(x = price ), data = diamonds)+
  geom_histogram(binwidth = 50,color = 'black', fill = '#099DD9') +
  scale_x_continuous(limits = c(0, 10000), breaks = seq(0, 10000, 1000))

summary(diamonds$price)

diamonds$less_500 <- ifelse(diamonds$price>=15000,TRUE,FALSE)

summary(diamonds$less_500)

Fair <- ggplot(aes(x = price), data = subset(diamonds, cut == 'Fair')) +
  geom_histogram(binwidth = 50,color = 'black', fill = '#099DD9') +
  scale_x_continuous(limits = c(0, 10000), breaks = seq(0, 10000, 1000))


Good <- ggplot(aes(x = price), data = subset(diamonds, cut == 'Good')) +
  geom_histogram(binwidth = 50,color = 'black', fill = '#099DD9') +
  scale_x_continuous(limits = c(0, 10000), breaks = seq(0, 10000, 1000))


V_Good <- ggplot(aes(x = price), data = subset(diamonds, cut == 'Very Good')) +
  geom_histogram(binwidth = 50,color = 'black', fill = '#099DD9') +
  scale_x_continuous(limits = c(0, 10000), breaks = seq(0, 10000, 1000))


Prem <- ggplot(aes(x = price), data = subset(diamonds, cut == 'Premium')) +
  geom_histogram(binwidth = 50,color = 'black', fill = '#099DD9') +
  scale_x_continuous(limits = c(0, 10000), breaks = seq(0, 10000, 1000))


Ideal <- ggplot(aes(x = price), data = subset(diamonds, cut == 'Ideal')) +
  geom_histogram(binwidth = 50,color = 'black', fill = '#099DD9') +
  scale_x_continuous(limits = c(0, 10000), breaks = seq(0, 10000, 1000))

grid.arrange(Fair, Good, V_Good,Prem, Ideal, ncol=1)

?aes

diamonds$priceCarat <- diamonds$price/diamonds$carat
ASAAAAAAAAA

ggplot(aes(x = priceCarat ), data = diamonds) +
  geom_histogram(color = 'black', fill = '#099DD9') +
  scale_x_log10() +
  facet_wrap(~cut, scales = "free_y")

?facet_wrap

by(diamonds$priceCarat, diamonds$color, summary)

ggplot(aes(y = priceCarat, x = color),
       data = diamonds) + 
  geom_boxplot(aes(color = color)) +
  coord_cartesian()

7695-1860

4214-911


ggplot(aes(x = carat),
       data = diamonds) +
  geom_freqpoly(binwidth=0.05) +
  scale_x_continuous(limits = c(0, 2), breaks = seq(0, 2,0.2))

?geom_freqpoly

?seq

?scale_x_log10()

??breaks
