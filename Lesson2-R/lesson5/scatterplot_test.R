library(ggplot2)

pf <- read.csv("pseudo_facebook.tsv", sep = "\t")

ggplot(aes(x = age_in_months, y = friend_count), 
        data = pf)+
  geom_point(alpha = 0.1, color = "orange") + 
  scale_y_sqrt()+
  scale_x_continuous(breaks = seq(10, 75, 5))+
  geom_line(stat = "summary", fun.y = mean)+
  coord_cartesian(xlim = c(13,75), ylim = c(0,1000))

summary(pf)  

pf$age_in_months <- pf$age + (1 - pf$dob_month / 12)


ggplot(aes(x = age, y = friendships_initiated), 
       data = pf)+
  scale_y_sqrt()+
  geom_jitter(alpha = 0.1) + 
  geom_smooth(method = "lm") + 
  xlim(13,90)

##Mean over Variable

library(dplyr)

age_groups <- group_by(pf, age)
pf.fc_by_age <- summarise(age_groups, 
          friend_count_mean = mean(friend_count),
          friend_count_median = median(friend_count),
          frient_count_variance = var(friend_count),
          n = n())

head(pf.fc_by_age)


pf.fc_by_age$age

ggplot(aes(x = age, y= friend_count_mean),
       data = pf.fc_by_age) +
  geom_line()+
  scale_x_continuous(limits = c(10, 75), breaks = seq(10, 75, 5))

ggplot(aes(x = age, y= friend_count_median),
       data = pf.fc_by_age) +
  geom_line()+
  xlim(13,75)

?cor.test

cor.test(pf$age, pf$friend_count, data = pf, method = "pearson")

?with()

with(subset(pf, age<60), cor.test(age, friend_count, method = "pearson"))

subset(pf, age<60)

ggplot(aes(x = likes_received, y = www_likes_received),
       data  = pf)+
  geom_point(alpha = 0.05, color = "blue") +
  coord_cartesian(xlim = c(0,300), ylim = c(0,300))

with(pf, cor.test(www_likes_received, likes_received))

?quantile

quantile(pf$www_likes_received, probs = 0.95)


##################################################



age_months_groups <- group_by(pf, age_in_months)
pf.fc_by_month <- summarise(age_months_groups, 
                          friend_count_mean = mean(friend_count),
                          friend_count_median = median(as.numeric(friend_count)),
                          n = n()) %>% 
  arrange(age_in_months)

summary(pf.fc_by_month)

head(pf.fc_by_month)

ggplot(aes(x = age_in_months, y = friend_count_mean),
       data = subset(pf.fc_by_month, age_in_months <= 71)) + 
  geom_line()
