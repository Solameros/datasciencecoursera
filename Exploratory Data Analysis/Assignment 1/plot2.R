power_consmp <- data.table::fread(file = "./household_power_consumption.txt")

Feb_power <- power_consmp[power_consmp$Date == "1/2/2007"| power_consmp$Date == "2/2/2007" ]

#Concating date and time
newDate <- paste(Feb_power$Date," ",Feb_power$Time)

#Changing format to Date
newDate <- strptime(newDate, "%d/%m/%Y %H:%M:%S")

#Adding it to data
Feb_power <- cbind(newDate, Feb_power)
Feb_power$Global_active_power <- as.numeric(Feb_power$Global_active_power)

#plot2
plot(Feb_power$newDate, Feb_power$Global_active_power, type = 'l', xlab = "", ylab = "Global Active Power (kilowatts)" )
dev.copy(png, file="plot2.png", height = 480, width = 480)
dev.off()
