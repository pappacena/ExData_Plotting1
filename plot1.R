lines <- grep("^[1-2]/2/2007", readLines("household_power_consumption.txt"), value=TRUE)
values <- read.csv(textConnection(lines), sep=";")
names(values) <- c("Data", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

png("plot1.png", width=480, height=480, units="px", bg="transparent")
with(values, hist(Global_active_power, col='red', 
                  xlab="Global Active Power (kilowatts)", 
                  ylab="Frequency", 
                  main="Global Active Power"))
dev.off()