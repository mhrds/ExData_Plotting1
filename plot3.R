source("getdata.R")
df <- getdata()

# *************************************************************************
# Plot 3: line plot Sub metering 1,2,3 ~ week day
# *************************************************************************
png(file = "plot3.png", width=480, height=480)
par(mfrow=c(1,1),mar=c(5,5,1,1))
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
dev.off()
