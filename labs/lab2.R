#imports ----
library(dplyr)

auto <- ISLR2::Auto


#Q8 ----
q8_model <- lm(mpg ~ horsepower, auto)
summary(q8_model)

predict(q8_model, data.frame(horsepower = (c(98))), interval = "prediction")

plot(auto$horsepower, auto$mpg)
abline(q8_model)

plot(q8_model)


#Q9 ----
pairs(auto)

auto |>
  select(-name) |>
  cor()

q9_model1 <- lm(mpg ~ . -name, auto)
summary(q9_model1)

plot(q9_model1)

q9_model2 <- lm(mpg ~ . -name + horsepower:origin, auto)
summary(q9_model2)

q9_model3 <- lm(mpg ~ . -name + horsepower:origin + I(horsepower^2), auto)
summary(q9_model3)

q9_model4 <- lm(mpg ~ . -name + horsepower:origin + I(log(horsepower)), auto)
summary(q9_model4)
