#### Preamble ####
# Purpose: Simulates data concerning peer-reviewed publications mentioning wikileaks or leaked documents 
# Author: Thomas Fox
# Date: 11 February 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: n/a
# Any other information needed? n/a


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####

# journal - 1 : 20
# years - 2010 : 2020
# code - 2 : 3
# classified - y or n 
# no_source - y or n

set.seed(853)

simulated_publication_data <-
  tibble(
    sim_journal = sample(
      x = c(1:20),
      size = 200,
      replace = TRUE),
    
    sim_year =  sample(
      x = c(2010:2020),
      size = 200,
      replace = TRUE),
    
    sim_code = sample(
      x = c("y", "n"),
      size = 200,
      replace = TRUE),
    
    sim_classified = sample(
      x = c("y", "n"),
      size = 200,
      replace = TRUE),
    
    sim_no_source = sample(
      x = c("y", "n"),
      size = 200,
      replace = TRUE),
  )

# Summarize classified articles 
summary_classified <- simulated_publication_data |>
  select(sim_year, sim_classified) 

summary_classified <- filter(summary_classified, `sim_classified` == 'y')


# Summarize no_source articles 
summary_no_source <- simulated_publication_data |>
  select(sim_year, sim_no_source) 

summary_no_source <- filter(summary_no_source, `sim_no_source` == 'y')


#### Graph simulated data ####

# All publications graph 
simulated_publication_data |>
  ggplot(aes(x = factor(sim_year))) +
  geom_bar() +
  theme_minimal() +
  labs(x = "Year", y = "Total articles") 

# Classified referencing articles graph
summary_classified |>
  ggplot(aes(x = factor(sim_year))) +
  geom_bar() +
  theme_minimal() +
  labs(x = "Year", y = "Articles referencing classified documents") 

# Classified no_source articles graph
summary_no_source |>
  ggplot(aes(x = factor(sim_year))) +
  geom_bar() +
  theme_minimal() +
  labs(x = "Year", y = "Articles missing source for referenced document") 


#### Run tests on simulated data sets ####

if (nrow(simulated_publication_data) != 200) {
  print("Number of articles is incorrect")
}

if (min(simulated_publication_data$sim_journal) <= 0) {
  print("Journal number column contains negative value")
}

if (max(simulated_publication_data$sim_journal) > 20 ) {
  print("Journal number column contains value greater than 20")
}
  
if (min(simulated_publication_data$sim_code) < 0) {
  print("Negative number in article code column")
}

if (min(simulated_publication_data$sim_year) < 2010) {
  print("Year before 2010 is included in year column")
}

if (max(simulated_publication_data$sim_year) > 2020) {
  print("Year after 2020 is included in year column")
}

if (class(simulated_publication_data$sim_no_source) != "character") {
  print("No source column is not character data type")
}

if (class(simulated_publication_data$sim_classified) != "character") {
  print("Classified column is not character data type")
}
