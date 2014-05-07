## First block of code downloads data, loads required analysis package into R, 
## accesses Electrical Power Consumption data, and subsets out relevant data: 
## Sub_metering_1, 2, and 3 for Feb 1st and 2nd, 2007 in numeric format, 
## and Date & Time in time format.

## download data from https://d396qusza40orc.cloudfront.net/
## exdata%2Fdata%2Fhousehold_power_consumption.zip
url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="./ExData_Plotting1.zip")
## manually extract contents of ExData_Plotting1 (into working directory), 
## contains the data file, household_power_consumption.txt

## load required R package
library(data.table) 
## read household_power_consumption.txt into R, store as object "data"
data <- fread("./household_power_consumption.txt", header=TRUE, 
        na.strings="?", nrows=2075259)
## subset out portion of "data" where date is Feb 1st or 2nd, 2007
reldata <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007"]
## convert Global active power to numeric vector, stored as gap
## add a column (datetime) to the right side of the reldata
## that merges the data and time information together
reldata[,datetime:=paste(Date, Time, sep = " ")]
## convert datetime column into R time format
day <- strptime(reldata$datetime, format = "%d/%m/%Y %H:%M:%S")
## subset out sub_metering variables
Sub_metering_1 <- reldata$Sub_metering_1
Sub_metering_2 <- reldata$Sub_metering_2
Sub_metering_3 <- reldata$Sub_metering_3

## Second block of code generates smooth scatterplot of the 3 Energy sub metering
## variable over time during Feb 1st and 2nd, 2007, saving as plot3.png.

## generate png graphic device of 480x480 pixels
png(file="./plot3.png", width=480, height=480)
## generate an empty scatterplot using day and Sub_metering_1
plot(day, Sub_metering_1, xlab = NA, ylab = "Energy sub metering", type = "n")
## add each sub metering variable as a colored line
lines(day, Sub_metering_1) ## default color is black
lines(day, Sub_metering_2, col = "red")
lines(day, Sub_metering_3, col = "blue")
## add lengend to top right corner with line type = 1
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "blue", "red"), lty = 1)
## close graphics device
dev.off()