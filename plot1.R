#Use the directory ".data' as working directory
if (!file.exists ("./data")){
   dir.create("./data")
}
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

# Create the histogram

hist(data$Global_active_power, main="Global Active Power", xlab= "Global Active Power (Kilowatts)", col= "red")

#copying plot

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()


