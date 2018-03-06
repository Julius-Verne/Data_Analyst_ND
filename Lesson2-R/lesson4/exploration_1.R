#Load Libraries
library(ggplot2)
library(gridExtra)

data <- read.csv("birthdaysExample.csv")

data$d_date <- as.Date(data$dates, "%m/%d/%y")
data$year = as.ordered(format(data$d_date, format = "%y"))
data$month = as.ordered(format(data$d_date, format = "%m"))
data$day = as.ordered(format(data$d_date, format = "%d"))

summary(data)
str(data)

ggplot(aes(x = day),
       data = data) + 
  geom_histogram(stat = "count") + 
  facet_wrap(~month)


ggplot(aes(x = month),
       data = data) + 
  geom_histogram(stat = "count")
