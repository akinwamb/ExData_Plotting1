	# Read in the data
	data <- read.csv("household_power_consumption.txt", sep=";", na.strings=c("?", "NA"), as.is=T)
	
	# Data from the dates 2007-02-01 and 2007-02-02
	dat <- subset(data, Date == "1/2/2007"|Date =="2/2/2007", select = Date:Sub_metering_3)
	dat[,1] <- as.Date(dat[,1], format = "%d/%m/%Y")  ## Format Date column as date
	
	# Combine Date and Time columns together
	x <- paste(dat$Date,dat$Time) 
	datetime <- strptime(x, format="%Y-%m-%d %H:%M:%S") ## Create new column
	mydata <- cbind(datetime, dat[,c(3,4,5,6,7,8,9)]) ## New data to use
	
	# create the histogram on screen device with appropriate labels
	with(mydata, hist(Global_active_power, main="Global Active Power",
			xlab="Global Active Power (Kilowatts)", col="red"))
	dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
	dev.off() ## Close the PNG device!