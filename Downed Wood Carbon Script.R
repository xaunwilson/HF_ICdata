library(httr)
library(jsonlite)

#pull API replace DP identifier with DP identifier from target dataset  
req <- GET("http://data.neonscience.org/api/v0/products/DP1.10014.001")

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
              startdate="2018-05", enddate="2018-10",
              package="expanded", avg=30, check.size=T)

##if downloaded from portal start here 

stackByTable(filepath="/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_bulk-density-downed-wood.zip")


##once dataset is downloaded once use code below to get necessary data 

WOOD <- readTableNEON(
  dataFile='/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_bulk-density-downed-wood/stackedFiles/cdw_densitydisk.csv',
  varFile='/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_bulk-density-downed-wood/stackedFiles/variables_10014.csv'
)



HARV.downedwoodcarbon <- WOOD

write.csv(HARV.downedwoodcarbon,"HARV_downedwoodcarbon", row.names = FALSE)

write.csv(HARV.downedwoodcarbon,"/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/HARV_downedwoodcarbon.csv", row.names = FALSE)




