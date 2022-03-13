#### Preamble ####
# Purpose: Prepare the 2021 GSS data
# Author: Rohan Alexander
# Data: 13 March 2022
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the GSS data and saved it to inputs/data


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_data <- haven::read_dta("inputs/data/2021_stata/gss2021.dta")


#### Prepare data ####
# Just keep some variables that may be of interest
names(raw_data)

reduced_data <- 
  raw_data %>% 
  select(sexnow1, 
         age) %>% 
  rename(gender = sexnow1)

rm(raw_data)

#### Recode gender ####
# The question for SEXNOW1 is:
# "Do you describe yourself as male, female, or transgender?"
# Options are from the Codebook 'GSS 2021 Codebook R1b.pdf'
reduced_data <- 
  reduced_data %>% 
  mutate(gender = case_when(
    gender == 1 ~ "Male",
    gender == 2 ~ "Female",
    gender == 3 ~ "Transgender",
    gender == 4 ~ "None of these",
  ))

reduced_data %>% 
  ggplot(aes(x = age)) +
  geom_bar()

#### Save ####
write_csv(reduced_data, "outputs/data/prepared_gss.csv")



         