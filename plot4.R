# Download data file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
# Unzip data and load csv file
data <- read.csv(unz(temp, "household_power_consumption.txt"), header = T, sep=';')
unlink(temp)

# Transform date column
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
# Select rows where date is '2007-02-01' or '2007-02-02'
data <- data[data$Date == '2007-02-01' | data$Date == '2007-02-02',]

# Write subdata
write.csv(data, 'finaldata.txt')
# Reload subdata
data <- read.csv('finaldata.txt', header=T, sep=',')

# Set local do 'English'
Sys.setlocale("LC_TIME", "English") 

# Open plot device
png('plot4.png', width = 480, height=480)

# Set disposal of plot
par(mfrow=c(2, 2))

# Plot first graphic
plot(
  strptime(
    paste(
      as.character(data$Date),
      as.character(data$Time),
      sep=' '
    ),
    format="%Y-%m-%d %H:%M:%S"
  ),
  data$Global_active_power,
  type='l',
  main="",
  ylab='Global Active Power',
  xlab=""
)

# Plot second graphic
plot(
  strptime(
    paste(
      as.character(data$Date), 
      as.character(data$Time),
      sep=' '
    ),
    format="%Y-%m-%d %H:%M:%S"
  ),
  data$Voltage,
  type='l',
  main="", 
  ylab='Voltage', 
  xlab="datetime"
)

# Plot third graphic
plot(
  strptime(
    paste(
      as.character(data$Date),
      as.character(data$Time), 
      sep=' '
    ),
    format="%Y-%m-%d %H:%M:%S"
  ),
  data$Sub_metering_1,
  col="black",
  type='l',
  main="", 
  ylab='Energy sub metering',
  xlab=""
)
lines(
  strptime(
    paste(
      as.character(data$Date), 
      as.character(data$Time),
      sep=' '
    ),
    format="%Y-%m-%d %H:%M:%S"
  ),
  data$Sub_metering_2,
  col="red"
)
lines(
  strptime(
    paste(
      as.character(data$Date),
      as.character(data$Time),
      sep=' '
    ),
    format="%Y-%m-%d %H:%M:%S"
  ),
  data$Sub_metering_3,
  col="blue"
)
legend(
  'topright', 
  legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
  col=c('black', 'red', 'blue'), 
  lty=c(1,1,1),
  bty = "n"
)

# Plot fourth graphic
plot(
  strptime(
    paste(
      as.character(data$Date),
      as.character(data$Time),
      sep=' '
    ),
    format="%Y-%m-%d %H:%M:%S"
  ),
  data$Global_reactive_power,
  type='l',
  main="", 
  ylab='Global_reactive_power', 
  xlab="datetime"
)

# Turn off plot device
dev.off()