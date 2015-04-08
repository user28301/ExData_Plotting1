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
png (file = 'plot2.png')

# Plot
plot (data$Time, data$Global_active_power, type= 'n', xaxt = 'n',
      xlab = '', ylab = 'Global Active Power (kilowatts)')
lines (data$Time, data$Global_active_power)
axis (side = 1, labels = c ('Thu', 'Fri', 'Sat'), at = c (0, 1, 2))

# Close Device
dev.off ()
