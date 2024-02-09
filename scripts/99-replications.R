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


#### Build Figures ####


# Graph 1

# Isolate year, code, journal, and peer-reviewed status (0 for Foreign Policy 
# and Foreign Affairs, 1 for all others.) 
leak_references <-
  publication_data |>
  select(`Year`, `C`, `J`, `PEER`) 

# Filter out all non code 3 rows (using leaked sources directly)
leak_references <- 
  filter(leak_references, `C` == "3")

# Construct Graph 
leak_references |> 
  ggplot(aes(x= `Year`, fill = (`PEER` == 1))) +
  geom_bar(width = .4) +
  theme_minimal() +
  labs(x = "Year", y = "Articles") +
  theme(legend.title = element_blank()) +
  theme(legend.position = "bottom") +
  ggtitle("Articles Apparently Referencing Leaked 
  Material Directly, 2010-2020, in TRIP 2011-ranked 
  Journals (n=116)") +
  theme(plot.title = element_text(size=10)) +
  scale_fill_discrete(labels = c("FA+FP, Code 3", "Peer Reviewed, Code 3"))+
  guides(fill = guide_legend(reverse = TRUE))


# Graph 2 

# Select only number of cables cited
cables_cited <-
  publication_data |>
  select(`NUM CABLES`) 

# Convert "??" to -1 
cables_cited$`NUM CABLES`[cables_cited$`NUM CABLES` == "??"] <- "-1"

# Covert all entries to numbers
cables_cited$`NUM CABLES` <- as.numeric(cables_cited$`NUM CABLES`)

# Omit all N/A articles
cables_cited <- 
  cables_cited |> na.omit(cables_cited)

# Make counts for each cable number 
cables_cited<- 
  cables_cited |> count(`NUM CABLES`, .drop = FALSE)

cables_cited <- cables_cited |> 
  add_row("NUM CABLES" = 9, n = 0, .after = 10) |>
  add_row("NUM CABLES" = 13, n = 0, .after = 14) |>
  add_row("NUM CABLES" = 14, n = 0, .after = 15) |>
  add_row("NUM CABLES" = 15, n = 0, .after = 16)

# Make column for combined cables cited 
cables_cited <-
  cables_cited |>
  mutate(combined_cables = `NUM CABLES` * n)

# Covert all entries to numbers and change -1 back to ?? or "Unclear"
cables_cited$`NUM CABLES` <- as.character(cables_cited$`NUM CABLES`)
cables_cited$`NUM CABLES`[cables_cited$`NUM CABLES` == "-1"] <- "Unclear"
cables_cited$`combined_cables`[cables_cited$`combined_cables` == -2] <- 2

# Reposition "unclear" to the bottom of the table
cables_cited <- cables_cited |>
  slice(2:18, 1)

# Construct Graph 
cables_cited |> 
  ggplot(aes(x= reorder(`NUM CABLES`, 1:18), y = n)) +
  geom_bar(stat = "identity", width = .4) +
  theme_minimal() +
  labs(x = "Cables Cited", y = "Articles") +
  ggtitle("Articles Apparently Referencing Leaked 
          US Diplomatic Cables Directly (n=64), in 
          Peer-reviewed, TRIP 2011-Ranked Journals, 
          2010-2020, by Cables Cited") +
  theme(plot.title = element_text(size=10))



#### Build Table ####

table_data <- publication_data

table_data <- 
  table_data |>
  select(`C`,`J`,`Year`) 

table_data_c2 <- 
  filter(table_data,`C` == 2)
  
table_data_c3 <- 
  filter(table_data,`C` == 3)

table_data_c2_counts <- 
  table_data_c2 |> count(`J`, .drop = FALSE)

table_data_c3_counts <- 
  table_data_c3 |> count(`J`, .drop = FALSE)


# add rows to table_data_c2 where count is 0. 
table_data_c2_counts <- table_data_c2_counts|> 
  add_row("J" = "FA", n = 0, .after = 4) |>
  add_row("J" = "FP", n = 0, .after = 5) |>
  add_row("J" = "IO", n = 0, .after = 8) |>
  add_row("J" = "IR", n = 0, .after = 9)


table_data_c2_counts 
table_data_c3_counts



merged_c2_c3 <- cbind(table_data_c3_counts, table_data_c2_counts["n"])

merged_c2_c3
