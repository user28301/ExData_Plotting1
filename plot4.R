# We assume working directory has been set to the folder contains the data

# Read Data
data <- read.csv ('household_power_consumption.txt', na.string = '?', sep = ';')

# Convert Date
data$Date <- as.Date (data$Date, format="%d/%m/%Y")

# Select Date
date1 <- as.Date ('2007-02-01')
date2 <- as.Date ('2007-02-02')
selected <- (data$Date == date1) | (data$Date == date2)
data <- data [selected,]

baseTime = as.POSIXct ("2007-02-01 00:00:00", format = '%Y-%m-%d %H:%M:%S')
baseTime = as.numeric (baseTime) / 86400.0

data$Time = as.POSIXct (paste (data$Date, data$Time), format = '%Y-%m-%d %H:%M:%S')
data$Time = as.numeric (data$T) / 86400.0 - baseTime

# Open Device
png (file = 'plot4.png')

par (mfrow = c (2, 2))

# Plot 1-1

plot (data$Time, data$Global_active_power, type= 'n', xaxt = 'n',
      xlab = '', ylab = 'Global Active Power (kilowatts)')
lines (data$Time, data$Global_active_power)
axis (side = 1, labels = c ('Thu', 'Fri', 'Sat'), at = c (0, 1, 2))

# Plot 1-2

plot (data$Time, data$Voltage, type= 'n', xaxt = 'n',
      xlab = 'datetime', ylab = 'Voltage')
lines (data$Time, data$Voltage)
axis (side = 1, labels = c ('Thu', 'Fri', 'Sat'), at = c (0, 1, 2))

# Plot 2-1
plot (data$Time, data$Sub_metering_1, type= 'n', xaxt = 'n',
      xlab = '', ylab = 'Energy sub metering')
lines (data$Time, data$Sub_metering_1, col = 'black')
lines (data$Time, data$Sub_metering_2, col = 'red')
lines (data$Time, data$Sub_metering_3, col = 'blue')
axis (side = 1, labels = c ('Thu', 'Fri', 'Sat'), at = c (0, 1, 2))
legend ('topright', col = c ('black', 'red', 'blue'), lty = 1,
        legend = c ('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# Plot 2-2

plot (data$Time, data$Global_reactive_power, type= 'n', xaxt = 'n',
      xlab = 'datetime', ylab = 'Global_reactive_power')
lines (data$Time, data$Global_reactive_power)
axis (side = 1, labels = c ('Thu', 'Fri', 'Sat'), at = c (0, 1, 2))

# Close Device
dev.off ()
