library(data.table)
library(chron)
library(dplyr)

data_p1 <-fread("household_power_consumption.txt")

#Date: Date in format dd/mm/yyyy
data_p1$Date<-as.Date(data_p1$Date, format = "%d/%m/%Y")

#Time: time in format hh:mm:ss
data_p1$Time<-chron(times=data_p1$Time)

#Rest of variables as numeric
data_p1<-data_p1 %>% mutate_if(is.character, as.numeric)

#data for (2007-02-01 and 2007-02-02)
dt<-data_p1[which(data_p1$Date=="2007-02-01" | data_p1$Date=="2007-02-02"),]

png("plot1.png", width = 480, height = 480)
hist(dt$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = 2)
dev.off()
