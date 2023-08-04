movies <- read.csv("MoviesOnStreamingPlatforms.csv")


movies <- movies %>%
  mutate(
    Netflix = ifelse(Netflix == 0, NA, Netflix),
    Hulu = ifelse(Hulu == 0, NA, Hulu),
    Disney. = ifelse(Disney. == 0, NA, Disney.),
    Prime.Video = ifelse(Prime.Video == 0, NA, Prime.Video),
    Rotten.Tomatoes = as.numeric(str_sub(Rotten.Tomatoes,1,2))
    )

average_yr_summary <- movies %>%
  summarise(
    avg_year_hulu = mean(Year * Hulu, na.rm = TRUE),
    avg_year_netflix = mean(Year * Netflix, na.rm = TRUE),
    avg_year_disney = mean(Year * Disney., na.rm = TRUE),
    avg_year_prime = mean(Year * Prime.Video, na.rm = TRUE)
  )

average_review_summary <- movies %>%
  summarise(
    avg_age_hulu = mean(Rotten.Tomatoes * Hulu, na.rm = TRUE),
    avg_age_netflix = mean(Rotten.Tomatoes * Netflix, na.rm = TRUE),
    avg_age_disney = mean(Rotten.Tomatoes * Disney., na.rm = TRUE),
    avg_age_prime = mean(Rotten.Tomatoes * Prime.Video, na.rm = TRUE)
  )

avg_yr_overall <- mean(movies$Year)
lowest_avg_yr <- min(average_yr_summary)
max_avg_yr <- max(average_yr_summary)

avg_review_overall <- mean(movies$Rotten.Tomatoes, na.rm = TRUE)
lowest_avg_review <- min(average_review_summary)
max_avg_review <- max(average_yr_summary)