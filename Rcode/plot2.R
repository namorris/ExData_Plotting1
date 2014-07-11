## Load data

if(!file.exists("data")){
    dir.create("data")
}

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="power.zip", method="curl")
powerData=read.table(unz("power.zip","household_power_consumption.txt"),sep=";",header=TRUE)

## Transform Date variable to as.Date()
powerData$Date=as.Date(powerData$Date,format="%d/%m/%Y")

## Extract observations corresponding to Feb 1st and Feb 2nd 2007.
data=subset(powerData, Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

## Format Time variable to POSIXlt format
a=paste(as.character(data$Date),as.character(data$Time),sep=" ")
b=strptime(a,format="%Y-%m-%d %H:%M")
data$Time=b

## Transform remaining variables to numeric
for (i in 3:9)
{
    data[,i]=as.numeric(as.character(data[,i]))
}

## Plot 2
png("Plot2.png",bg="white", width = 480, height = 480, units = "px")
plot(data$Time,data$Global_active_power,ylab="Global Active Power (kilowatts)",type="l",xlab="")
dev.off()