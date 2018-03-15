
##Import Libraries
library(ggplot2)
library(dplyr)
library(scales)
library(GGally)
library(memisc)
library(gridExtra)


##Import Data
db <-read.csv("data/database.csv")
summary(db)
str(db)


## One Variable Exploration

## Sex
#######################################################
## There are way less women than men and 
##it seems those women are more popular than most male figures on the site.

summary(db$sex)
by(db$page_views, db$sex, summary)

##Women wikis tend to receive more views than men profiles
ggplot(db, aes(x = sex, y = page_views))+
  geom_boxplot()+
  ylim(0, quantile(db$page_views, probs = 0.95))


## Which also tends to happen in every language
ggplot(db, aes(x = sex, y = average_views))+
  geom_boxplot()+
  ylim(0, quantile(db$average_views, probs = 0.95))


by(db$industry, db$sex, summary)


## Page Views
##########################################################
ggplot(db , aes(x = page_views))+
  geom_histogram() + 
  scale_x_log10()

ggplot(db , aes(x = page_views))+
  geom_histogram() + 
  scale_x_log10()+
  facet_wrap(~ sex)

ggplot(db , aes(x = page_views))+
  geom_histogram() + 
  xlim(0, quantile(db$page_views, probs = 0.95))

## Article Languages
ggplot(db , aes(x = article_languages))+
  geom_bar() 

ggplot(db , aes(x = sex, y = article_languages))+
  geom_boxplot()+
  ylim(0, quantile(db$article_languages, probs = 0.95))
