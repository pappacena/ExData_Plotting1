lines <- grep("^[1-2]/2/2007", readLines("household_power_consumption.txt"), value=TRUE)
values <- read.csv(textConnection(lines), sep=";")
names(values) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
values$Date <- as.Date(values$Date, format="%d/%m/%Y")
values$DateTime <- strptime(paste(values$Date, values$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")

values <- subset(values, !is.na(Global_active_power))

# Plot data
png("plot4.png", width=480, height=480, units="px", bg="transparent")
with(values, {
    par(mfrow=c(2, 2))
    
    # 1st plot
    plot(DateTime, Global_active_power, type="n",
         xlab="", ylab="Global Active Power")
    lines(DateTime, Global_active_power)
    
    # 2nd plot
    plot(DateTime, Voltage, type="n",
         xlab="datetime", ylab="Voltage")
    lines(DateTime, Voltage)
    
    # 3rd plot
    plot(DateTime, Sub_metering_1 , type="n",
         xlab="", ylab="Energy sub metering",
         ylim=c(min(pmin(Sub_metering_1, Sub_metering_2, Sub_metering_3)),
                max(pmax(Sub_metering_1, Sub_metering_2, Sub_metering_3))))
    lines(DateTime, Sub_metering_1, col="black")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", lwd=1, box.lwd=0, box.col="transparent",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue"))
    
    # 4th plot
    plot(DateTime, Global_reactive_power, type="n",
         xlab="datetime", ylab="Global_reactive_power")    
    lines(DateTime, Global_reactive_power)
    
})
dev.off()