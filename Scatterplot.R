library(tidyverse)
library(dplyr)
library(readr)

data <- read.csv("1.csv")

# Chart 2: Release Years of Streaming Platforms (Scatterplot)
latest_movies <- data %>%
  filter(Year >= 2010) %>%
  summarise(
    Netflix = sum(Netflix, na.rm = TRUE),
    Hulu = sum(Hulu, na.rm = TRUE),
    Prime = sum(Prime.Video, na.rm = TRUE),
    Disney = sum(Disney., na.rm = TRUE)
  )
classic_movies <- data %>%
  filter(Year <= 2000) %>%
  summarise(
    Netflix = sum(Netflix, na.rm = TRUE),
    Hulu = sum(Hulu, na.rm = TRUE),
    Prime = sum(Prime.Video, na.rm = TRUE),
    Disney = sum(Disney., na.rm = TRUE)
  )

aggregate_info1 <- bind_rows(
  mutate(latest_movies, Year_Range = "Latest (>= 2010)"),
  mutate(classic_movies, Year_Range = "Classic (<= 2000)")
)
aggregate_info2 <- pivot_longer(aggregate_info1,
                                cols = c(Netflix, Hulu, Prime, Disney),
                                names_to = "Streaming_Platforms",
                                values_to = "Total_Movies")
ggplot(aggregate_info2) +
  geom_point(size = 3, position = position_dodge(width = 0.5)) + aes(
    x = Year_Range,
    y = Total_Movies,
    color = Streaming_Platforms) +
  labs(title = "Movie Release Years by Streaming Platforms",
       x = "Year Range",
       y = "Total Movies",
       color = "Streaming Platforms")

# The purpose of adding this scatter plot is to compare the release years of movies on different streaming platforms and reveal differences in user preferences for the latest or classic movies. The chart shows that the movie libraries of Prime Video and Netflix mainly focus on recent movies, with fewer containing classic movies from nearly 2000 years. In contrast, Disney+ and Hulu's movie library specifically includes movies from 10 years ago, and they have more classic movies than the other two platforms. In this scatter plot, I use the release year of the latest and classic movies as the x-axis, different platforms as color codes, and the points in the scatter plot are located in different year positions. This allows users to visually see the differences in time dimensions of each platform, helping them choose the platform that suits their taste.
