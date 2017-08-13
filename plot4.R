source("getdata.R")
df <- getdata()

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
