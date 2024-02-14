#### Preamble ####
# Purpose: Tests cleaned publication analysis data 
# Author: Thomas Fox 
# Date: 11 February 2024 
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: Follow directions in 01-download.R then run 02-data_cleaning.R
# Any other information needed? n/a


#### Workspace setup ####
library(tidyverse)

#### Load Cleaned Data Sets ####

test_publication = read_csv(file = "data/analysis_data/publication_analysis_data.csv", show_col_types = FALSE
)

test_names = read_csv(file = "data/analysis_data/Journal_key_analysis_data.csv", show_col_types = FALSE
)

#### Test data ####

# Test publication analysis data 

if (nrow(test_publication) != 168) {
  print("Number of articles entries is incorrect")
}

if (min(test_publication$year) < 2010) {
  print("An article year is below the year limit (2010)")
}

if (max(test_publication$year) > 2020) {
  print("An article year is above the year limit (2020)")
}

if (min(test_publication$code < 0)) {
  print("Negative number in code column")
}

if (max(test_publication$code > 3)) {
  print("out of bounds number in code column")
}

if (min(test_publication$num_cables < 0)) {
  print("Negative number in number of cables column")
}

if (class(test_publication$to_from_found) != "character") {
  print("To from found column is not of character class") 
}

if (class(test_publication$journal) != "character") {
  print("Journal column is not of class character")
}

if (class(test_publication$classified) != "character") {
  print("Classified column is not of class character")
}

if (class(test_publication$peer) != "character") {
  print("Body_leak column is not of class character")
}


# Test journal/name/trip key
  
if (nrow(test_names) != 20) {
  print("Number of journals is incorrect")
}

if (class(test_names$shortform) != "character") {
  print("Short form column is not of class character")
}

if (class(test_names$name) != "character") {
  print("Journal names column is not of class character")
} 

if (max(test_names$trip_rating > 20)) {
  print("TRIP rating greater than 20, out of bounds")
}

if (min(test_names$trip_rating < 1)) {
  print("TRIP rating less than 1, out of bounds")
}

