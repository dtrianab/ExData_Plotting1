library(data.table)
library(chron)
library(dplyr)
library(ggplot2)
library(scales)

data_p1 <-fread("household_power_consumption.txt")

#Date: Date in format dd/mm/yyyy
data_p1$Date<-as.Date(data_p1$Date, format = "%d/%m/%Y")

#Time: time in format hh:mm:ss
data_p1$Time<-chron(times=data_p1$Time)

#Rest of variables as numeric
data_p1<-data_p1 %>% mutate_if(is.character, as.numeric)

#data for (2007-02-01 and 2007-02-02)
dt<-data_p1[which(data_p1$Date=="2007-02-01" | data_p1$Date=="2007-02-02"),]


t1<-as.POSIXct(paste(dt$Date, dt$Time), format="%Y-%m-%d %H:%M:%S")
t2<-as.Date(t1)

png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
plot(t1, dt$Global_active_power, type = "l",xlab = "", ylab = "Global Active Power(kilowatts)")

plot(t1, dt$Voltage, type = "l",xlab = "datetime", ylab = "Voltage")

plot(t1, dt$Sub_metering_1, type = "l",xlab = "", ylab = "Energy Sub Metering")
lines(t1, dt$Sub_metering_2, col="red",lty=1)
lines(t1, dt$Sub_metering_3, col="blue",lty=1)
leg<-c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
legend("topright", bty = "n",legend = leg, col=c("black","red","blue"),lty=c(1,1,1), ncol=1)

plot(t1, dt$Global_reactive_power, type = "l",xlab = "datetime", ylab = "Global Reactive Power")


dev.off()
