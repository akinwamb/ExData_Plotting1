	# Read in the data
	data <- read.csv("household_power_consumption.txt", sep=";",
				na.strings=c("?", "NA"), as.is=T)
	
	# Data from the dates 2007-02-01 and 2007-02-02
	dat <- subset(data, Date == "1/2/2007"|Date =="2/2/2007",
			select = Date:Sub_metering_3)
	dat[,1] <- as.Date(dat[,1], format = "%d/%m/%Y")  ## Format Date column as date
	
	# Combine Date and Time columns together
	x <- paste(dat$Date,dat$Time) 
	datetime <- strptime(x, format="%Y-%m-%d %H:%M:%S") ## Create new column
	mydata <- cbind(datetime, dat[,c(3,4,5,6,7,8,9)]) ## New data to use
	
	## Plot directly to a PNG file
	png("plot4.png") 
	par(mfrow = c(2,2))
	with(mydata,{
		plot(datetime, Global_active_power, type="l", xlab="",
			ylab ="Global Active Power")
		plot(datetime, Voltage, type="l")
		plot(datetime, Sub_metering_1, type = "l", col = "black",
				xlab = "", ylab = "Energy sub metering")
		lines(datetime, Sub_metering_2, col = "red")
		lines(datetime, Sub_metering_3, col = "blue")		
		legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
		lwd = 2, lty = c(1,1,1),col = c("black", "red", "blue"),pch = c(NA, NA, NA))
		plot(datetime, Global_reactive_power, type="l")
	})
	
	dev.off() ## Close the PNG device!