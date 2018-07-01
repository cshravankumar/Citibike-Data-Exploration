setwd("/Users/Shravan")
citidata <- read.csv("stations.csv")
citidata$X <- NULL
citidata$stAddress2 <- NULL
citidata$landMark <- NULL
citidata$postalCode <- NULL
citidata$altitude <- NULL
citidata$city <- NULL
citidata$location <- NULL
citidata$date<- as.Date(citidata$lastCommunicationTime)
citidata$day <- weekdays(citidata$date)
citidata$time <- strptime(citidata$lastCommunicationTime ,"%Y-%m-%d %I:%M:%S %p")
citidata$hour <- format(citidata$time, "%H")
citidata$min <- format(citidata$time, "%M")
citidata$hour <- as.integer(citidata$hour)
citidata$min <- as.integer(citidata$min)
citidata$morning <- 0
citidata$afternoon <- 0
citidata$evening <- 0
citidata$night <- 0
citidata$morning[citidata$hour < 12 & citidata$hour > 6] <- 1
citidata$weekendflag[(citidata$day == "Saturday") | citidata$day == "Sunday"] <- 1
citidata$weekendflag[is.na(citidata$weekendflag)] <- 0
citibikes <- citidata[citidata$statusValue == "In Service",]
zerodocks <- citibikes[citibikes$availableDocks == 0,]
zerodocks$hour <- as.integer(zerodocks$hour)
citidata$weekendflag <- as.integer(citidata$weekendflag)
hist(zerodocks$weekendflag)
zerodocks <- zerodocks[zerodocks$weekendflag == 0, ]
zerodocks <- zerodocks[zerodocks$morning > 0,]
zerodocks <- zerodocks
abc <- as.data.frame(table(zerodocks$stationName))
abc <- abc[abc$Freq > 0,]
plot(abc)
plot_ly(zerodocks, x = ~zerodocks$hour, y = ~zerodocks$stationName, type = 'scatter', layout(title = 'Gender Gap in Earnings per University', xaxis = list(showgrid = FALSE), yaxis = list(showgrid = FALSE)))

library(plotly) 
data <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv") 


citibikes_updated <- citibikes[citibikes$stationName == "Sterling St & Bedford Ave",]
citibikes_updated$hour <- as.integer(citibikes_updated$hour)
hist(citibikes_updated$hour)        
        
latlon <- data.frame(citidata$stationName, citidata$latitude, citidata$longitude)
latlon <- latlon[!duplicated(latlon), ]
colnames(latlon) <- c("stationName", "lat", "lon")
colnames(abc) <- c("stationName", "Freq")
abc <- merge(abc, latlon)

leaflet(abc) %>%
  addTiles() %>%
  setView(-74.00, 40.71, zoom = 12) %>% addProviderTiles("CartoDB.Positron") %>% addCircleMarkers(~abc$lon, ~abc$lat, popup = as.character(abc$Freq), label = ~as.character(abc$Freq), radius = abc$Freq^0.5)
