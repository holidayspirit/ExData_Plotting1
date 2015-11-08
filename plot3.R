#Input data.  Get col names from reading in the header row first, then assigning col names from the header row.
#Only input the 2880 rows of data needed.  Remove factors.
headerRow <- read.csv("household_power_consumption.txt",sep=";", nrows=1)
dataSet <- read.csv("household_power_consumption.txt",sep=";",skip=66637, 
                    nrows=2880, header=FALSE, col.names = names(headerRow), stringsAsFactors = FALSE)

#Get DateTime field
dataSet$DateTime <- paste(dataSet$Date, dataSet$Time, sep = " ")
dataSet$DateTime <- strptime(dataSet$DateTime, "%d/%m/%Y %H:%M:%S")

#Create the png file
png(file="plot3.png", width=480, height=480)

#Plot the first line
plot(dataSet$DateTime, dataSet$Sub_metering_1, col="black", ylab="Energy sub metering",
     xlab="", pch = "", lines(dataSet$DateTime,dataSet$Sub_metering_1))

#Add the other two lines
lines(dataSet$DateTime,dataSet$Sub_metering_2, col="red")
lines(dataSet$DateTime,dataSet$Sub_metering_3, col="blue")

#Add the legend
legend("topright", pch = "", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Close png device
dev.off()