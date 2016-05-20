##########################################################################################################

## Plot 3 
## Coursera Exploratory Data Analysis Week 1 Assignment
## May 19, 2016

# plot3.r 

# Purpose: Using the base plotting system, construct a graph
# of the three sub metering energies as a function of time
# over a 2-day period in February, 2007
# 

# Clean up
rm(list=ls())

# Set working directory to file in which household_power_consumption.txt resides
# E.g. setwd("/Users/Documents/YourName/data")

# Define class for each column of the data to be loaded
classes <- c("character", "character" , replicate(7, "numeric"))

# Load data
data0 <- read.table("./household_power_consumption.txt", 
                    sep=";", header = TRUE, na.strings = "?", colClasses = classes)

# Check that data has 2075259 rows and 9 columns
dim(data0)

# Fix time and date variables
t <- paste(data0$Date, data0$Time)
data0$Time <- strptime(t,'%d/%m/%Y %H:%M:%S')
data0$Date <- as.Date(data0$Date,"%d/%m/%Y")

# Filter desired data: records between 2007-02-01 and 2007-02-02
date1 = as.Date("2007-02-01")
date2 = as.Date("2007-02-02")
data <- subset(data0, Date >= date1 & Date <= date2)
rm(data0)

# Plot 3
png("plot3.png", width=480, height=480, type="quartz")
par(bg = "transparent")

with(data, plot(data$Time,data$Sub_metering_1, 
                type="n", xlab= "", ylab="Global Active Power (kilowatts)"))
lines(data$Time, data$Sub_metering_1)
lines(data$Time, data$Sub_metering_2, col='red' )
lines(data$Time, data$Sub_metering_3, col='blue1')
legend("topright", 
       col=c("black", "red", "blue1"), lty = 1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()