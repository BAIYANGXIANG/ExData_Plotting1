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

# add a column called DateandTime
elecData$DateandTime <- as.POSIXct(paste(elecData$Date,elecData$Time),
                                   format="%d/%m/%Y %H:%M:%S")
# transfer the Date column to Date class then pick the date we need
elecData$Date <- as.Date(elecData$Date, format = "%d/%m/%Y")
elecData <- subset(elecData,elecData$Date=="2007-02-01"|elecData$Date=="2007-02-02")

# Draw our plot
png("plot2.png")
with(elecData,plot(DateandTime,Global_active_power,type = "l",
                   ylab = "Global Active Power (kilowatts)",xlab=""))
dev.off()

unlink("household_power_consumption.txt")