###########################################################
#                                                         #
# Coursera: Exploratory Data Analysis                     #
# Project 1: Plot1.R                                      #
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

# Finally plot the histogram for Global_active_power (energy) column data
hist(subdata$Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# Now write the plot that was created to file
dev.copy(png, file="Plot1.png", height=480, width=480)
dev.off()
