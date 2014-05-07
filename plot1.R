## First block of code downloads data, loads required analysis package, accesses 
## Electrical Power Consumption data from working directory, and subsets out   
## relevant data: Global Active Power for Feb 1st and 2nd, 2007) in numeric format.

## download data from https://d396qusza40orc.cloudfront.net/
## exdata%2Fdata%2Fhousehold_power_consumption.zip
url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="./ExData_Plotting1.zip")
## manually extract contents of ExData_Plotting1 (into working directory), 
## contains the data file, household_power_consumption.txt

## load required R package
library(data.table) 
## read household_power_consumption.txt into R, store as object "data"
## text file downloaded from https://d396qusza40orc.cloudfront.net/
## exdata%2Fdata%2Fhousehold_power_consumption.zip
data <- fread("./household_power_consumption.txt", header=TRUE, na.strings="?", nrows=2075259)
## subset out portion of "data" where date is Feb 1st or 2nd, 2007
reldata <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007"]
## convert Global active power to numeric vector, stored as gap
gap <- as.numeric(reldata$Global_active_power)

## Second block of code generates histogram of Global Active Power for
## Feb 1st and 2nd, 2007, saving as plot1.png.

## generate png graphic in working directory device of 480x480 pixels
png(file="./plot1.png", width=480, height=480)
## generate histogram of gap data with 12 bins, red color, labels
hist(gap, col="red", breaks=12, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
## close graphics device
dev.off()