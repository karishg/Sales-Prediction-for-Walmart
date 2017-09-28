wm_features <- read.csv(file="C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\features.csv", header=TRUE)
head(wm_features)

wm_stores <- read.csv(file="C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\stores.csv", header=TRUE)
head(wm_stores)

wm_train <- read.csv(file="C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\train.csv", header=TRUE)
head(wm_train)

wm_test <- read.csv(file="C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\test.csv", header=TRUE)
head(wm_test)

install.packages("dplyr")
library(dplyr)
datasources <- list(wm_features, wm_stores, wm_train)

walmart_final <- full_join(wm_train, wm_stores, by="Store")
head(walmart_final)
walmart_final <- left_join(walmart_final, wm_features, by = c("Store","Date"))
head(walmart_final)

class(wm_features$Date)
class(walmart_final$Date)

write.csv(walmart_final, file = "C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\walmart_final.csv")
