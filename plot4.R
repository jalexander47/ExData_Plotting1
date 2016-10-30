## Download the Data if it does not already exist


if(!file.exists('data.zip')){
    url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"

    download.file(url,destfile = "data.zip")
}

## Will unzip the text file "household_power_consumption.txt"

unzip("data.zip") 

require(data.table)
data <- fread(input="household_power_consumption.txt", sep=";", header = T, na.strings = "?")
data[,Date2:=as.Date(Date, format = "%d/%m/%Y")]
data <- data[data$Date2 > as.Date("2007-01-31"),]
data <- data[data$Date2 <= as.Date("2007-02-02"),]

# plot 4
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(x = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"), y = as.numeric(data$Global_active_power), xlab="", ylab="Global Active Power (kilowatts)", type="l")
plot(x = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"), y = as.numeric(data$Voltage), xlab="datetime", ylab="Voltage", type="l")
plot(x = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"), y = data$Sub_metering_1, xlab="", ylab = "Energy sub metering", type = "n")
lines(x = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"), y = data$Sub_metering_1, col = "black")
lines(x = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"), y = data$Sub_metering_2, col = "red")
lines(x = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"), y = data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = c(1,1,1), bty = "n")
plot(x = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"), y = as.numeric(data$Global_reactive_power), xlab="", ylab="Global_reactive_power", type="l")
dev.off()