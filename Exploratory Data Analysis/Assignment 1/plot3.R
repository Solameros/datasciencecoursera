power_consmp <- data.table::fread(file = "./household_power_consumption.txt")

Feb_power <- power_consmp[power_consmp$Date == "1/2/2007"| power_consmp$Date == "2/2/2007" ]

#Concating date and time
newDate <- paste(Feb_power$Date," ",Feb_power$Time)

#Changing format to Date
newDate <- strptime(newDate, "%d/%m/%Y %H:%M:%S")

#Adding it to data
Feb_power <- cbind(newDate, Feb_power)
Feb_power$Global_active_power <- as.numeric(Feb_power$Global_active_power)

#plot3
plot(Feb_power$newDate, Feb_power$Sub_metering_1, type = 'l', xlab = "", ylab = "Energy submetering") 
lines(Feb_power$newDate, Feb_power$Sub_metering_2, col = "red") 
lines(Feb_power$newDate, Feb_power$Sub_metering_3, col = "blue")
#lty is the line type
legend(x = "topright", legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3" ), lty = c(1,1,1), col = c("black", "red", "blue"))
dev.copy(png, file="plot3.png", height = 480, width = 480)
dev.off()
