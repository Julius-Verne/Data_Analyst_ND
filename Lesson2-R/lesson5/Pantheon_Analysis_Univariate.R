
##Import Libraries
library(ggplot2)
library(dplyr)
library(scales)
library(GGally)
library(memisc)
library(gridExtra)
library(forcats)

##Import Data
origin <-read.csv("data/database.csv")
db <- subset(origin, 
             select = c(full_name, birth_year, sex, country, continent, 
                        occupation, industry, domain, article_languages,
                        page_views,historical_popularity_index))

db$int_year <- as.numeric(paste(db$birth_year))
db <- subset(db, !is.na(int_year))

summary(db)
str(db)

##Univariate Exploration

## Birth Year  #########################################

ggplot(db, aes(x=int_year))+
  geom_histogram(binwidth = 10)+ 
  scale_x_continuous(breaks = seq(-5000,2000,500))+
  ggtitle("Year of Birth")+ 
  labs(colour = "Cylinders", x = "Years", y = "# of People")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))

## Sex  #########################################

ggplot(db, aes(x= sex))+
  geom_bar(aes(fill = sex))+ 
  ggtitle("# of People By Sex", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))

## Country  #########################################

ggplot(db, aes(x = fct_infreq(country)))+
  geom_bar()+ 
  ggtitle("# of People By Country", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "Countries")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))+
  theme(axis.text.x=element_text(angle = -90, hjust = 0, vjust = 0.6))

## Region  #########################################

ggplot(db, aes(x = continent))+
  geom_bar()+ 
  ggtitle("# of People By Continent", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "Continent")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))

size <- subset(db, !is.na(continent))

## Occupation  #########################################

ggplot(db, aes(x = occupation))+
  geom_bar()+ 
  ggtitle("# of People By Industry", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "Industry")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))+
  theme(axis.text.x=element_text(angle = -90, hjust = 0, vjust = 0.6))

## Industry  #########################################

ggplot(db, aes(x = industry))+
  geom_bar()+ 
  ggtitle("# of People By Industry", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "Industry")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))+
  theme(axis.text.x=element_text(angle = -90, hjust = 0, vjust = 0.6))
 
## Domain  #########################################

ggplot(db, aes(x = domain))+
  geom_bar()+ 
  ggtitle("# of People By Domain", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "Field of Expertise")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))

## Article Languages  #########################################

ggplot(db, aes(x = article_languages))+
  geom_histogram(binwidth = 5)+ 
  scale_x_continuous(breaks = seq(25,200,5))+
  ggtitle("# of People By Domain", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "Field of Expertise")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))

ggplot(db, aes(x = article_languages))+
  geom_histogram(binwidth = 0.05)+ 
  ggtitle("# of People By Domain", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "Field of Expertise")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))+
  scale_x_log10()

## Article Languages  #########################################

ggplot(db, aes(x = page_views))+
  geom_histogram(binwidth = 5)+ 
  scale_x_continuous()+
  ggtitle("# of People By Domain", 
          subtitle = "Data Obtained from the Pantheon Dataset") + 
  labs(y = "# of People", x = "Field of Expertise")+
  theme_minimal()+ 
  theme_update(plot.title = element_text(size = rel(2)))

