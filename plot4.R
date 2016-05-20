##########################################################################################################

## Plot 4 
## Coursera Exploratory Data Analysis Week 1 Assignment
## May 19, 2016

# plot4.r 

# Purpose: Using the base plotting system and energy use data over
# a 2-day period in February, 2007, construct a multi-graph plot of 
# 1. a histogram of global active power
# 2. a line graph of voltage as a function of line
# 3. line graphs of the three sub metering energies as a function of time
# 4. a line graph of global reactive power as a function of time

# Clean up
rm(list=ls())

# Set working directory to file in which household_power_consumption.txt resides
# E.g. setwd("/Users/Documents/YourName/data")

# Define class for each column of the data to be loaded
classes <- c("character", "character" , replicate(7, "numeric"))

# Load data
data0 <- read.table("./data/household_power_consumption.txt", 
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

# Plot 4
png("plot4.png", width=480, height=480, type="quartz")
par(bg = "transparent")

par(mfrow = c(2,2))
with(data, {
  
  plot(data$Time,data$Global_active_power, 
       type="n", xlab= "", ylab="Global Active Power (kilowatts)")
  lines(data$Time,data$Global_active_power)
  
  plot(data$Time,data$Voltage, 
       type="n", xlab= "datetime", ylab="Voltage")
  lines(data$Time,data$Voltage)
  
  plot(data$Time,data$Sub_metering_1, 
       type="n", xlab= "", ylab="Energy sub metering")
  lines(data$Time, data$Sub_metering_1)
  lines(data$Time, data$Sub_metering_2, col='red' )
  lines(data$Time, data$Sub_metering_3, col='blue1')
  legend("topright", 
         col=c("black", "red", "blue1"), lty = 1, 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(data$Time,data$Global_reactive_power, 
       type="n", xlab= "datetime", ylab="Global Reactive Power (kilowatts)")
  lines(data$Time,data$Global_reactive_power)
  
})

dev.off()