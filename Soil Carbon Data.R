library(httr)
library(jsonlite)

#pull API replace DP identifier with DP identifier from target dataset  
req <- GET("http://data.neonscience.org/api/v0/products/DP1.00095.001")

#status 200 means success

req.text <- content(req, as="text")
avail <- jsonlite::fromJSON(req.text, simplifyDataFrame=T, flatten=T)

#show avail to see what it's storing, but output will take up a lot of space in console 
#print(avail)

## view description 
avail$data$productDescription

## view abstract 
avail$data$productAbstract

## view available sites 
avail$data$siteCodes$siteCode

## view site [HARV], for other sites replace 13
avail$data$siteCodes$siteCode[[14]]

## view available months for site
avail$data$siteCodes$availableMonths[[14]]



##downloading using API 
zipsByProduct(dpID="DP1.00095.001", site="HARV", 
              startdate="2018-08", enddate="2021-05",
              package="expanded", avg=30, check.size=T)

##if downloaded from portal start here 

stackByTable(filepath="/Users/xaunwilson/github/HF_ICdata/filesToStack00095")


##once dataset is downloaded once use code below to get necessary data 

library(neonUtilities)
SOIL <- readTableNEON(
  dataFile='/Users/xaunwilson/github/HF_ICdata/filesToStack00095/stackedFiles/SCO2C_30_minute.csv',
  varFile='/Users/xaunwilson/github/HF_ICdata/filesToStack00095/stackedFiles/variables_00095.csv'
)


HARV.soilcarbon <- SOIL

write.csv(HARV.soilcarbon,"HARV_soilcarbon", row.names = FALSE)

write.csv(HARV.soilcarbon,"/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/HARV_soilcarbon.csv", row.names = FALSE)

  
  
  
  