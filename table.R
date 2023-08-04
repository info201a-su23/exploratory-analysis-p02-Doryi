# Load the tidyverse package and the dplyr package
rm(list = ls())
library(tidyverse)
library(dplyr)

# Load the data set
df <- read.csv("MoviesOnStreamingPlatforms.csv")

# Create the table that contain the interested data
movies_df <- df %>%
  select(Title, Year, Age, Rotten.Tomatoes, Netflix, Hulu, Prime.Video, Disney.)

# Convert the data frame to long format
movies_data_wide <- movies_df %>%
  select(Title, Netflix, Hulu, Prime.Video, Disney.)

movies_data_long <- gather(
  movies_data_wide,
  key = Platform,
  value = Movie_count,
  -Title
)

# Create the data frame that is aggregate table for showing the count of how
# many movies that each platform have
aggregate_movie_count <- movies_data_long %>%
  group_by(Platform) %>%
  summarize(Total_Movie_count = sum(Movie_count, na.rm = TRUE))

# Create the data frame that is aggregate table for showing the count of how 
# many movies for different age rating that different platform has
ages_rating_data_wide <- movies_df %>%
  select(Age, Netflix, Hulu, Prime.Video, Disney.)

ages_rating_data_long <- gather(
  ages_rating_data_wide,
  key = Platform,
  value = has_movie,
  -Age
)

aggregate_Age_rating <- ages_rating_data_long %>%
  filter(has_movie == 1) %>%
  group_by(Platform, Age) %>%
  summarise(count = n())

