rm(list = ls())
library(tidyverse)
library(dplyr)
library(readr)

data <- read.csv("MoviesOnStreamingPlatforms.csv")
  
# Chart 1: Diversity of Streaming Platforms (Bar chart)
total_netflix <- data %>%
  summarise(total_netflix = sum(Netflix, na.rm = TRUE)) %>%
  pull(total_netflix)
total_hulu <- data %>%
  summarise(total_hulu = sum(Hulu, na.rm = TRUE)) %>%
  pull(total_hulu)
total_prime <- data %>%
  summarise(total_prime = sum(Prime.Video, na.rm = TRUE)) %>%
  pull(total_prime)
total_disney <- data %>%
  summarise(total_disney = sum(Disney., na.rm = TRUE)) %>%
  pull(total_disney)

aggregate_info <- data.frame(
  Streaming_Platforms = c("Netflix", "Hulu", "Prime Video", "Disney+"),
  Total_Movies = c(total_netflix, total_hulu, total_prime, total_disney)
)

bar_chart <- ggplot(aggregate_info) +
  geom_bar(stat = "identity") + aes(
    x = Streaming_Platforms,
    y = Total_Movies,
    fill = Streaming_Platforms) +
  labs(title = "Total Number of Movies by Streaming Platforms",
       x = "Streaming Platforms",
       y = "Total Movies",
       fill = "Streaming Platforms")
bar_chart
# The purpose of adding this bar chart is to display the number of movies released by various streaming platforms from 1914 to 2021 to thoroughly compare the movie production diversity differences between them. This bar chart reveals significant differences in the number of movies across streaming platforms. Prime Video has the highest number of films released, reaching over 4000, while Disney+ and Hulu have relatively few, only around 1000. This reflects the differences in content supply among different platforms and may also reflect their positioning and audience groups. In this bar chart, I use different colors to fill the columns of each platform, making the data more transparent and easier to compare the differences. Through this visualization approach, users can better understand the number of movies on various streaming platforms and their differences in movie production. 
