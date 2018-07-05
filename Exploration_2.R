## Setting work dir
setwd("/Users/Shravan/Citibike")
## Reading data
Aug_2016 <- read.csv("201608-citibike-tripdata.csv")
Aug_2016$date<- as.Date(Aug_2016$starttime)
Aug_2016$day <- weekdays(Aug_2016$date)
Aug_2016$starttime_formated <- strptime(Aug_2016$starttime ,"%m/%d/%Y %H:%M:%S")
Aug_2016$starthour <- as.integer(format(Aug_2016$starttime_formated, "%H"))
Aug_2016$startmin <- as.integer(format(Aug_2016$starttime_formated, "%M"))
Aug_2016$morning <- 0
Aug_2016$afternoon <- 0
Aug_2016$evening <- 0
Aug_2016$night <- 0
Aug_2016$morning[Aug_2016$starthour < 10 & Aug_2016$starthour > 6] <- 1
Aug_2016$weekendflag[(Aug_2016$day == "Saturday") | Aug_2016$day == "Sunday"] <- 1
Aug_2016$weekendflag[is.na(Aug_2016$weekendflag)] <- 0

###Init Data Analysis
##Popular start hours
hist(Aug_2016$starthour)

##Customer split
table(Aug_2016$usertype)

## Segmenting Data
Customer <- Aug_2016[Aug_2016$usertype == "Customer", ]
Subscriber <- Aug_2016[Aug_2016$usertype == "Subscriber", ]

##Analysis for Subscribers
Weekdaysubset <- Subscriber[Subscriber$weekendflag == 0,]
Weekendsubset <- Subscriber[Subscriber$weekendflag == 1,]
Weekdaysubset$key <- paste(Weekdaysubset$start.station.id, Weekdaysubset$end.station.id, sep = "")
FreqTab <- as.data.frame(table(Weekdaysubset$key))
keyval <- data.frame(Weekdaysubset$start.station.name, Weekdaysubset$end.station.name, Weekdaysubset$key)
keyval <- keyval[!duplicated(keyval),]
colnames(keyval) <- c("start", "stop", "Var1")
merged_FreqTab <- merge(keyval, FreqTab, all = T)
merged_FreqTab <- merged_FreqTab[merged_FreqTab$Freq > 50, ]

##Morning Commute Study
Weekdaysubset <- Weekdaysubset[Weekdaysubset$morning == 1,]
Weekdaysubset$key <- paste(Weekdaysubset$start.station.id, Weekdaysubset$end.station.id, sep = "")
FreqTab <- as.data.frame(table(Weekdaysubset$key))
keyval <- data.frame(Weekdaysubset$start.station.name, Weekdaysubset$end.station.name, Weekdaysubset$key)
keyval <- keyval[!duplicated(keyval),]
colnames(keyval) <- c("start", "stop", "Var1")
merged_FreqTab <- merge(keyval, FreqTab, all = T)
merged_FreqTab <- merged_FreqTab[merged_FreqTab$Freq > 50, ]

Weekendsubset$key <- paste(Weekendsubset$start.station.id, Weekendsubset$end.station.id, sep = "")
FreqTab <- as.data.frame(table(Weekendsubset$key))
keyval <- data.frame(Weekendsubset$start.station.name, Weekendsubset$end.station.name, Weekendsubset$key)
keyval <- keyval[!duplicated(keyval),]
colnames(keyval) <- c("start", "stop", "Var1")
merged_FreqTab <- merge(keyval, FreqTab, all = T)
merged_FreqTab <- merged_FreqTab[merged_FreqTab$Freq > 10, ]

##Peak Time
hist(Subscriber$starthour)
hist(Weekdaysubset$starthour)
hist(Weekendsubset$starthour)

##Analysis for Customers
Weekdaysubset <- Customer[Customer$weekendflag == 0,]
Weekendsubset <- Customer[Customer$weekendflag == 1,]
Weekdaysubset$key <- paste(Weekdaysubset$start.station.id, Weekdaysubset$end.station.id, sep = "")
FreqTab <- as.data.frame(table(Weekdaysubset$key))
keyval <- data.frame(Weekdaysubset$start.station.name, Weekdaysubset$end.station.name, Weekdaysubset$key)
keyval <- keyval[!duplicated(keyval),]
colnames(keyval) <- c("start", "stop", "Var1")
merged_FreqTab <- merge(keyval, FreqTab, all = T)
merged_FreqTab <- merged_FreqTab[merged_FreqTab$Freq > 50, ]

Weekendsubset$key <- paste(Weekendsubset$start.station.id, Weekendsubset$end.station.id, sep = "")
FreqTab <- as.data.frame(table(Weekendsubset$key))
keyval <- data.frame(Weekendsubset$start.station.name, Weekendsubset$end.station.name, Weekendsubset$key)
keyval <- keyval[!duplicated(keyval),]
colnames(keyval) <- c("start", "stop", "Var1")
merged_FreqTab <- merge(keyval, FreqTab, all = T)
merged_FreqTab <- merged_FreqTab[merged_FreqTab$Freq > 10, ]

##Peak Time
hist(Customer$starthour)
hist(Weekdaysubset$starthour)
hist(Weekendsubset$starthour)


Aug_2016 <- read.csv("201608-citibike-tripdata.csv")

### Most popular month in 2016 analysis
path = "-citibike-tripdata.csv"
for (int in 201601:201612){
  
  temp <- read.csv(paste(int, path, sep = ""))
  
  if(exists("dataset_2016")){
    dataset_2016 <- rbind(dataset_2016, temp)
  } else {
    
    dataset_2016 <- temp
    
  }
  
  rm(temp)
}

