library(dplyr)

result <- mtcars |>
  subset(cyl == 4) |>
  head(10)

summary_tbl <- mtcars %>%
  group_by(cyl) %>%
  summarise(mean_mpg = mean(mpg)) %>%
  arrange(desc(mean_mpg))

piped_lambda <- c(1, 4, 9) |> (\(x) sqrt(x))()
