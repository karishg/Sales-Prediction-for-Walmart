library(dplyr)
#upload data form local drive
wm_features <- read.csv(file="C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\features.csv", header=TRUE)
head(wm_features)

wm_stores <- read.csv(file="C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\stores.csv", header=TRUE)
head(wm_stores)

wm_train <- read.csv(file="C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\train.csv", header=TRUE)
head(wm_train)

wm_test <- read.csv(file="C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\test.csv", header=TRUE)
head(wm_test)

#Create new data frame with first join
walmart_final <- full_join(wm_train, wm_stores, by="Store")
#Sample results
head(walmart_final)
#Finalize Merge results with next join
walmart_final <- left_join(walmart_final, wm_features, by = c("Store","Date"))
#Sample results
head(walmart_final)

#Extract Date to multiple columns for Year, Month, Day
walmart_final$Year<-substr(walmart_final$Date,1,4)
walmart_final$Month<-substr(walmart_final$Date,6,7)
walmart_final$Day<-substr(walmart_final$Date,9,10)

#Create file of merged data
write.csv(walmart_final, file = "C:\\Users\\Brett\\Documents\\BGSU\\Regression Analysis\\Project\\walmart_final.csv")

#Aggregate Raw data to month level with several store-level attributes
walmart_summary<-aggregate(Weekly_Sales~Month+Year+Store+Type+Size, data=walmart_final, FUN = sum)
#Rename column to avoid confusion :)
names(walmart_summary)[6]<-"Monthly_Sales"

#model that achieves 93% Adj-RSquared on monthly aggregate data
summary(lm(data=walmart_summary,Monthly_Sales~as.character(Store)+Type+Month))