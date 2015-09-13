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

# Open device
png('plot1.png', width = 480, height=480)

# Plot histogram
hist(
  data$Global_active_power,
  xlim=c(0,8), 
  col='red', 
  main="Global Active Power", 
  xlab='Global Active Power (kilowatts)', 
  xaxt='n', 
  yaxt='n'
)
# Plot axis
axis(1, at=c(0,2,4,6))
axis(2, at=c(0,200,400,600,800,1000,1200))

# Turn off plot device
dev.off()