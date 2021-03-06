##########################################################################################################

## Plot 1 
## Coursera Exploratory Data Analysis Week 1 Assignment
## May 19, 2016

# plot1.r 

# Purpose: Using the base plotting system, construct a histogram
# of global active power over a 2-day period in February, 2007
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

# Plot 1
png("plot1.png", width=480, height=480, type="quartz")
par(bg = "transparent")

hist(data$Global_active_power, 
     col = "red",
     main = "Histogram of Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.off()