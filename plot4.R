temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, mode="wb")
unzip(temp, "household_power_consumption.txt")
# get the class of each column to make it faster
elecDataFirst <- read.table("household_power_consumption.txt",header = T,
                            sep = ";",nrows=3)
classes <- sapply(elecDataFirst, class)
# load the data
elecData <- read.table("./household_power_consumption.txt",header = T,
                       colClasses = classes,nrows=2075263,sep = ";",
                       comment.char = "",na.strings = "?")

# add a column called DateandTime
elecData$DateandTime <- as.POSIXct(paste(elecData$Date,elecData$Time),
                                   format="%d/%m/%Y %H:%M:%S")
# transfer the Date column to Date class then pick the date we need
elecData$Date <- as.Date(elecData$Date, format = "%d/%m/%Y")
elecData <- subset(elecData,elecData$Date=="2007-02-01"|elecData$Date=="2007-02-02")

# draw the plot
png("plo4.png")
par(mfrow=c(2,2))
#first plot
with(elecData,plot(DateandTime,Global_active_power,type = "l",
                   ylab = "Global Active Power",xlab=""))
#Second plot
with(elecData,plot(DateandTime,Voltage,type="l",xlab="datetime"))
#third plot
with(elecData,plot(DateandTime,Sub_metering_1,type="l",
                   ylab = "Energy sub metering",xlab=""))
with(elecData,lines(DateandTime,Sub_metering_2,col="red"))
with(elecData,lines(DateandTime,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#fourth plot
with(elecData,plot(DateandTime,Global_reactive_power,type="l",xlab="datetime"))

dev.off()
unlink("household_power_consumption.txt")
