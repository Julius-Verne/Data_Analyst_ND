fb_data <- read.csv("data/pseudo_facebook.tsv", sep = "\t")

library(ggplot2)
library(gridExtra)
library(dplyr)

summary(fb_data)

theme_set(theme_minimal(24))


ggplot(aes(x = friend_count), data = subset(fb_data, !is.na(gender))) +
  geom_histogram(binwidth = 25) +
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0, 1000, 50))+
  facet_wrap(~gender)


by(fb_data$friend_count, fb_data$gender, summary)



ggplot(aes(x = tenure), data = subset(fb_data, !is.na(gender))) +
  geom_histogram(binwidth = 30, color = 'black', fill = '#099DD9') +
  scale_x_continuous(limits = c(0,2000)) +
  facet_wrap(~gender)


ggplot(aes(x =  tenure/365), data = fb_data) +
  xlab("# of Years on FB") + 
  ylab("# of People") +
  geom_histogram(binwidth = 0.25, color = 'black', fill = '#099DD9') +
  scale_x_continuous(limits = c(0,8), breaks = seq(0,8,1))

?integer  
   


ggplot(aes( x= age), data= subset(fb_data, !is.na(gender))) + 
  xlab("Age")+
  ylab("# of People")+
  geom_histogram(binwidth = 1, color = '#EAE9E7', fill = '#FC503E' ) +
  scale_x_continuous(limits = c(0,100), breaks = seq(0,100,5)) + 
  facet_wrap(~gender)


p1 <- ggplot(aes(x=friend_count), data = fb_data) + 
  geom_histogram(binwidth = 25, color = '#EAE9E7', fill = '#FC503E') +
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0, 1000, 50)) +
  xlab("FB friend count") +
  ylab("# of People")

p2 <- ggplot(aes(x=log10(friend_count + 1)), data = fb_data) + 
  geom_histogram(binwidth=0.1,color = '#DD6733', fill = '#2CC5C4') +
  scale_x_continuous(limits = c(0, 4), breaks = seq(0, 4, 0.5)) +
  xlab("FB friend count") +
  ylab("# of People")

p3 <- ggplot(aes(x= sqrt(friend_count)), data = fb_data) + 
  geom_histogram(binwidth=1,color = '#DD6733', fill = '#2CC5C4') +
  scale_x_continuous(limits = c(0, 80), breaks = seq(0, 80, 5))

likes_given <- ggplot(aes(x = likes),
       data = subset(fb_data, !is.na(gender))) +
  geom_freqpoly(aes(color = gender)) +
  scale_x_log10()

likes_received <- ggplot(aes(x = likes_received),
                      data= subset(fb_data, !is.na(gender))) + 
  geom_freqpoly(aes(color = gender)) +
  scale_x_log10()

summary(fb_data)

grid.arrange(likes_given, likes_received, ncol=1)

by(fb_data$friendships_initiated, fb_data$gender, mean)

ggplot(aes(y = friendships_initiated, x = gender),
       data= subset(fb_data, !is.na(gender))) + 
  geom_boxplot(aes(color = gender)) +
  coord_cartesian(ylim = c(0,1000))


fb_data$mobile_checkin <- NA

summary(fb_data)

fb_data$mobile_checkin <- ifelse(fb_data$mobile_likes>0, TRUE, FALSE)
summary(fb_data$mobile_checkin)

amount <- length(fb_data$mobile_checkin)

checked <- sum(fb_data$mobile_checkin == TRUE)

?sum


?length

total <- checked/amount * 100
total


ggplot(aes(x = age, y = friend_count),
       data = subset(fb_data, !is.na(gender))) +
  geom_line(aes(color = gender), stat = "summary", fun.y = median) +
  xlim(13,70)

pf.fc_by_age_gender <- group_by(subset(fb_data, !is.na(gender)), gender, age)

pf.fc_by_age_gender <- summarise(pf.fc_by_age_gender,
                                 mean_friend_count = mean(friend_count),
                                 median_friend_count = median(as.numeric(friend_count)),
                                 n = n())

pf.fc_by_age_gender

ggplot(aes(x = age, y = median_friend_count),
       data = pf.fc_by_age_gender) + 
  geom_line(aes(color=gender))
