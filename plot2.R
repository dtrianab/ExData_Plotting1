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

png("plot2.png", width = 480, height = 480)
plot(t1, dt$Global_active_power, type = "l",xlab = "", ylab = "Global Active Power(kilowatts)")
dev.off()
