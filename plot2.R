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

# plot
plot(dateTime, globalActivePower, type = "l", main = "Global Active Power",
     xlab = "", ylab = "Global Active Power (kilowatts)")

# save to png file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()