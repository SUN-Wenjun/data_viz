rm(list = ls())

df <- read.csv("VIZ5_2020_April - Unpaid Work.csv")

#install.packages("countrycode")
library(countrycode)
library(dplyr)


df <- df %>% 
  select(-c(Survey.Availability)) %>%
  # only keep the latest survey within each survey.availability span
  mutate(surveyYear = as.integer(substr(Year,1,4))) %>%
  group_by(Age, Area, Country, Gender, Time.use) %>% 
  top_n(1, surveyYear) %>%
  # add region
  ungroup() %>%
  mutate(Country = gsub("閡", "eu", Country)) %>%
  mutate(region = countrycode(Country, origin = "country.name", destination = "region"))

df %>%  filter(Country == "Canada")

write.csv(df, "VIZ5_2020_April - Unpaid Work_processed.csv")
