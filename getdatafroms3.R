if(!sum(installed.packages()[,"Package"] == "aws.s3")){
  install.packages("aws.s3", repos = c("cloudyr" = "http://cloudyr.github.io/drat")) 
}
library("aws.s3")
Sys.setenv("AWS_ACCESS_KEY_ID" = "","AWS_SECRET_ACCESS_KEY" = "","AWS_DEFAULT_REGION" = "us-east-1")
bucketlist_s3 <- bucketlist()
citibike_dumps <- get_bucket_df(bucket = 'citibike-bucket', max = Inf)
citibike_dumps_list <- citibike_dumps[2]$Contents$Key
s3Data <- NULL
LineN <- as.data.frame(citibike_dumps$Key)

a=0
for(i in 1:nrow(LineN)){

  url <- LineN[i,]
  url <- paste('s3://citibike-bucket/', url, sep = "")
  s3Vector <- get_object(url)
  s3Value <- rawToChar(s3Vector)
  s3json <- jsonlite::fromJSON(s3Value)
  temp <- s3json$stationBeanList
  
  if(i==1){
    bigdataset <- temp
    
  }else{
    bigdataset <- rbind(bigdataset, temp)
  }
  
}
