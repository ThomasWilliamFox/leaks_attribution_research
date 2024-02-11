#### Preamble ####
# Purpose: Cleans Christopher Darton's 2010-2020 journal publication data 
# Author: Thomas Fox
# Date: 11 February 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: Follow directions for downloading and saving raw_data.csv in scripts/00-download_data.R
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####

raw_pub_data <- read_csv("data/raw_data/raw_data.csv", show_col_types = FALSE)

# Isolate code 2 & 3 data from raw data
# Code 3 = using leaked sources directly
# Code 2 = using leaked information via published secondary sources
cleaned_pub_data <- raw_pub_data[c(119:287), c(0:21)]


# Convert top row to column names
# Uses stackoverflow query answer: https://stackoverflow.com/a/57531480
names(cleaned_pub_data) <- 
  cleaned_pub_data |>
  slice(1) |>
  unlist()
cleaned_pub_data <- cleaned_pub_data|> slice(-1)

# Clean names 
cleaned_pub_data <- clean_names(cleaned_pub_data)


# Make journal name key
journal_name_key <- raw_pub_data[c(24:43), c(16,17)]
journal_name_key <- 
  journal_name_key |>
  rename(name = ...16 , shortform = ...17)
journal_name_key




#### Save data ####

# write_csv(cleaned_data, "data/analysis_data.csv")
