# Program 2 to plot a time series / line plot for Global Active Power
# using the base plotting system (graphics Package) and push the graph to a png file.

# Creating a Specific Directory for this Assignment
if (!file.exists("R_Data_Plotting"))
  dir.create("R_Data_Plotting")

# Moving the Zip file to the above Directory and unzipping it
file.copy("~/Downloads/exdata_data_household_power_consumption.zip", "~/R_Data_Plotting")
setwd("~/R_Data_Plotting")
unzip("exdata_data_household_power_consumption.zip")

# Reading the input data and subsetting the required data (data between the 2 days - 01/02/2007 and 02/02/2007)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data2 <- subset(data, data$Date == "1/2/2007"|data$Date == "2/2/2007")
data2$Global_active_power <- with(data2, as.numeric(Global_active_power))

# Creating a new column for data2 by concatenating Date and Time columns
data2$Datetime <- strptime(paste(data2$Date, data2$Time), "%d/%m/%Y %H:%M:%S") 

# Calling png() function to create a graphics device for PNG format bitmap files
png("plot2.png", 480, 480)

# Calling plot() function to create a line plot for Global Active Power against the Time peroid
plot(data2$Datetime, data2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(Kilowatts)")

dev.off()
