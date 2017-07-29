#Exploratory Analysis - Project1

## download files decompress
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "./household_power_consumption.txt"

# check file if already available
if(!file.exists(household_data)){
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
png("plot3.png")

# plot data
plot(hpc_data$datetime,hpc_data$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering"
)
lines(hpc_data$datetime,hpc_data$Sub_metering_2,col="red")
lines(hpc_data$datetime,hpc_data$Sub_metering_3,col="blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c("black","red","blue"),lty=1:2)

# save plot to image
dev.off()