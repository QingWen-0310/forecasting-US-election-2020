#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from https://doi.org/10.18128/D010.V10.0
# Author: Ke Deng, Yongpeng Hua, Qihui Huang, Qing Wen
# Date: 2 November 2020
# Contact: qing.wen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data. In our project wo specifically used usa_00001.dta that includes variables
# of stateicp, sex, age, race, empstat, educd, inctot as our final selected variables. But some other variables are
# also included in the raw data.


#### Workspace setup ####
library(haven)
library(tidyverse)
library(labelled)
# Read in the raw data.
setwd("C:/Users/10128/Desktop/STA304/Problem Set 3")
raw_data <- read_dta("usa_00001.dta")

# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Keep variables of interest
reduced_data <- 
  raw_data %>% 
  select(stateicp,
         sex, 
         age, 
         race, 
         empstat,
         educd,
         inctot)

# mutate the value for income level so the values match with the ones in survey_data
reduced_data <- reduced_data %>% 
  mutate(inctot = case_when(
    inctot <= 14999 ~ "Less than $14,999",
    inctot >= 15000 & inctot <= 19999 ~ "$15,000 to $19,999",
    inctot >= 20000 & inctot <= 24999 ~ "$20,000 to $24,999",
    inctot >= 25000 & inctot <= 29999 ~ "$25,000 to $29,999",
    inctot >= 30000 & inctot <= 34999 ~ "$30,000 to $34,999",
    inctot >= 35000 & inctot <= 39999 ~ "$35,000 to $39,999",
    inctot >= 40000 & inctot <= 44999 ~ "$40,000 to $44,999 ",
    inctot >= 45000 & inctot <= 49999 ~ "$45,000 to $49,999 ",
    inctot >= 50000 & inctot <= 54999 ~ "$50,000 to $54,999 ",
    inctot >= 55000 & inctot <= 59999 ~ "$55,000 to $59,999",
    inctot >= 60000 & inctot <= 64999 ~ "$60,000 to $64,999",
    inctot >= 65000 & inctot <= 69999 ~ "$65,000 to $69,999",
    inctot >= 70000 & inctot <= 74999 ~ "$70,000 to $74,999",
    inctot >= 75000 & inctot <= 79999 ~ "$75,000 to $79,999",
    inctot >= 80000 & inctot <= 84999 ~ "$80,000 to $84,999",
    inctot >= 85000 & inctot <= 89999 ~ "$85,000 to $89,999",
    inctot >= 90000 & inctot <= 94999 ~ "$90,000 to $94,999",
    inctot >= 95000 & inctot <= 99999 ~ "$95,000 to $99,999",
    inctot >= 100000 & inctot <= 124999 ~ "$100,000 to $124,999",
    inctot >= 125000 & inctot <= 149999 ~ "$125,000 to $149,999 ",
    inctot >= 150000 & inctot <= 174999 ~ "$150,000 to $174,999",
    inctot >= 175000 & inctot <=  199999 ~ "$175,000 to $199,999",
    inctot >= 200000 & inctot <= 249999 ~ "$200,000 to $249,999",
    inctot >= 250000 ~ "$250,000 and above"
  )) %>% 
  rename(household_income = inctot)


# mutate education detailed
reduced_data <- reduced_data %>% 
  mutate(educd = case_when(
    educd == "n/a or no schooling" ~ "3rd Grade or less",
    educd == "n/a" ~ "3rd Grade or less",
    educd == "no schooling completed" ~ "3rd Grade or less",
    educd == "nursery school to grade 4" ~ "3rd Grade or less",
    educd == "nursery school, preschool" ~ "3rd Grade or less",
    educd == "kindergarten" ~ "3rd Grade or less",
    educd == "grade 1, 2, 3, or 4" ~ "3rd Grade or less",
    educd == "grade 1" ~ "3rd Grade or less",
    educd == "grade 2" ~ "3rd Grade or less",
    educd == "grade 3" ~ "3rd Grade or less",
    educd == "grade 4" ~ "3rd Grade or less",
    educd == "grade 5, 6, 7, or 8" ~ "Middle School - Grades 4 - 8",
    educd == "grade 5 or 6" ~ "Middle School - Grades 4 - 8",
    educd == "grade 5" ~ "Middle School - Grades 4 - 8",
    educd == "grade 6" ~ "Middle School - Grades 4 - 8",
    educd == "grade 7" ~ "Middle School - Grades 4 - 8",
    educd == "grade 8" ~ "Middle School - Grades 4 - 8",
    educd == "grade 9" ~ "Completed some high school",
    educd == "grade 10" ~ "Completed some high school",
    educd == "grade 11" ~ "Completed some high school",
    educd == "grade 12" ~ "High school graduate",
    educd == "12th grade, no diploma" ~ "High school graduate",
    educd == "high school graduate or GED" ~ "High school graduate",
    educd == "regular high school diploma" ~ "High school graduate",
    educd == "ged or alternative credential" ~ "Other post high school vocational training",
    educd == "some college, but less than 1 year" ~ "Completed some college, but no degree",
    educd == "1 year of college" ~ "Completed some college, but no degree",
    educd == "1 or more years of college credit, no degree" ~ "Completed some college, but no degree",
    educd == "2 years of college" ~ "Completed some college, but no degree",
    educd == "associate's degree, type not specified" ~ "Associate Degree",
    educd == "associate's degree, occupational program" ~ "Associate Degree",
    educd == "associate's degree, academic program" ~ "Associate Degree",
    educd == "3 years of college" ~ "Completed some college, but no degree",
    educd == "4 years of college" ~ "Completed some college, but no degree",
    educd == "bachelor's degree" ~ "College Degree (such as B.A., B.S.)",
    educd == "5+ years of college" ~ "Completed some graduate, but no degree",
    educd == "6 years of college (6+ in 1960-1970)" ~ "Completed some graduate, but no degree",
    educd == "7 years of college" ~ "Completed some graduate, but no degree",
    educd == "8+ years of college" ~ "Completed some graduate, but no degree",
    educd == "master's degree" ~ "Masters degree",
    educd == "professional degree beyond a bachelor's degree" ~ "Masters degree",
    educd == "doctoral degree" ~ "Doctorate degree"))

    
  
# mutate value for age
reduced_data <-reduced_data %>% 
  mutate(age = case_when(
    as.numeric(age) < 18 ~ "under 18",
    as.numeric(age) >= 18 &  as.numeric(age) <= 27 ~ "18 to 27",
    as.numeric(age) >= 28 &  as.numeric(age) <= 37 ~ "28 to 37",
    as.numeric(age) >= 38 &  as.numeric(age) <= 47 ~ "38 to 47",
    as.numeric(age) >= 48 &  as.numeric(age) <= 57 ~ "48 to 57",
    as.numeric(age) >= 58 &  as.numeric(age) <= 67 ~ "58 to 67",
    as.numeric(age) >= 68 &  as.numeric(age) <= 77 ~ "68 to 77",
    as.numeric(age) >= 78 &  as.numeric(age) <= 87 ~ "78 to 87",
    as.numeric(age) >= 88 ~ "88+"
  ))

# mutate value for gender
reduced_data <- reduced_data %>% rename(gender = sex)
reduced_data <- reduced_data %>% 
  mutate(gender = case_when(
    gender == "male" ~ "Male",
    gender == "female"~"Female"
  ))

# put people with two more races into other race
reduced_data <- reduced_data %>% rename(race_ethnicity = race)
reduced_data <- reduced_data %>% 
  mutate(race_ethnicity = ifelse(race_ethnicity == "two major races" | race_ethnicity == "three or more major races", "other race, nec", as.character(race_ethnicity)))

# rename some variables
reduced_data <- reduced_data %>% rename(age_group = age)
reduced_data <- reduced_data %>% rename(employment = empstat)
reduced_data <- reduced_data %>% rename(education = educd)

# filter out observations with age under 18, as they do not have the right to vote
reduced_data <- reduced_data %>% filter(age_group != "under 18")

# split the cells using the selected variables
reduced_data <-
  reduced_data %>% 
  count(gender,household_income, employment, age_group, race_ethnicity, education) %>% 
  group_by(gender,household_income, employment, age_group, race_ethnicity, education)


# Saving the census data as a csv file in working directory
write_csv(reduced_data, "C:/Users/10128/Desktop/STA304/Problem Set 3/output/census_data.csv")
