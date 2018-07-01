setwd("/Users/Shravan")
existing<-read.csv("stations.csv")
existing$X <- NULL
library(jsonlite)
library(RCurl)
url <- ("https://feeds.citibikenyc.com/stations/stations.json")
citibike <- fromJSON(getURL(paste(url,sep="")))
stations <- citibike$stationBeanList
existing <- rbind(existing, stations)
write.csv(existing, "stations.csv")