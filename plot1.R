require(dplyr)

## Downloads and unzips the txt file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
rawdata <- read.delim(unz(temp, "household_power_consumption.txt"), sep = ";")
unlink(temp)

## Converts Date and Time data to POSIXlt class
dates <- as.Date(rawdata$Date, "%d/%m/%Y")
x <- paste(dates, rawdata$Time)
datetime <- strptime(x, "%Y-%m-%d %H:%M:%S")

## Adds newly formatted dates and times (now datetime) to data frame
formatted <- cbind(dates, datetime, rawdata)

## Filters to first 2 days of February 2007, selects relevant columns
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

## Opens png graphics device
png(filename = "plot1.png")

## Creates histogram
with(tidy, 
        hist(as.numeric(Global_active_power), 
        main = "Global Active Power", 
        xlab = "Global Active Power (kilowatts)", 
        col = "red"))

## Closes png graphics device
dev.off()


