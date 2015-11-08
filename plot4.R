#Input data.  Get col names from reading in the header row first, then assigning col names from the header row.
#Only input the 2880 rows of data needed.  Remove factors.
headerRow <- read.csv("household_power_consumption.txt",sep=";", nrows=1)
dataSet <- read.csv("household_power_consumption.txt",sep=";",skip=66637, 
                    nrows=2880, header=FALSE, col.names = names(headerRow), stringsAsFactors = FALSE)

#Get DateTime field
dataSet$datetime <- paste(dataSet$Date, dataSet$Time, sep = " ")
dataSet$datetime <- strptime(dataSet$datetime, "%d/%m/%Y %H:%M:%S")

#Create the png file
png(file="plot4.png", width=480, height=480)

#Create 4 sections
par(mfrow=c(2,2))

#Add the plots
with(dataSet, {
        #Top left plot
        plot(dataSet$datetime, dataSet$Global_active_power, ylab="Global Active Power",
             xlab="", pch = "", lines(dataSet$datetime,dataSet$Global_active_power))
        
        #Top right plot
        plot(dataSet$datetime, dataSet$Voltage, col="black", ylab="Voltage",
             xlab="datetime", pch = "", lines(dataSet$datetime,dataSet$Voltage))
        
        #Bottom left plot
        plot(dataSet$datetime, dataSet$Sub_metering_1, col="black", ylab="Energy sub metering",
             xlab="", pch = "", lines(dataSet$datetime,dataSet$Sub_metering_1))
        
                #Add the other two lines
                lines(dataSet$datetime,dataSet$Sub_metering_2, col="red")
                lines(dataSet$datetime,dataSet$Sub_metering_3, col="blue")
                
                #Add the legend
                legend("topright", pch = "", lty=1, col = c("black", "red", "blue"), 
                       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")
        
        #Bottom right plot
        plot(dataSet$datetime, dataSet$Global_reactive_power, col="black", ylab="Global_reactive_power",
             xlab="datetime", pch = "", lines(dataSet$datetime,dataSet$Global_reactive_power))
})

#Close png device
dev.off()