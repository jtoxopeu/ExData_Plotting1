## First block of code downloads data, loads required analysis package into R, 
## accesses Electrical Power Consumption data, and subsets out relevant data: 
## Global Active Power for Feb 1st and 2nd, 2007 in numeric format, 
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
gap <- as.numeric(reldata$Global_active_power)
## add a column (datetime) to the right side of the reldata
## that merges the data and time information together
reldata[,datetime:=paste(Date, Time, sep = " ")]
## convert datetime column into R time format
day <- strptime(reldata$datetime, format = "%d/%m/%Y %H:%M:%S")

## Second block of code generates smooth scatterplot of Global Active Power for
## over time during Feb 1st and 2nd, 2007, saving as plot2.png.

## generate png graphic device of 480x480 pixels
png(file="./plot2.png", width=480, height=480)
## generate scatterplot of gap data as a function of day, no title or x-axis label
## type="l" makes the scatterplot a smooth line.
plot(day, gap, type = "l", main=NULL, xlab=NA, 
     ylab ="Global Active Power (kilowatts)")
## close graphics device
dev.off()