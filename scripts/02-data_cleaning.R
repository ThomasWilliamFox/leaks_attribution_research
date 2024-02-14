#### Preamble ####
# Purpose: Cleans Christopher Darton's 2010-2020 journal publication data 
# Author: Thomas Fox
# Date: 11 February 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: Follow directions in scripts/01-download_data.R
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


# Select desired columns 
cleaned_pub_data <-
  cleaned_pub_data |>
  select(c, j, year, class, no_source, leak, euph, to_from_found, peer, cable, num_cables)


# Convert all N/A values
cleaned_pub_data <-
  cleaned_pub_data |> replace_na(list(class = "n", no_source = "n", 
                                      to_from_found = "n", leak = "n",
                                      euph = "n", peer = "n", 
                                      num_cables = "0" , cable = "n" ))  




# Change "??" in num_cables to 0 
cleaned_pub_data$num_cables[cleaned_pub_data$num_cables == "??"] <- "0"

# Change cable column 0s and 1s to "y" and "n",
cleaned_pub_data$cable[cleaned_pub_data$cable == "0"] <- "n"
cleaned_pub_data$cable[cleaned_pub_data$cable == "1"] <- "y"

# Change cable column 0s and 1s to "y" and "n",
cleaned_pub_data$peer[cleaned_pub_data$peer == "0"] <- "n"
cleaned_pub_data$peer[cleaned_pub_data$peer == "1"] <- "y"


# Make column names more descriptive 
cleaned_pub_data <- 
  cleaned_pub_data |>
  rename(
  code = c,
  journal = j,
  classified = class)


# Construct journal name/trip rating key
journal_name_key <- raw_pub_data[c(24:43), c(16,17)]
trip_ratings <- raw_pub_data[c(24:43), c(20)]

journal_name_key <- cbind(journal_name_key, trip_ratings["...20"])

journal_name_key <- 
  journal_name_key |>
  rename(name = ...16 , shortform = ...17, trip_rating = ...20)


#### Save data ####

# Write cleaned data 
write_csv(cleaned_pub_data, "data/analysis_data/publication_analysis_data.csv")

# Write journal key 
write_csv(journal_name_key, "data/analysis_data/journal_key_analysis_data.csv")



