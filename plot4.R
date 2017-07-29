#Exploratory Analysis - Project1

## download files decompress
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "./household_power_consumption.txt"

# check file if already available
if(!file.exists(filename)){
  download.file(url,"./dataset.zip")
  unzip("./dataset.zip")
}

# load and subset data
hpc_data <- subset(read.table(filename,nrows = -1,sep = ";",header = TRUE, stringsAsFactors=FALSE, na.string="?"), 
                   Date == "1/2/2007" | Date == "2/2/2007",select=c(Date:Sub_metering_3))

# Create datetime field
hpc_data$Date <- as.Date(hpc_data$Date,"%d/%m/%Y")
hpc_data$datetime <- paste(hpc_data$Date, hpc_data$Time)
hpc_data$datetime <-  strptime(hpc_data$datetime, format="%Y-%m-%d %H:%M:%S", tz="")

# init image png for plot
png("plot4.png")

# init drawing 2x2
par(mfrow=c(2,2))

# plot 1
plot(hpc_data$datetime,as.numeric(hpc_data$Global_active_power),
     type="l",
     xlab="",
     ylab="Global Active Power"
)

## plot2
plot(hpc_data$datetime,as.numeric(hpc_data$Voltage),
     type="l",
     main="Global Active Power", 
     xlab="datetime", 
     ylab="Voltage"
)

# plot3
plot(hpc_data$datetime,hpc_data$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering"
)
# line for submetering 2
lines(hpc_data$datetime,hpc_data$Sub_metering_2,col="red")
# line for submetering 3
lines(hpc_data$datetime,hpc_data$Sub_metering_3,col="blue")
# add legend
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c("black","red","blue"),lty=1:2,bty="n")

# plot4
plot(hpc_data$datetime,hpc_data$Global_reactive_power,
     type="l",
     col="black",
     xlab="datetime",
     ylab="Global_reactive_power"
)

# save plot to image
dev.off()