###########################################################
#                                                         #
# Coursera: Exploratory Data Analysis                     #
# Project 1: Plot3.R                                      #
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

# Finally the plot is build by first creating the main layer (Sub_metering_1 data against newdate)
# then setting up the labels for this main layer
# now the second and third layer are added to this main plot 
# (Sub_metering_2/3 data against newdate in thei own colors)
# when that's done the legend is added
with(data, {
  plot(subdata$Sub_metering_1~subdata$newdate, type="l",
       ylab="Energy sub metering", xlab="")
  lines(subdata$Sub_metering_2~subdata$newdate,col='Red')
  lines(subdata$Sub_metering_3~subdata$newdate,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Now write the plot that was created to file
dev.copy(png, file="Plot3.png", height=480, width=480)
dev.off()