# Exploratory Data Analysis : Course Project 1
# plot2.R constructs 480x480 pixel plot2.png 
# Dataset : Electric Power Consumption (Days 2007-02-01 & 2007-02-02)
#   Graph   : line chart
#   x-axis    first three letters of day
#   y-axis  : Global Active Power (kilowatts)

plot2 <- function() {
    if (!file.exists("household_power_consumption.txt")) 
        return("Error: Need Electric Power Consumption data in working directory.")
    targetData <- read.table(pipe
        ('grep "^[1-2]/2/2007" household_power_consumption.txt'),
        sep=";", as.is = TRUE, 
        col.names = c("Date", "Time", "global_active_power", 
                      "Global_reactive_power", "Voltage", "Global_intensity",
                      "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    targetData$Time <- paste(targetData$Date, targetData$Time)
    targetData$Time <- strptime(targetData$Time, format = "%d/%m/%Y %H:%M:%S")
    targetData$Date <- as.Date(targetData$Date, format = "%d/%m/%Y")

    with(targetData, plot(Time, global_active_power, type="l", xlab="", 
                          ylab="Global Active Power (kilowatts)"))

    dev.copy(png, file="plot2.png", width=480, height=480)
    dev.off()
}