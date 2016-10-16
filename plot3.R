# Get the data
fileName <- "household_power_consumption.txt"
full <- read.table(fileName, header = TRUE, sep = ";", na.strings = "?")

# Keep only the useful data
hpc <- subset(full, full$Date %in% c("1/2/2007","2/2/2007"))
rm(full)

# Convert the data
hpc$Time <- strptime(paste(hpc$Date,hpc$Time,sep = " "), "%d/%m/%Y %H:%M:%S")
hpc$Date <- strptime(hpc$Date, "%d/%m/%Y")
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))

# Draw the plot
png("plot3.png", width= 480, height = 480, units= "px")
with(hpc, plot(Time, Sub_metering_1, col = "black", xlab = "", ylab = "Energy sub metering", type = "l", xaxt = "n"))
with(hpc, lines(Time, Sub_metering_2, col = "red", type = "l"))
with(hpc, lines(Time, Sub_metering_3, col = "blue", type = "l"))
tics <- as.POSIXct(strptime(c("1/2/2007 00:00:00", "2/2/2007 00:00:00", "2/2/2007 23:59:00"), "%d/%m/%Y %H:%M:%S"))
axis(side = 1, at = tics, labels = c("Thu", "Fri", "Sat"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()
