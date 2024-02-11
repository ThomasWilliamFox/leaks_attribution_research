#### Preamble ####
# Purpose: Provides instructions for downloading and saving data from:
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/SPLDTF
# and saves data to csv file. 
# Author: Thomas Fox
# Date: 11 February 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: n/a
# Any other information needed? n/a


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)


#### Download data ####

# Raw Data for replication in excel format can be found at this URL:
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/SPLDTF

# After downloading, open with excel and select "no" when prompted to open as "read only"
# File > Save As > "raw_data.xlsx" 
# Save the file to > leaks_attribution_research/data/raw_data

raw_data <- read_xlsx("data/raw_data/raw_data.xlsx")

#### Save data as csv ####
write_csv(raw_data, "data/raw_data/raw_data.csv") 

         
