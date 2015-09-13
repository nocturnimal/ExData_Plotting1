# Exploratory Data Analysis : Course Project 1
# plot3.R constructs 480x480 pixel plot3.png 
# Dataset : Electric Power Consumption (Days 2007-02-01 & 2007-02-02)
#   Graph   : line chart with 3 lines
#   Legend  : color used for each line: black, red, blue  
#   x-axis    first three letters of day
#   y-axis  : Energy sub metering

plot3 <- function() {
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
    png(file="plot3.png", width=480, height=480) ; par(mar=c(6, 4, 4, 2) + 0.1)
    with(targetData, plot(Time, Sub_metering_1, type="n", xlab="", 
                          ylab="Energy sub metering"))
    lines(targetData$Time, targetData$Sub_metering_1, col="black")
    lines(targetData$Time, targetData$Sub_metering_2, col="red")
    lines(targetData$Time, targetData$Sub_metering_3, col="blue")
    legend("topright", lty=1, seg.len =1, cex=0.7, col=c("black", "red", "blue"),
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#   dev.copy(png, file="plot3.png", width=480, height=480)
    dev.off()
}