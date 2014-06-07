
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

## Plot multiple lines for Sub metering 1, 2 and 3 data over time
with(powerData,plot(Time,Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(powerData,lines(Time, Sub_metering_2, col="red"))
with(powerData,lines(Time, Sub_metering_3, col="blue"))

## Create legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, col=c("black","red","blue"))

## Output plot to a png file
dev.copy(png, file="plot3.png", height=480, width=480, units="px")
dev.off()