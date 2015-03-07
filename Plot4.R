###########################################################
#                                                         #
# Coursera: Exploratory Data Analysis                     #
# Project 1: Plot4.R                                      #
# Mischa Beckers                                          #
# 2015-03-05                                              #
#                                                         #
###########################################################

# First read the data
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Next convert the Date values to the proper format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Only keep the rows for Dates between 2007-02-1 and 2007-02-02
subdata <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02", select=Date:Sub_metering_3)

# To be able to plot between day data Date and Time columns are combined and then converted to proper values
newdate <- paste(as.Date(subdata$Date), subdata$Time)
subdata$newdate <- as.POSIXct(newdate)

# Finally four plots are created. Indivisual plots were created the same way as in Plot1-3.R. 
# Some minor changes needed to be made in lay-outs. The four plots are put together in one 
# by means of mfrom with which a 2-rows by 2-columns frane is set up.
par(mfrow = c(2, 2)) 
with(subdata, {
  plot(subdata$Global_active_power~subdata$newdate, type="l", ylab="Global Active Power", xlab="")
  plot(subdata$Voltage~subdata$newdate, type="l", ylab="Voltage", xlab="datetime")
  plot(subdata$Sub_metering_1~subdata$newdate, type="l",
       ylab="Energy sub metering", xlab="")
  lines(subdata$Sub_metering_2~subdata$newdate,col='Red')
  lines(subdata$Sub_metering_3~subdata$newdate,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(subdata$Global_reactive_power~subdata$newdate, type="l", ylab="Global Reactive Power", xlab="datetime")
})

# Now write the plot that was created to file
dev.copy(png, file="Plot4.png", height=480, width=480)
dev.off()