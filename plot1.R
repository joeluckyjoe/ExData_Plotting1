##  download the zip file to your current working directory

setwd("C:/Users/P06226/datascienceeda/ExData_Plotting1")

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("./household_power_consumption.zip")) {
        download.file(zipUrl, destfile = "./household_power_consumption.zip",
                      method = "internal", mode="wb")
}


## get the complete data

household_power_consumptionunz <- unz("./household_power_consumption.zip",
                                      "household_power_consumption.txt")

household_power_consumption <- read.csv(household_power_consumptionunz, header = TRUE,
                                        sep = ";", 
                                        colClasses = c("character", "character", "numeric", 
                                                       "numeric", "numeric", "numeric",
                                                       "numeric", "numeric", "numeric"),
                                        na.strings = "?") 


## convert Time column using strptime()

household_power_consumption$Time <- strptime(paste(household_power_consumption$Date, 
                                                   household_power_consumption$Time),
                                             format = "%d/%m/%Y %H:%M:%S")


## convert Date column using as.date()

household_power_consumption$Date <- as.Date(household_power_consumption$Date, format = "%d/%m/%Y")

## subset the data from the dates 2007-02-01 and 2007-02-02

subset <- household_power_consumption[which(
        household_power_consumption$Date == "2007-02-01" |
        household_power_consumption$Date == "2007-02-02"),]

## open png device

png(filename = "plot1.png")

## plot the histogram with appropriate color, title and label

hist(subset$Global_active_power,col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## close the file device

dev.off()
