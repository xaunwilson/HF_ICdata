library(httr)
library(jsonlite)

#pull API replace DP identifier with DP identifier from target dataset  
req <- GET("http://data.neonscience.org/api/v0/products/DP1.10033.001")

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
avail$data$siteCodes$siteCode[[10]]

## view available months for site
avail$data$siteCodes$availableMonths[[10]]



##downloading using API 
zipsByProduct(dpID="DP1.10014.001", site="HARV", 
              startdate="2018-05", enddate="2021-04",
              package="expanded", avg=30, check.size=T)

##if downloaded from portal start here 

stackByTable(filepath="/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_litterfall.zip")


##once dataset is downloaded once use code below to get necessary data 

LITTER <- readTableNEON(
  dataFile='/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_litterfall/stackedFiles/ltr_litterCarbonNitrogen.csv',
  varFile='/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_litterfall/stackedFiles/variables_10033.csv'
)



HARV.littercarbon <- LITTER

write.csv(HARV.littercarbon,"HARV_littercarbon", row.names = FALSE)

write.csv(HARV.littercarbon,"/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/HARV_littercarbon.csv", row.names = FALSE)




