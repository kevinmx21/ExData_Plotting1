library(dplyr)

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "household_power_consumption.zip")
unzip(zipfile = "household_power_consumption.zip",overwrite = TRUE)

elec_pwr <- read.csv(".\\household_power_consumption.txt",sep=";",header = TRUE,stringsAsFactors=FALSE,na.strings='?',colClasses=c("character","character",rep("numeric",7)))
elec_pwr_2days <- subset(elec_pwr,elec_pwr$Date == "1/2/2007"|elec_pwr$Date == "2/2/2007")
elec_pwr_2days <- mutate(elec_pwr_2days,DateTime = as.POSIXct(paste(Date,Time,sep = " "),format='%d/%m/%Y  %H:%M:%S'))


dev.print(png, file = "plot3.png", width = 480, height = 480)
png(file = "plot3.png", bg = "transparent")
with(elec_pwr_2days,plot(DateTime,Sub_metering_1,type="l",ylim = c(0,40),xlab = "", ylab = ""))
par(new = T)
with(elec_pwr_2days,plot(DateTime,Sub_metering_2,type="l",ylim = c(0,40),xlab = "", ylab = "",col = "Red"))
par(new = T)
with(elec_pwr_2days,plot(DateTime,Sub_metering_3,type="l",ylim = c(0,40),xlab = "", ylab = "Energy sub metering",col = "Blue"))
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), col=c("Black","Red","Blue"))
dev.off()