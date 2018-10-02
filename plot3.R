## 1-LOADING THE DATA:
#####################

# Download zip file

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zfile<-file.path(getwd(),"household_power_consumption.zip")

if(!file.exists(zfile)){
	download.file(url, destfile=zfile, method="curl")
}

# Unzip file

file<-file.path(getwd(),"household_power_consumption.txt")
if(!file.exists(file)){
	unzip(zfile)
}

#Subsetting and NA values

library(dplyr)
hpc<-filter(read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=TRUE, na.strings="?"), Date %in% c("1/2/2007","2/2/2007"))

#Convert Date and Time Variables

hpc$Date<-as.Date(hpc$Date,"%d/%m/%Y")
hpc$Week_Day<-as.Date(strftime(hpc$Date,"%a"),"%a")


hpc$Time<-strptime(hpc$Time,"%H:%M:%S")	#class "POSIXlt" and "POSIXct"
hpc$time<-format(hpc$Time,format="%H:%M:%S")	#class POSIXct


## 2-MAKING PLOT:
##################


png(filename="plot3.png", width=480, height=480)
plot(x=hpc$Sub_metering_1, type="l", ylab="Energy sub metering", xaxt = "n", xlab="", col="black")
lines(x=hpc$Sub_metering_2, type="l", xaxt = "n", xlab="", col="red")
lines(x=hpc$Sub_metering_3, type="l", xaxt = "n", xlab="", col="blue")
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))
legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)
dev.off()