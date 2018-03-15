#Load libraries
install.packages("GGally")
install.packages("scales")
install.packages("memisc")


library(ggplot2)
library(dplyr)
library(scales)
library(GGally)
library(memisc)
library(gridExtra)

#Load data

data(diamonds)
head(diamonds)

diamonds$volume = diamonds$x * diamonds$y * diamonds$z

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

# Create two histograms of the price variable
# and place them side by side on one output image.

# We've put some code below to get you started.

# The first plot should be a histogram of price
# and the second plot should transform
# the price variable using log10.


plot1 <- ggplot(aes(x = price), 
                data = diamonds) + 
  geom_histogram(binwidth = 100) +
  ggtitle("Price")
  

plot2 <- ggplot(aes(x = price), 
                data = diamonds)+
  geom_histogram(binwidth = 0.01)+
  scale_x_log10() +
  ggtitle("Log10")

grid.arrange(plot1, plot2, ncol = 2)

## Another way to transform using log10

ggplot(aes( x = carat, y = price),
       data = diamonds) + 
  geom_point() + 
  scale_y_continuous(trans = log10_trans() ) + 
  ggtitle("Log10 Price v Carat")


##Creating functions 

cuberoot_trans = function() trans_new("cuberoot",
                                      transform = function(x) x^(1/3),
                                      inverse = function(x) x^3)


ggplot(aes( x = carat, y = price),
       data = diamonds) + 
  geom_point(aes(color = color), alpha = 0.5, size = 0.5, position = "jitter") + 
  scale_y_continuous(trans = log10_trans() ) + 
  scale_x_continuous(trans = cuberoot_trans())
  ggtitle("Log10 Price v Carat v Color")

  ?jitter
  
  ## Linear Regression
  ?facet_wrap
  m1 <- lm(I(log(price)) ~ I(carat^(1/3)), data = diamonds)
  m2 <- update(m1, ~ . + carat)
  m3 <- update(m2, ~ . + cut)
  m4 <- update(m1, ~ . + color)
  m5 <- update(m4, ~ . + clarity)
  mtable(m1, m2, m3, m4, m5, sdigits = 3)
  