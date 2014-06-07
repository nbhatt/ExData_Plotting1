
## Read file data into table.
## Separator in file is ";" and NA values in file are "?"
library(data.table)
powerData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

## Convert Date column/variable to Date class
powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")

## Only keep data from the dates 2007-02-01 and 2007-02-02
powerData <- subset(powerData,powerData$Date>="2007-02-01" & powerData$Date<="2007-02-02")

## Convert Time column/variable to Time class
powerData$Time <- strptime(paste(powerData$Date,powerData$Time), "%Y-%m-%d %T")

## Create line plot of Global active power data over time
with(powerData,plot(Time,Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

## Output plot to a png file
dev.copy(png, file="plot2.png", height=480, width=480, units="px")
dev.off()