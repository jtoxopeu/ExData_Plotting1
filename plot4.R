## First block of code downloads data, loads required analysis package into R, 
## accesses Electrical Power Consumption data, and subsets out relevant data from
## Feb 1st and 2nd, 2007 in numeric format, and Date & Time in time format.

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
## add a column (datetime) to the right side of the reldata
## that merges the data and time information together
reldata[,datetime:=paste(Date, Time, sep = " ")]
## convert datetime column into R time format
day <- strptime(reldata$datetime, format = "%d/%m/%Y %H:%M:%S")
## convert Global active power to numeric vector, stored as gap
gap <- as.numeric(reldata$Global_active_power)

## Second block of code generates a plate with four smooth scatterplots
## diplaying the change in four variables over time during Feb 1st & 2nd, 2007.

## generate png graphic device of 480x480 pixels
png(file="./plot4.png", width=480, height=480)
## Create parameters for 2 x 2 plot display
par(mfrow=c(2,2))
## Add upper left plot: Global Active Power (gap)
plot(day, gap, type = "l", xlab=NA, ylab ="Global Active Power")
## Add upper right plot: Voltage
plot(day, reldata$Voltage, type = "l", xlab="datetime", ylab ="Voltage")
## Add lower left plot: Energy sub metering
    ## Empty plot generated
plot(day, Sub_metering_1, xlab = NA, ylab = "Energy sub metering", type = "n")
    ## Lines for each of the three sub_metering variables added
lines(day, Sub_metering_1)
lines(day, Sub_metering_2, col = "red")
lines(day, Sub_metering_3, col = "blue")
    ## Legend added
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
      col = c("black", "blue", "red"), lty = 1, bty="n")
## Add lower right plot: Global_reactive_power
plot(day, reldata$Global_reactive_power, type = "l", xlab="datetime", 
     ylab ="Global_reactive_power")
## Close graphics device
dev.off()