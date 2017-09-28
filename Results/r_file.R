library(readr)
library(plyr)
library(dplyr)

experiment_aggregates <- read_csv("C:/Users/Tej/Desktop/Jana Data Challenge/Jana Data Challenge/data/experiment-aggregates.csv")

vendor_engagement <- read_csv("C:/Users/Tej/Desktop/Jana Data Challenge/Jana Data Challenge/data/vendor-engagement.csv", 
                              col_types = cols(TIMESTAMP_DAY = col_date(format = "%Y-%m-%d")))

samosa_data <- read_csv("C:/Users/Tej/Desktop/Jana Data Challenge/Jana Data Challenge/data/samosa-data.csv", 
                        col_types = cols(DATE = col_date(format = "%m/%d/%y")))

pekora_data <- read_delim("C:/Users/Tej/Desktop/Jana Data Challenge/Jana Data Challenge/data/pekora-data.tsv", 
                          "\t", escape_double = FALSE, col_types = cols(DATE = col_date(format = "%d-%b-%Y"), 
                                                                        REVENUE = col_number()), trim_ws = TRUE)

sr = sum(samosa_data$REVENUE)
pr = sum(pekora_data$REVENUE)
revenue = c(sr,pr)

names(revenue) = c("Samosa", "Pekora")
bb=barplot(revenue, main = "Overall revenue from two variants", ylab = "Revenue in thousands", ylim = c(0,35))
text(bb,labels = revenue,pos = 3, col = "red")

plyr1 <- join(vendor_engagement, experiment_aggregates, by = "TID")
plot(pekora_data, col="red", type="o", main = "Daily Revenue")
lines(samosa_data,type = "o", col="blue")
legend("topleft", legend=c("Pekora", "Samosa"), col=c("red", "blue"), lty=1:1)

boxplot(samosa_data$REVENUE, pekora_data$REVENUE, main='Daily Revenue comparision', ylab='Revenue in thousands', names = c("Samosa", "Pekora"))

final = plyr1[c(1,3,4,5)]
sort(unique(final$TIMESTAMP_DAY))

dates <- seq(as.Date("2017-05-24"), as.Date("2017-06-25"), by=1)

df <- data.frame(Time_Date=as.Date(character()),
                 sc=numeric(),
                 pc=numeric(),
                 sni=numeric(),
                 pni=numeric(),
                 su=numeric(),
                 pu=numeric(),
                 stringsAsFactors=FALSE
                 )

for (d in dates) {
  temp = select(filter(final, TIMESTAMP_DAY == d),c(TIMESTAMP_DAY, VARIANT, CLICKS, IMPRESSIONS))
  #samosa clicks
  s_c = sum(temp$CLICKS[temp$VARIANT==1])
  p_c = sum(temp$CLICKS[temp$VARIANT==2])
  s_ni = sum(temp$VARIANT[temp$VARIANT==1&temp$IMPRESSIONS==0])
  p_ni = sum(temp$VARIANT[temp$VARIANT==2&temp$IMPRESSIONS==0])/2
  
  temp1=count(temp, VARIANT)
  s_u = as.integer(temp1[2,2])
  p_u = as.integer(temp1[3,2])
  temp_data = c(d,s_c, p_c,s_ni, p_ni, s_u, p_u)
  names(temp_data)<- c("Time_Date", "sc", "pc","sni", "pni",  "su", "pu")
  df = rbind(df, temp_data)
  
}
df
colnames(df) = c("Time_Date", "sc", "pc","sni","pni", "su", "pu")
df$Time_Date = dates

plot(df$Time_Date, df$sc, type="o", col="blue", main="Daily Clicks for Samosa and Pekora", xlab="Date", ylab = "Clicks")
lines(df$Time_Date, df$pc, type = "o", col="red")
legend("topleft", legend=c("Pekora", "Samosa"), col=c("red", "blue"), lty=1:1)

plot(df$Time_Date, df$su, type="o", col="blue", main="Users exposing to Samosa and Pekora", xlab="Date", ylab = "No.of Users")
lines(df$Time_Date, df$pu, type = "o", col="red")
legend("topleft", legend=c("Pekora", "Samosa"), col=c("red", "blue"), lty=1:1)


plot(df$Time_Date, df$su, type="p", col="blue", main="Users not getting IMPRESSIONS for Samosa and Pekora", xlab="Date", ylab = "No.of Users")
lines(df$Time_Date, df$pu, type = "p", col="red")
lines(df$Time_Date, df$sni, type = "o", col="blue")
lines(df$Time_Date, df$pni, type = "o", col="red")
legend("topleft", legend=c("Pekora", "Samosa"), col=c("red", "blue"), lty=1:1)

