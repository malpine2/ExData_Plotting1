require(dplyr)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
rawdata <- read.delim(unz(temp, "household_power_consumption.txt"), sep = ";")
unlink(temp)

dates <- as.Date(rawdata$Date, "%d/%m/%Y")
x <- paste(dates, rawdata$Time)
datetime <- strptime(x, "%Y-%m-%d %H:%M:%S")

formatted <- cbind(dates, datetime, rawdata)

tidy <- formatted %>%
        filter(dates == "2007-02-01" | dates == "2007-02-02") %>%
        select(datetime,
               Global_active_power, 
               Global_reactive_power, 
               Voltage, 
               Global_intensity, 
               Sub_metering_1, 
               Sub_metering_2, 
               Sub_metering_3)

png(filename = "plot3.png")

with(tidy, 
     plot(datetime, 
          Sub_metering_1, 
          type = "n", 
          ylab = "Energy Sub Metering", 
          xlab = " "))

lines(tidy$datetime, tidy$Sub_metering_1)

lines(tidy$datetime, tidy$Sub_metering_2, col = "red")

lines(tidy$datetime, tidy$Sub_metering_3, col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1) ## Specifies line type for icons next to legend items

dev.off()