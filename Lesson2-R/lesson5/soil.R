## SOIL DATA

library(alr3)

sd <- data(Mitchell)

summary(sd)

ggplot(aes(x = Month, y = Temp),
       data = Mitchell) +
  geom_line() +
  scale_x_continuous(breaks = seq(0,200,12))
  

with(Mitchell, cor.test(Month, Temp, method = "pearson"))

summary(Mitchell)
