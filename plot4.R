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
png("plot4.png", width= 480, height = 480, units= "px")
par(mfrow = c(2,2))
with(hpc, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", xaxt = "n"))
tics <- as.POSIXct(strptime(c("1/2/2007 00:00:00", "2/2/2007 00:00:00", "2/2/2007 23:59:00"), "%d/%m/%Y %H:%M:%S"))
axis(side = 1, at = tics, labels = c("Thu", "Fri", "Sat"))
with(hpc, plot(Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n"))
axis(side = 1, at = tics, labels = c("Thu", "Fri", "Sat"))
with(hpc, plot(Time, Sub_metering_1, col ="black", type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n"))
with(hpc, lines(Time, Sub_metering_2, col ="red", type = "l"))
with(hpc, lines(Time, Sub_metering_3, col ="blue", type = "l"))
axis(side = 1, at = tics, labels = c("Thu", "Fri", "Sat"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
with(hpc, plot(Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n"))
axis(side = 1, at = tics, labels = c("Thu", "Fri", "Sat"))
dev.off()
