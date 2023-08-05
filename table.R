# load packages
rm(list = ls())
library(tidyverse)
library(dplyr)

# Load dataset
df <- read.csv("MoviesOnStreamingPlatforms.csv")

# Rename column names of service proviers
df <- df %>%
  rename("Disney" = Disney.) %>%
  rename("Prime" = Prime.Video)


# create new dataframe to hold information
movies_df <- df %>%
  select(Title, Year, Age, Rotten.Tomatoes, Netflix, Hulu, Prime, Disney)

# convert the data frame to long format
movies_data_wide <- movies_df %>%
  select(Title, Netflix, Hulu, Prime, Disney)

movies_data_long <- gather(
  movies_data_wide,
  key = Platform,
  value = Movie_count,
  -Title
)

# aggregate total movies based on platform
aggregate_movie_count <- movies_data_long %>%
  group_by(Platform) %>%
  summarize(Total_Movie_count = sum(Movie_count, na.rm = TRUE))

# aggregate age ratings per platform
ages_rating_data_wide <- movies_df %>%
  select(Age, Netflix, Hulu, Prime, Disney)

ages_rating_data_long <- gather(
  ages_rating_data_wide,
  key = Platform,
  value = has_movie,
  -Age
)

ages_rating_data_long$Age[ages_rating_data_long$Age == ""] <- "Not rated"
ages_rating_data_long <- ages_rating_data_long[ages_rating_data_long$Age != "all", ]

aggregate_Age_rating <- ages_rating_data_long %>%
  filter(has_movie == 1) %>%
  group_by(Platform, Age) %>%
  summarise(Count = n())

