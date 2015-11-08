# source data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "dataset.zip", method = "curl", mode = "wb")
unzip("dataset.zip")
unlink("dataset.zip")

# load data
rawData <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";",
                    stringsAsFactors = FALSE, na.strings="?")
data <- subset(rawData, Date == "1/2/2007" | Date == "2/2/2007")

# create variables in correct format
dateTime <- strptime(paste(data$Date, data$Time, sep = " "), 
                     format = "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(data$Global_active_power)
globalReactivePower <- as.numeric(data$Global_reactive_power)
voltage <- as.numeric(data$Voltage)
subMetering1 <- as.numeric(data$Sub_metering_1)
subMetering2 <- as.numeric(data$Sub_metering_2)
subMetering3 <- as.numeric(data$Sub_metering_3)

png("plot4.png", height = 480, width = 480)

# set layout for 4 plots
par(mfrow = c(2, 2))

# plot 1
plot(dateTime, globalActivePower, type = "l", xlab = "", ylab = "Global Active Power")

# plot 2
plot(dateTime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# plot 3
plot(dateTime, subMetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dateTime, subMetering2, type = "l", col = "red")
lines(dateTime, subMetering3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1), col = c("black", "red", "blue"), bty = "n")

# plot 4
plot(dateTime, globalReactivePower, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()