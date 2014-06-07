
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


## Output plot to a png file
png(file="plot4.png", height=480, width=480, units="px")

par(mfrow=c(2,2), mar=c(4,4,2,1))

## Plot multiple lines for Sub metering 1, 2 and 3 data over time
with(powerData, {

        ## Create first plot
        plot(Time,Global_active_power, type="l", xlab="", ylab="Global Active Power")

        ## Create second plot
        plot(Time,Voltage, type="l", xlab="datetime")

        ## Create third plot
        plot(Time,Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(Time, Sub_metering_2, col="red")
        lines(Time, Sub_metering_3, col="blue")

        ## Create legend for third plot
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            lty=1, bty="n", col=c("black","red","blue"))
     
        ## Create fourth plot
        plot(Time,Global_reactive_power, type="l", xlab="datetime")
})

dev.off()