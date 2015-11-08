# source data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "dataset.zip", method = "curl", mode = "wb")
unzip("dataset.zip")
unlink("dataset.zip")

# load data
rawData <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";",
                    stringsAsFactors = FALSE, na.strings="?")
data <- subset(rawData, Date == "1/2/2007" | Date == "2/2/2007")

# plot
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# save to png file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()