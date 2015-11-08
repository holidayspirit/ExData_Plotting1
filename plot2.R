#Input data.  Get col names from reading in the header row first, then assigning col names from the header row.
#Only input the 2880 rows of data needed.  Remove factors.
headerRow <- read.csv("household_power_consumption.txt",sep=";", nrows=1)
dataSet <- read.csv("household_power_consumption.txt",sep=";",skip=66637, 
                        nrows=2880, header=FALSE, col.names = names(headerRow), stringsAsFactors = FALSE)

#Get DateTime field
dataSet$DateTime <- paste(dataSet$Date, dataSet$Time, sep = " ")
dataSet$DateTime <- strptime(dataSet$DateTime, "%d/%m/%Y %H:%M:%S")

#Create the png file
png(file="plot2.png", width=480, height=480)

#Plot the lines
plot(dataSet$DateTime, dataSet$Global_active_power, ylab="Global Active Power (kilowatts)",
        xlab="", pch = "", lines(dataSet$DateTime,dataSet$Global_active_power))

#Close png device
dev.off()