library(httr)
library(jsonlite)

#pull API replace DP identifier with DP identifier from target dataset  
req <- GET("http://data.neonscience.org/api/v0/products/DP1.00094.001")

#status 200 means success

req.text <- content(req, as="text")
avail <- jsonlite::fromJSON(req.text, simplifyDataFrame=T, flatten=T)

#show avail to see what it's storing, but output will take up a lot of space in console 
print(avail)

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

## API's for available site and month
salinity.urls <- unlist(avail$data$siteCodes$availableDataUrls[[14]])

## total number of URLs

length(salinity.urls)

##show last 20 urls 
salinity.urls[-1:-(length(salinity.urls) - 20)]

##show first 10 urls 
salinity.urls[1:10]

salinity <- GET(salinity.urls[grep("HARV/2021-05", salinity.urls)])
salinity.files <- jsonlite::fromJSON((content(salinity, as="text")))

salinity.files$data$files

vst.maptag <- read.csv(salinity.files$data$files$url
                       [grep("variables", 
                             salinity.files$data$files$name)])

salinity.files.name <- salinity.files$data$files$name



#########

zipsByProduct(dpID="DP1.00094.001", site="HARV", 
              startdate="2018-08", enddate="2021-05",
              package="expanded", avg=30, check.size=T)

stackByTable(filepath="/Users/xaunwilson/github/HF_ICdata/filesToStack00094")


MOIST <- readTableNEON(
  dataFile='/Users/xaunwilson/github/HF_ICdata/filesToStack00094/stackedFiles/SWS_30_minute.csv',
  varFile='/Users/xaunwilson/github/HF_ICdata/filesToStack00094/stackedFiles/variables_00094.csv'
)

HARV.soilmoisture <- MOIST

write.csv(HARV.soilmoisture,"/Users/xaunwilson/github/HF_ICdata\\HARV_soilmoisture.csv", row.names = FALSE)

write.csv(HARV.soilmoisture,"HARV_soilmoisture", row.names = FALSE)

##read in soil moisture data once downloaded 

MOIST2 <- read.csv("/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/HARV_soilmoisture.csv")


