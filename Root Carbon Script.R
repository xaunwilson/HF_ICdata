library(httr)
library(jsonlite)

#pull API replace DP identifier with DP identifier from target dataset  
req <- GET("http://data.neonscience.org/api/v0/products/DP1.10067.001")

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
zipsByProduct(dpID="DP1.10067.001", site="HARV", 
              startdate="2018-07", enddate="2018-08",
              package="expanded", avg=30, check.size=T)

##if downloaded from portal start here 

stackByTable(filepath="/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_chem-bio-root.zip")


##once dataset is downloaded once use code below to get necessary data 

ROOT <- readTableNEON(
  dataFile='/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_chem-bio-root/stackedFiles/bbc_rootChemistry.csv',
  varFile='/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/NEON_chem-bio-root/stackedFiles/variables_10067.csv'
)


HARV.rootcarbon <- ROOT

write.csv(HARV.rootcarbon,"HARV_rootcarbon", row.names = FALSE)

write.csv(HARV.rootcarbon,"/Users/xaunwilson/Desktop/Harvard Forest/Data/HARV/HARV_rootcarbon.csv", row.names = FALSE)




