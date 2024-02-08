#### Preamble ####
# Purpose: Replicated graphs from... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)


#### Load data ####
raw_publication_data <- read_csv("data/raw_data/raw_data.csv", show_col_types = FALSE)


#### Clean data ####

# Isolate publication data
publication_data <- raw_publication_data[c(119:685), c(0:21)]

# Convert top row to column names
# Uses stackoverflow query answer: https://stackoverflow.com/a/57531480
names(publication_data) <- 
  publication_data |>
  slice(1) |>
  unlist()
publication_data <- publication_data |> slice(-1)


# Make journal name key
journal_names <- raw_publication_data[c(24:43), c(16,17)]

journal_names <- 
  journal_names |>
  rename(name = ...16 , shortform = ...17)


# Graph 1 

# Select only number of cables cited
cables_cited <-
  publication_data |>
  select(`NUM CABLES`) 

# Convert "??" to -1 
cables_cited$`NUM CABLES`[cables_cited$`NUM CABLES` == "??"] <- "-1"

# Covert all entries to numbers
cables_cited$`NUM CABLES` <- as.numeric(cables_cited$`NUM CABLES`)

# Ommit all N/A articles
cables_cited <- 
  cables_cited |> na.omit(cables_cited)

# Make tibble with 0 - max number of cables cited (16)
graph1_data <- 
  tibble( 
    number_cited = c(0:max(cables_cited)),
    )

graph1_data


