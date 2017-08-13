getwd()
setwd("C:/Dades/Coursera DS/wd/assigw1")
rm(list=ls())
cat("\f")

# *************************************************************************
# Read data
# *************************************************************************
filename <- paste0("./data","/",list.files("./data", pattern="^household"))
if(!file.exists(filename)) {
    print("File not found")
    return(NULL)
}
df <- read.table(filename, 
                 header=TRUE,
                 sep=";", 
                 dec=".",
                 colClasses="character")
# Subset data to keep only Feb 1st and 2nd 2007
df <- subset(df, df$Date %in% c("1/2/2007", "2/2/2007"))

# *************************************************************************
# Cleaning Data
# *************************************************************************
# Use lowercase names
names(df) <- tolower(names(df))
# Date & Time
df$datetime <- strptime(paste0(df$date, df$time), "%d/%m/%Y %H:%M:%S")
df$date <- as.Date(df$date, "%d/%m/%Y")
# Cast Measurements as Numeric (deal with NA represented by ?)
for(i in seq_along(df)[3:9]) {
    df[,i] <- gsub("\\?", NA, df[,i])
    df[,i] <- as.numeric(df[,i])
}

# *************************************************************************
# Plot 4: 2x2 plot matrix - 
#   (1,1) line plot, Global Active Power ~ week day (= plot 2)
#   (1,2) line plot, Voltage ~ week day (using datetime)
#   (2,1) line plot Sub metering 1,2,3 ~ week day (= plot 3)
#   (2,2) line plot, Global Reactive Power ~ week day (using datetime)
# *************************************************************************
png(file = "plot4.png", width=480, height=480)
par(mfcol=c(2,2),mar=c(5,5,1,1))
with(df, 
     plot(datetime, global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power")
) 
plot(df$datetime, df$sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(df$datetime, df$sub_metering_2, col="red")
lines(df$datetime, df$sub_metering_3, col="blue")
legend("topright",
       lty=1, lwd=2.5,
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(df, 
     plot(datetime, voltage, 
          type="l", 
          xlab="datetime", 
          ylab="Voltage")
) 
with(df, 
     plot(datetime, global_reactive_power, 
          type="l", 
          xlab="datetime", 
          ylab="Global_reactive_power")
) 
dev.off()
