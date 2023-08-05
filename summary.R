#load data
movies <- read.csv("MoviesOnStreamingPlatforms.csv")

#change 0 to na for the streaming platform indicator
movies <- movies %>%
  mutate(
    Netflix = ifelse(Netflix == 0, NA, Netflix),
    Hulu = ifelse(Hulu == 0, NA, Hulu),
    Disney. = ifelse(Disney. == 0, NA, Disney.),
    Prime.Video = ifelse(Prime.Video == 0, NA, Prime.Video),
    Rotten.Tomatoes = as.numeric(str_sub(Rotten.Tomatoes,1,2))
    )

#find avg year per platform
average_yr_summary <- movies %>%
  summarise(
    avg_year_hulu = mean(Year * Hulu, na.rm = TRUE),
    avg_year_netflix = mean(Year * Netflix, na.rm = TRUE),
    avg_year_disney = mean(Year * Disney., na.rm = TRUE),
    avg_year_prime = mean(Year * Prime.Video, na.rm = TRUE)
  )

#find avg review per platform
average_review_summary <- movies %>%
  summarise(
    avg_age_hulu = mean(Rotten.Tomatoes * Hulu, na.rm = TRUE),
    avg_age_netflix = mean(Rotten.Tomatoes * Netflix, na.rm = TRUE),
    avg_age_disney = mean(Rotten.Tomatoes * Disney., na.rm = TRUE),
    avg_age_prime = mean(Rotten.Tomatoes * Prime.Video, na.rm = TRUE)
  )

summary_info <- list()

#finding year averages
summary_info$avg_yr_overall <- mean(movies$Year)
summary_info$lowest_avg_yr <- min(average_yr_summary)
summary_info$max_avg_yr <- max(average_yr_summary)

#finding rating averages
summary_info$avg_review_overall <- mean(movies$Rotten.Tomatoes, na.rm = TRUE)
summary_info$lowest_avg_review <- min(average_review_summary)
summary_info$max_avg_review <- max(average_yr_summary)

#number of movies
summary_info$total <- nrow(movies)
