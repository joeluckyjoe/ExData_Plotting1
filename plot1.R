## plot1.R will create plot1.png which corresponds to plot1 of the Course Project 1 of the
## Exploratory Data Analysis course.
## It will first download household_power_consumption.zip to the current working directory
## if it does not already exist.
## It will also subset the data from the dates 2007-02-01 and 2007-02-02.
## Finaly, it will  create an histogram of Global_active_power

##  download the zip file to your current working directory

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


## create a datetime  column using strptime()

household_power_consumption$datetime <- strptime(paste(household_power_consumption$Date,
                                                       household_power_consumption$Time),
                                                 format = "%d/%m/%Y %H:%M:%S")


## subset the data from the dates 2007-02-01 and 2007-02-02

subset <- household_power_consumption[which(
        as.Date(household_power_consumption$Date, format = "%d/%m/%Y") == "2007-02-01" |
                as.Date(household_power_consumption$Date, format = "%d/%m/%Y") == "2007-02-02"),]

## open png device

png(filename = "plot1.png")

Sys.setlocale("LC_TIME", "English") ## change locale to English

with(subset, {
        ## plot Global_active_power
        hist(Global_active_power,
             col = "red",
             main = "Global Active Power",
             xlab = "Global Active Power (kilowatts)")
        
        })

## close the file device

dev.off()
