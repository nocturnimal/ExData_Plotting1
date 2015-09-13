# Exploratory Data Analysis : Course Project 1
# plot4.R constructs 480x480 pixel plot4.png 
# Dataset : Electric Power Consumption (Days 2007-02-01 & 2007-02-02)
#   Graph   : 2x2 grid of 4 line charts
#       Global Active Power by Weekday
#       Voltage by Weekday (x axis labeled datetime)
#       Energy sub metering by Weekday (as plot 3 minus border for legend)
#       Global reactive power by Weekday (x axis labeled datetime)

plot4 <- function() {
    if (!file.exists("household_power_consumption.txt")) 
        return("Error: Need Electric Power Consumption data in working directory.")
    targetData <- read.table(pipe
        ('grep "^[1-2]/2/2007" household_power_consumption.txt'),
        sep=";", as.is = TRUE, 
        col.names = c("Date", "Time", "Global_active_power", 
                      "Global_reactive_power", "Voltage", "Global_intensity",
                      "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    targetData$Time <- paste(targetData$Date, targetData$Time)
    targetData$Time <- strptime(targetData$Time, format = "%d/%m/%Y %H:%M:%S")
    targetData$Date <- as.Date(targetData$Date, format = "%d/%m/%Y")

    par(mfrow=c(2,2))
    with(targetData, plot(Time, Global_active_power, type="l", xlab="", 
                          ylab="Global Active Power"))
    with(targetData, plot(Time, Voltage, type="l", xlab="datetime"))
    with(targetData, plot(Time, Sub_metering_1, type="n", xlab="", 
                          ylab="Energy sub metering"))
    lines(targetData$Time, targetData$Sub_metering_1, col="black")
    lines(targetData$Time, targetData$Sub_metering_2, col="red")
    lines(targetData$Time, targetData$Sub_metering_3, col="blue")
    legend("topright", lty=1, seg.len =1, cex=0.7, bty="n", 
           col=c("black", "red", "blue"),
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    with(targetData, plot(Time, Global_reactive_power, type="l", xlab="datetime"))
         
    dev.copy(png, file="plot4.png", width=480, height=480)
    dev.off()
}