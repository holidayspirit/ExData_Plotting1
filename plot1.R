#Input data.  Get col names from reading in the header row first, then assigning col names from the header row.
#Only input the 2880 rows of data needed.  Remove factors.
headerRow <- read.csv("household_power_consumption.txt",sep=";", nrows=1)
dataSet <- read.csv("household_power_consumption.txt",sep=";",skip=66637, nrows=2880, header=FALSE, col.names = names(headerRow))

#Create the png file
png(file="plot1.png", width=480, height=480)

#Draw histogram in red
hist(dataSet$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power" )

#Close png device
dev.off()