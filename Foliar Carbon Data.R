library(httr)
library(jsonlite)

#pull API replace DP identifier with DP identifier from target dataset  
req <- GET("http://data.neonscience.org/api/v0/products/DP1.10026.001")

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
avail$data$siteCodes$siteCode[[10]]

## view available months for site
avail$data$siteCodes$availableMonths[[10]]



##downloading using API 
zipsByProduct(dpID="DP1.10026.001", site="HARV", 
              startdate="2016-08", enddate="2020-09",
              package="expanded", avg=30, check.size=T)

##if downloaded from table start here 

stackByTable(filepath="/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_traits-foliar.zip")


##once dataset is downloaded once use code below to get necessary data 

FOL <- readTableNEON(
  dataFile='/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_traits-foliar/stackedFiles/cfc_carbonNitrogen.csv',
  varFile='/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_traits-foliar/stackedFiles/variables_10026.csv'
)

HARV.foliar <- data.frame(FOL$plotID, FOL$plotType, 
                          FOL$collectDate, FOL$co2Trapped, 
                          FOL$d15N, FOL$d13C, FOL$nitrogenPercent, 
                          FOL$carbonPercent, FOL$CNratio)
  
write.csv(HARV.foliar,"HARV_leafcarbon", row.names = FALSE)

write.csv(HARV.foliar,"/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/HARV_leafcarbon.csv", row.names = FALSE)
  
  