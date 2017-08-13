source("getdata.R")
df <- getdata()

# *************************************************************************
# Plot 2: line plot, Global Active Power ~ week day
# *************************************************************************
png(file = "plot2.png", width=480, height=480)
par(mfrow=c(1,1),mar=c(5,5,1,1))
with(df, 
     plot(datetime, global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power (kilowatts)")
) 
dev.off()
