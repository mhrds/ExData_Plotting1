source("getdata.R")
df <- getdata()

# *************************************************************************
# Plot 1: histogram for Global Active Power
# *************************************************************************
png(file = "plot1.png", width=480, height=480)
par(mfrow=c(1,1),mar=c(5,5,1,1))
with(df, 
     hist(df$global_active_power,
          xlab="Global Active Power (kilowatts)",
          col="red",
          main = "Global Active Power")
) 
dev.off()
