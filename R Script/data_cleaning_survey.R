#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from https://www.voterstudygroup.org/publication/nationscape-data-set
# Author: Ke Deng, Yongpeng Hua, Qihui Huang, Qing Wen
# Data: 2 November 2020
# Contact: qing.wen@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(haven)
library(tidyverse)
library(labelled)
# set to your own path where the data is located
setwd("C:/Users/10128/Desktop/STA304/Problem Set 3")

# Read in the raw data
raw_data_survey <- read_dta("ns20200625/ns20200625.dta")

# Add the labels
raw_data_survey <- labelled::to_factor(raw_data_survey)

# Just keep some variables
reduced_data_survey <- 
  raw_data_survey %>% 
  select(interest,
         registration,
         vote_2016,
         vote_intention,
         vote_2020,
         ideo5,
         employment,
         foreign_born,
         gender,
         census_region,
         hispanic,
         race_ethnicity,
         household_income,
         education,
         state,
         congress_district,
         age)

# mutate a binary variable for our outcome
reduced_data_survey<-
  reduced_data_survey %>%
  mutate(vote_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0))

# mutate some values to clean up
reduced_data_survey <-
  reduced_data_survey %>% 
  mutate(age = case_when(
    (age >= 18 & age <= 27) ~ "18 to 27",
    (age >= 28 & age <= 37) ~ "28 to 37",
    (age >= 38 & age <= 47) ~ "38 to 47",
    (age >= 48 & age <= 57) ~ "48 to 57",
    (age >= 58 & age <= 67) ~ "58 to 67",
    (age >= 68 & age <= 77) ~ "68 to 77",
    (age >= 78 & age <= 87) ~ "78 to 87",
    age >= 88 ~ "88+"
  ))

reduced_data_survey <- reduced_data_survey %>% 
  mutate(employment = case_when(
    employment == "Homemaker" ~ "not in labor force",
    employment == "Other" ~ "n/a",
    employment =="Part-time employed"~"employed",
    employment == "Permanently disabled"~"not in labor force",
    employment == "Retired"~"not in labor force",
    employment == "Self-employed"~"employed",
    employment == "Student"~"not in labor force",
    employment == "Unemployed or temporarily on layoff"~"unemployed",
    employment == "Full-time employed"~"employed"
  ))

reduced_data_survey <- reduced_data_survey %>% 
  mutate(race_ethnicity = case_when(
    race_ethnicity == "White" ~ "white",
    race_ethnicity == "Black, or African American" ~ "black/african american/negro", 
    race_ethnicity == "American Indian or Alaska Native" ~ "american indian or alaska native",
    race_ethnicity == "Asian (Chinese)" ~ "chinese",
    race_ethnicity == "Asian (Japanese)" ~ "japanese",
    race_ethnicity == "Asian (Other)" ~ "other asian or pacific islander",
    race_ethnicity == "Asian (Asian Indian)" ~ "other asian or pacific islander",
    race_ethnicity == "Asian (Filipino)" ~ "other asian or pacific islander",
    race_ethnicity == "Asian (Korean)" ~ "other asian or pacific islander", 
    race_ethnicity == "Asian (Vietnamese)" ~ "other asian or pacific islander", 
    race_ethnicity == "Pacific Islander (Native Hawaiian)" ~ "other asian or pacific islander", 
    race_ethnicity == "Pacific Islander (Guamanian)" ~ "other asian or pacific islander", 
    race_ethnicity == "Pacific Islander (Samoan)" ~ "other asian or pacific islander", 
    race_ethnicity == "Pacific Islander (Other)" ~ "other asian or pacific islander",
    race_ethnicity == "Some other race" ~ "other race, nec"
  )) 



# rename
reduced_data_survey <- 
  reduced_data_survey %>% 
  rename(age_group = age)

# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data_survey, "C:/Users/10128/Desktop/STA304/Problem Set 3/output/survey_data.csv")