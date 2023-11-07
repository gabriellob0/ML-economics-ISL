#imports ----
library(dplyr)
library(tidyr)
library(purrr)

raw_college <- ISLR2::College
raw_auto <- ISLR2::Auto


#Q8 ----
summary(raw_college)

raw_college |>
  select(1:10) |>
  pairs()

plot(raw_college$Private, raw_college$Outstate)

clean_college <- raw_college |>
  mutate(Elite = as.factor(if_else(Top10perc > 50, "Yes", "No")))

summary(clean_college)

plot(clean_college$Elite, clean_college$Outstate)


#Q9 ----
glimpse(raw_auto)

generate_summary <- function(raw_data) {
  
  summary_fns <- list(range = range, mean = mean, sd = sd)
  
  summary_stats <- raw_auto |>
    select(where(is.numeric)) |>
    map(\(x) map(summary_fns, exec, x, !!!list(na.rm = TRUE)))
  
  summary_dataframe <- summary_stats |>
    map(as_tibble) |>
    bind_rows(.id="names")
  
  ordered_data <- summary_dataframe |>
    group_by(names) |>
    arrange(range) |>
    mutate(range_type = if_else(row_number() == 1, "low", "high")) |>
    pivot_wider(names_from = "range_type",
                names_prefix = "range_",
                values_from = "range")

  return(ordered_data)
}

generate_summary(raw_auto)

raw_auto |>
  slice(-(10:85)) |>
  generate_summary()

raw_auto |>
  select(where(is.numeric)) |>
  names() |>
  map(\(x) plot(raw_auto |> pull(x), raw_auto$mpg))


#Q10