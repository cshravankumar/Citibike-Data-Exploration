path_1 = "https://s3.amazonaws.com/tripdata/"
path_2 = "-citibike-tripdata.zip"

##2015 Data
for (int in 201501:201512){
  temp <- tempfile()
  download.file(paste(path_1,int, path_2, sep = ""),temp)
  file.copy(temp, "data.zip")
  unzip("data.zip")
  file.remove("data.zip")
}
##2016 Data
for (int in 201601:201612){
  temp <- tempfile()
  download.file(paste(path_1,int, path_2, sep = ""),temp)
  file.copy(temp, "data.zip")
  unzip("data.zip")
  file.remove("data.zip")
}
##2017 Data
for (int in 201701:201712){
  temp <- tempfile()
  download.file(paste(path_1,int, path_2, sep = ""),temp)
  file.copy(temp, "data.zip")
  unzip("data.zip")
  file.remove("data.zip")
}