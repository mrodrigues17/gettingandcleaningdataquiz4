if(!file.exists("./quizdata")) {dir.create("./quizdata")}
Url1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(Url1, destfile = "./quizdata/community.csv", method = "curl")
community = read.csv("./quizdata/community.csv")

strsplit(names(community), "wgtp")

##2
if(!file.exists("./quizdata")) {dir.create("./quizdata")}
Url2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(Url2, destfile = "./quizdata/GDP.csv", method = "curl")
#read in first 216 because a total is calculated near the bottom
GDP = read.csv("./quizdata/GDP.csv", skip = 4, nrows = 216)
GDP_in_millions <- gsub(",", "", GDP$X.4)
GDP_in_millions <- as.numeric(GDP_in_millions)
mean(GDP_in_millions, na.rm = T)

##3
library(dplyr)
GDP <- rename(GDP, countryNames = X.3)
grep("^United", GDP$countryNames)

#4
if(!file.exists("./quizdata")) {dir.create("./quizdata")}
Url2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(Url2, destfile = "./quizdata/GDP.csv", method = "curl")
#read in first 216 because a total is calculated near the bottom
GDP = read.csv("./quizdata/GDP.csv", skip = 4, nrows = 216)
##rename to match other file
GDP <- rename(GDP, CountryCode = X)

if(!file.exists("./quizdata")) {dir.create("./quizdata")}
Url3 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(Url3, destfile = "./quizdata/educational.csv", method = "curl")
educational = read.csv("./quizdata/educational.csv")

GDP_join <- left_join(educational, GDP, by = "CountryCode")

Junes1 <- grepl(pattern = "Fiscal year end: June", GDP_join$Special.Notes)

#5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
#subset by 2012
subsetted.times <- subset(sampleTimes, sampleTimes >= as.Date("2012-01-01") & sampleTimes <= as.Date("2012-12-31"))
length(subsetted.times)
#find weekdays
week_days <- weekdays(subsetted.times)
Mondays <- grepl("Monday", week_days)
sum(Mondays)




