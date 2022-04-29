# Program 3 to plot a time series / line plot for various Energy sub-meterings (1,2 and 3)
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
data2$Sub_metering_1 <- with(data2, as.numeric(Sub_metering_1))
data2$Sub_metering_2 <- with(data2, as.numeric(Sub_metering_2))
data2$Sub_metering_3 <- with(data2, as.numeric(Sub_metering_3))

# Creating a new column for data2 by concatenating Date and Time columns
data2$Datetime <- strptime(paste(data2$Date, data2$Time), "%d/%m/%Y %H:%M:%S")

# Calling png() function to create a graphics device for PNG format bitmap files
png("plot3.png", 480, 480)

# Calling plot() function to create a line plot for Energy sub-metering1 against the Time period and
# then annotating the additional lines for Energy sub-metering2 and Energy sub-metering3
plot(data2$Datetime, data2$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub-metring")
lines(data2$Datetime, data2$Sub_metering_2, col = "red", type = "l")
lines(data2$Datetime, data2$Sub_metering_3, col = "blue", type = "l")

# Annotating Legend to the current plot
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, border = "black")

dev.off()
