#imports ----
source("src//00_libraries.R")

import_dependencies()

stock_market_data <- ISLR2::Smarket


#EDA ----
names(stock_market_data)
dim(stock_market_data)
summary(stock_market_data)

pairs(stock_market_data)

stock_market_data |>
  select(-"Direction") |>
  cor()

stock_market_data |>
  mutate(index = row_number()) |>
  ggplot(data = _, mapping = aes(x = index, y = Volume)) +
  geom_point()


#logistic regression ----
logistic_full_sample <- glm(
  Direction ~ Lag1 + Lag2 + Lag3 + Lag5 + Volume,
  data = stock_market_data, family = binomial
)

summary(logistic_full_sample)

logistic_probs <- predict(logistic_full_sample, type = "response")
logistic_probs[1:10]

contrasts(Direction)

logistic_preds <- rep("Down", 1250)
logistic_preds[logistic_probs > .5] = "Up"

table(logistic_preds, Direction)
mean(logistic_preds == Direction)

stock_train <- filter(stock_market_data, Year < 2005)
stock_test <- filter(stock_market_data, Year == 2005)

