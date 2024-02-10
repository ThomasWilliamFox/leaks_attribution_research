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
library(knitr)
library(dplyr)


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

# Isolate TRIP ratings (from table 1 data in data set)
rating <- raw_publication_data[c(24:43), c(20)]
rating <- rating |>
  rename(trip = "...20")

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

# Isolate code, journal, and year 
table_data <- 
  table_data |>
  select(`C`,`J`,`Year`) 

# sub table for c2
table_data_c2 <- 
  filter(table_data,`C` == 2)

# sub table for c3
table_data_c3 <- 
  filter(table_data,`C` == 3)

# counts for c2 articles 
table_data_c2_counts <- 
  table_data_c2 |> count(`J`, .drop = FALSE, name = "c2_count")

# counts for c3 articles
table_data_c3_counts <- 
  table_data_c3 |> count(`J`, .drop = FALSE, name = "c3_count")


# add rows to table_data_c2 where count is 0. (FIX to omit)
table_data_c2_counts <- table_data_c2_counts|> 
  add_row("J" = "FA", c2_count = 0, .after = 4) |>
  add_row("J" = "FP", c2_count = 0, .after = 5) |>
  add_row("J" = "IO", c2_count = 0, .after = 8) |>
  add_row("J" = "IR", c2_count = 0, .after = 9)

# merge counts 
merged_c2_c3 <- cbind(table_data_c3_counts, table_data_c2_counts["c2_count"])

# sort journal names alphabetically 
journal_table_names <- journal_names |> arrange(name)
  
# add long form journal names 
c2_c3_data <- cbind(merged_c2_c3, journal_table_names["name"])

# move names to first column 
c2_c3_data <- c2_c3_data |> relocate(name)

# make empty df for first year of code 3 article  
first_pub <- 
  tibble(years =  rep(c(9980:9999))  )

# calculate first year published code 3 for each journal 
publication_data
for (x in 1:20){
  for(y in 1:nrow(publication_data)){
    if(isTRUE(publication_data$J[y] == c2_c3_data$J[x]) == TRUE)
      if(isTRUE(publication_data$C[y] == 3) == TRUE) 
        if(isTRUE(publication_data$Year[y] <= first_pub$years[x]) == TRUE)
          first_pub$years[x] = publication_data$Year[y]
        }
}

# add first years to df 
c2_c3_data <- cbind(c2_c3_data, first_pub["years"])

# order by c3 count 
c2_c3_data <-c2_c3_data |> arrange(desc(c3_count))

# add trip rating
c2_c3_data <- cbind(c2_c3_data, rating["trip"])

# move years to last column 
c2_c3_data <- c2_c3_data |> relocate(years, .after = trip)

# construct table 
c2_c3_data |> kable(
  col.names = c("Title", " Short Form", "Code 3 Articles, 2010-2020", 
                "Code 2 Articles, 2010-2020", "TRIP Rank, 2011", "First Code 3 Article"),
  booktabs = TRUE,
  caption = "Journals Publishing Work with Leaked Material"
)








