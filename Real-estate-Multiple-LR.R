# Loading the data
df <- read.csv("Real estate.csv")
View(df)
head(df, 10)

# data cleaning
df <- df[,-c(1,2)]
head(df, 10)

# splitting data into tarin and test set
library(caTools)
set.seed(123)
split <- sample.split(Y = df$Y.house.price.of.unit.area, SplitRatio = 0.8)
train <- subset(x = df, split == T)
test <- subset(x = df, split == F)

# Build model
regressor <- lm(data = df, formula = Y.house.price.of.unit.area ~ .)
summary(regressor)
coef(regressor)

# Calculating RSE 
RSE <- sigma(regressor) * 100 / mean(df$Y.house.price.of.unit.area)
RSE 

# predict the test set
y_predict <- predict(regressor, newdata = test)
summary(y_predict)

test$y_predict <- y_predict
View(test)

install.packages("MLmetrics")
library(MLmetrics)
error <- MAPE(test$Y.house.price.of.unit.area, test$y_predict)
error

accuracy <- 1 - error
accuracy
