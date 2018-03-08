#Load libraries

library(ggplot2)
library(dplyr)

#Load data

data(diamonds)
head(diamonds)

pf <- read.csv("pseudo_facebook.tsv", sep = "\t")
summary(pf)

# Create a histogram of diamond prices.
# Facet the histogram by diamond color
# and use cut to color the histogram bars.


ggplot(aes(x = price),
       data = diamonds) + 
  geom_histogram(aes(fill = cut), binwidth = 1000) + 
  facet_wrap(~ color) 


# Create a scatterplot of diamond price vs.
# table and color the points by the cut of
# the diamond.

ggplot(aes(y = price, x = table),
       data = diamonds) + 
  geom_jitter(aes(color = cut), alpha = 0.5) +
  facet_wrap(~ cut)+
  xlim(50,80)

# Create a scatterplot of diamond price vs.
# volume (x * y * z) and color the points by
# the clarity of diamonds. Use scale on the y-axis
# to take the log10 of price. You should also
# omit the top 1% of diamond volumes from the plot.

# Note: Volume is a very rough approximation of
# a diamond's actual volume.

diamonds$vol <- diamonds$x * diamonds$y * diamonds$z

ggplot(aes(x= vol, y = price),
       data = subset(diamonds, diamonds$vol >= 1 )) +
  geom_point(aes(color = clarity))+
  xlim(0,355) +
  scale_y_log10()

#Found the top 1%
quantile(diamonds$vol, probs = .99)

# Many interesting variables are derived from two or more others.
# For example, we might wonder how much of a person's network on
# a service like Facebook the user actively initiated. Two users
# with the same degree (or number of friends) might be very
# different if one initiated most of those connections on the
# service, while the other initiated very few. So it could be
# useful to consider this proportion of existing friendships that
# the user initiated. This might be a good predictor of how active
# a user is compared with their peers, or other traits, such as
# personality (i.e., is this person an extrovert?).

# Your task is to create a new variable called 'prop_initiated'
# in the Pseudo-Facebook data set. The variable should contain
# the proportion of friendships that the user initiated.

summary(pf)
pf$prop_initiated <- (pf$friendships_initiated * 100)/pf$friend_count
?bucket

pf$year_joined <- floor(2014 - pf$tenure/365)

pf$year_joined.bucket <- cut(pf$year_joined,
                             c(2004,2009,2011,2012,2014))

summary(pf$year_joined.bucket)

# Create a line graph of the median proportion of
# friendships initiated ('prop_initiated') vs.
# tenure and color the line segment by
# year_joined.bucket.

# Recall, we created year_joined.bucket in Lesson 5
# by first creating year_joined from the variable tenure.
# Then, we used the cut function on year_joined to create
# four bins or cohorts of users.

# (2004, 2009]
# (2009, 2011]
# (2011, 2012]
# (2012, 2014]


pf.tenure_group <- group_by(subset(pf, !is.na(prop_initiated)), year_joined.bucket)
pf.tenure_group <- summarise(pf.tenure_group,
                             prop_initiated_mean = mean(as.numeric(prop_initiated)),
                             n = n())

head(pf.tenure_group)

ggplot(aes(x = tenure, y = prop_initiated),
       data = subset(pf, !is.na(prop_initiated))) + 
  geom_line(aes(color = year_joined.bucket), stat = "summary", fun.y = median)+
  geom_smooth()


ggplot(aes(x = year_joined.bucket, y = prop_initiated),
       data = subset(pf, !is.na(prop_initiated)))+
  geom_boxplot()


by(pf$prop_initiated, pf$year_joined.bucket, summary)

# Create a scatter plot of the price/carat ratio
# of diamonds. The variable x should be
# assigned to cut. The points should be colored
# by diamond color, and the plot should be
# faceted by clarity.

summary(diamonds)

ggplot(aes(y = price/carat, x = cut),
       data = diamonds) + 
  geom_jitter(aes(color = color))+
  facet_wrap(~ clarity)

