#load libraries
library(tidyverse)
library(dplyr)
library(readr)

#read data
movies <- read.csv("MoviesOnStreamingPlatforms.csv")

#mutate movie df so that all 0 values are NA to avoid skewing statistics.
#also changes Rotten Tomatoes rating to numeric value
#adds new column containing the service provider of the movie
movies <- movies %>%
  mutate(
    Netflix = ifelse(Netflix == 0, NA, Netflix),
    Hulu = ifelse(Hulu == 0, NA, Hulu),
    Disney. = ifelse(Disney. == 0, NA, Disney.),
    Prime.Video = ifelse(Prime.Video == 0, NA, Prime.Video),
    Rotten.Tomatoes = as.numeric(str_sub(Rotten.Tomatoes,1,2)),
    Service = case_when(
      Netflix == 1 ~ "Netflix",
      Prime.Video == 1 ~ "Prime Video",
      Hulu == 1 ~ "Hulu",
      Disney. == 1 ~ "Disney"
    )
  ) %>%
  filter(complete.cases(Rotten.Tomatoes))

#plots boxplot
ggplot(movies, aes(y = Rotten.Tomatoes)) +
  geom_boxplot() +
  labs(title = "Distribution of Ratings by Streaming Platform",
       x = "Streaming Platform", y = "Rotten Tomatoes Rating") +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  facet_grid(. ~ Service, scales = "free_x", space = "free_x")
