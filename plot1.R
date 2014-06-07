
## Read file data into table.
## Separator in file is ";" and NA values in file are "?"
library(data.table)
powerData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

## Convert Date column/variable to Date class
powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")

## Only keep data from the dates 2007-02-01 and 2007-02-02
powerData <- subset(powerData,powerData$Date>="2007-02-01" & powerData$Date<="2007-02-02")

## Convert Date and Time columns/variables to Date and Time classes respectively
powerData$Time <- strptime(paste(powerData$Date,powerData$Time), "%Y-%m-%d %T")



result <- subset(housingData, housingData$VAL == 24)
print(result)



## Download file from website to local directory

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL, destfile="./CleaningData/NaturalGas.xlsx")
dateDownloaded <- date()

## Read XLS file data into table
library(xlsx)
rowInd <- 18:23
colInd <- 7:15
dat <- read.xlsx("./CleaningData/NaturalGas.xlsx", sheetIndex=1, rowIndex=rowInd, colIndex=colInd, header=TRUE)
print(dat)

sum(dat$Zip*dat$Ext,na.rm=T)



## Download file from website to local directory

library(XML)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data <- xmlTreeParse(fileURL, useInternal=TRUE)

## Read XLS file data into table
rootNode <- xmlRoot(data)

## xmlName(rootNode)
## names(rootNode)

result <- xpathSApply(rootNode,"//zipcode[.='21231']", xmlValue)
length(result)



## Download file from website to local directory

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile="./CleaningData/IDHousingSurvey2.csv")
dateDownloaded <- date()

## Read file data into table

DT <- fread("./CleaningData/IDHousingSurvey2.csv")
DT[,mean(pwgtp15), by=SEX]