# Exploratory Data Analysis : Course Project 1
# plot1.R constructs 480x480 pixel plot1.png 
# Dataset : Electric Power Consumption (Days 2007-02-01 & 2007-02-02)
#   Graph   : histogram with red columns
#   Title   : Global Active Power
#   x-axis  : Global Active Power (kilowatts)
#   y-axis  : Frequency

plot1 <- function() {
    if (!file.exists("household_power_consumption.txt")) 
        return("Error: Need Electric Power Consumption data in working directory.")
    targetData <- read.table(pipe
        ('grep "^[1-2]/2/2007" household_power_consumption.txt'),
        sep=";", as.is = TRUE, 
        col.names = c("Date", "Time", "global_active_power", 
                      "Global_reactive_power", "Voltage", "Global_intensity",
                      "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    hist(targetData$global_active_power, col="red", main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)")
    dev.copy(png, file="plot1.png", width=480, height=480)
    dev.off()
}