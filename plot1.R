## This is to get the name of the days in English in the plots
if (Sys.getlocale(category = "LC_TIME") != "English_United States.1252")
{
    Sys.setlocale("LC_TIME", "English")
    print("LC_TIME changed to English")
}

##download and unzip the data
if (!file.exists("power_consumption.zip"))
{
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  "power_consumption.zip")
}

unzip(zipfile = "power_consumption.zip", exdir = "data")

##read data
data <- read.table(file = "data/household_power_consumption.txt", header = TRUE, sep = ";",na.strings = "?",
                   colClasses=c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", "numeric"))

##convert to datetime and filter
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

##create new column with date and time
data$DateTime <- strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")


##open png and create the plot
png(filename = "figure/plot1.png", width = 480, height = 480)

hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     main="Global Active Power",ylim = c(0,1200))

##close png file
dev.off()
