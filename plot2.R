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
