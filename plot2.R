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
png('plot2.png', width = 480, height=480)

# Plot line
plot(
  strptime(
    paste(
      as.character(data$Date), 
      as.character(data$Time), 
      sep=' '), 
    format="%Y-%m-%d %H:%M:%S"
  ),
  data$Global_active_power,
  type='l',
  main="", ylab='Global Active Power (kilowatts)', 
  xlab="",
  yaxt='n'
)
# Plot y axis
axis(2, at=c(0, 2, 4, 6))

# Turn plot device off
dev.off()