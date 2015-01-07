# get the class of each column to make it faster
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, mode="wb")
unzip(temp, "household_power_consumption.txt")
elecDataFirst <- read.table("household_power_consumption.txt",header = T,
                            sep = ";",nrows=3)
classes <- sapply(elecDataFirst, class)
elecData <- read.table("./household_power_consumption.txt",header = T,
                       colClasses = classes,nrows=2075263,sep = ";",
                       comment.char = "",na.strings = "?")

# transfer the Date column to "Date" class
elecData$Date <- as.Date(elecData$Date, format = "%d/%m/%Y")
elecData <- subset(elecData,elecData$Date=="2007-02-01"|elecData$Date=="2007-02-02")

png(filename = "plot1.png") # open a png file"
with(elecData,hist(Global_active_power,col="red",main="Global Active Power",
                   xlab = "Global Active Power(kilowatts)"))
unlink("household_power_consumption.txt")
dev.off() #"close png file. it is very important"