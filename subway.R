path = "http://web.mta.info/developers/data/nyct/turnstile/turnstile_180630.txt"
a <- read.csv(path)
booth <- read.csv("Remote-Booth-Station.csv")
#a$key1 <- paste(a$C.A, a$UNIT, a$SCP, a$STATION, a$LINENAME, a$DIVISION ,sep = "")
#a$key2 <- paste(a$TIME, a$DATE, sep = "")
a$DATE <- as.Date(strptime(a$DATE, "%m/%d/%Y"))
a$key <- paste(a$UNIT, a$DATE, sep = "")
a$key_2 <- paste(a$UNIT, a$DATE, a$TIME, sep = "")
d <- aggregate(ENTRIES ~ key_2, a, sum)
e <- aggregate(EXITS ~ key_2, a, sum)
e <- merge(d,e)
tab1 <- data.frame(a$UNIT, a$DATE, a$TIME, a$key_2)
e <- merge(e, tab1)
#tabs <- data.frame(a$key1, a$key2, a$ENTRIES, a$EXITS)
#colnames(tabs) <- c("key1", "key2", "Entry_sub", "Exit_sub")
#library(data.table)
#tabs <- data.table(tabs)
#minimums<-tabs[ , .SD[which.min(key2)], by = key1]
#minimums$key2 <- NULL
#merged <- merge(a, minimums)
#merged$ENTRIES <- merged$ENTRIES - merged$Entry_sub
#merged$EXITS <- merged$EXITS - merged$Exit_sub

b<- aggregate(ENTRIES ~ key, a, sum)
c<- aggregate(EXITS ~ key, a, sum)