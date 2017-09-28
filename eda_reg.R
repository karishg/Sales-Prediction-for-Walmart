#upload data form local drive
wm_features <- read.csv(file="E:\\BGSU\\APPLD_REG\\proj\\walmart_summary_calcs.csv", header=TRUE)
attach(wm_features)


hist(wm_features$Store)

#transformed with log looks good for weekly sales.
hist(wm_features$Weekly_Sales)
logs<-log(wm_features$Weekly_Sales^-0.25)
hist(logs)


# Not sure why R2 is less!!!!
model2 <- lm(Store~Weekly_Sales)
summary(model2)

x= log(wm_features$Weekly_Sales)


#Box plot comparision considering each year.
boxplot(wm_features$Weekly_Sales~wm_features$Year, main="years",ylab="weekly sales")

# we have to clean the data, remove the NAs and then try.. Getting error.
#In log(wm_features$Weekly_Sales) : NaNs produce
boxplot(log(wm_features$Weekly_Sales)~wm_features$Year, log="wm_features$Weekly_Sales") # Data on log scale; less right-skewed



# If straightening or smoothening reqd??
plot(Store, Weekly_Sales)


# For IsHoliday we need to take categorical 2 way analysis. 
# Will be continued...


