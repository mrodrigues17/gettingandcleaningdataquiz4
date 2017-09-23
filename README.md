# gettingandcleaningdataquiz4

The American Community Survey distributes downloadable data about United States communities.
Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is
the value of the 123 element of the resulting list?

```
if(!file.exists("./quizdata")) {dir.create("./quizdata")}
Url1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(Url1, destfile = "./quizdata/community.csv", method = "curl")
community = read.csv("./quizdata/community.csv")

strsplit(names(community), "wgtp")
```
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

```
##2
if(!file.exists("./quizdata")) {dir.create("./quizdata")}
Url2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(Url2, destfile = "./quizdata/GDP.csv", method = "curl")
#read in first 216 because a total is calculated near the bottom
GDP = read.csv("./quizdata/GDP.csv", skip = 4, nrows = 216)
GDP_in_millions <- gsub(",", "", GDP$X.4)
GDP_in_millions <- as.numeric(GDP_in_millions)
mean(GDP_in_millions, na.rm = T)
```
In the data set from Question 2 what is a regular expression that would allow you to count the number
of countries whose name begins with "United"? Assume that the variable with the country names in it is
named countryNames. How many countries begin with United?
```
##3
library(dplyr)
GDP <- rename(GDP, countryNames = X.3)
grep("^United", GDP$countryNames)
```
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. Of the countries for which the end of the fiscal
year is available, how many end in June?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats


```
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
```
You can use the quantmod (http://www.quantmod.com/) package to get historical
stock prices for publicly traded companies on the NASDAQ and NYSE. Use the
following code to download data on Amazon's stock price and get the times the data was sampled.



1
2
3
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
How many values were collected in 2012? How many values were collected on Mondays in 2012?
```
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
```
