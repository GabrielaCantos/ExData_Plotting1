# Download the file and put the file in the "data" folder

URL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, destfile= "./data/household_power_consumption.zip", method="auto")

#Unzip DataSet to /data directory
unzip(zipfile= "./data/household_power_consumption.zip", exdir= "./data")

#Load required packages

library(data.table)
library(datasets)

#Read file

power_consumption<- read.table("./data/household_power_consumption.txt",skip = 0, header = TRUE, sep = ";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Filter data set from Feb. 1, 2007 to Feb. 2, 2007
data<- subset(power_consumption, power_consumption$Date== "1/2/2007"|power_consumption$Date=="2/2/2007")

# Remove incomplete observation

data<- data[complete.cases(data), ]

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
datatime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datatime)

# Create plot
par(mfrow= c(2,2), mar= c(4,4,2,1), oma=c(0,0,2,0))
with(data,{ 
  plot(data$Datetime, data$Global_active_power, type="l", ylab="Global Active Power", xlab=" ") 
  plot(data$Datetime, data$Voltage, type="l", ylab="Voltage", xlab=" datetime ")
  plot(data$Datetime,data$Sub_metering_1,type="l", ylab= "Energy sub metering", xlab=" ")
  lines(data$Datetime,data$Sub_metering_2, col="Red")
  lines(data$Datetime,data$Sub_metering_3, col="Blue")
  legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1, lwd=2, bty = "n")
  plot(data$Datetime, data$Global_reactive_power, type="l", ylab="Global reactive power", xlab="datetime ") 
 
})

#copying plot

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()