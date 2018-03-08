#Load libraries
install.packages("GGally")
install.packages("scales")
install.packages("memisc")


library(ggplot2)
library(dplyr)
library(scales)
library(GGally)
library(memisc)

#Load data

data(diamonds)
head(diamonds)

# Let's consider the price of a diamond and it's carat weight.
# Create a scatterplot of price (y) vs carat weight (x).

# Limit the x-axis and y-axis to omit the top 1% of values.

ggplot(aes(x = carat, y = price), data = diamonds) +
  geom_point() +
  xlim(0, quantile(diamonds$carat, probs = 0.99)) +
  ylim(0, quantile(diamonds$price, probs = 0.99))

set.seed(20022012)
diamonds_samp <- diamonds[sample(1:length(diamonds$price), 10000),]
ggpairs(diamonds_samp,
        lower = list(continuous = wrap("points", shape = I('.'))),
        upper = list(combo = wrap("box", outlier.shape = I('.'))))
