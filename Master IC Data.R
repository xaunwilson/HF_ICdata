##download and store data for all sites 
library(neonstore)
library(neonUtilities)

#to find downloaded data look for file within 'R' folder tiled 'neonstore'. info from each data product will be included in folder titled with corresponding DP identifier 

#show directory
neon_dir()



##soil moisture 

neon_download("DP1.00094.001", table = NA, site = c("HARV","KONZ", "BART", "SRER"),
              start_date = "2018-08-01", end_date = "2020-10-01", 
              type = "expanded", api = "https://data.neonscience.org/api/v0")

temp.moist <- stackFromStore(filepaths=neon_dir(),
                             dpID="DP1.00094.0011", 
                             pubdate="2018-08-01",
                             package="expanded")


##soil carbon 
#DP1.10086.001

neon_download("DP1.10086.001", table = NA, site = c("HARV"),
              start_date = "2018-08-01", end_date = "2020-10-01", 
              type = "expanded",api = "https://data.neonscience.org/api/v0")

temp.soil <- stackFromStore(filepaths=neon_dir(),
                            dpID="DP1.10086.001", 
                            pubdate="2021-06-01",
                            package="expanded")

temp.soilcarbon <- temp.soil$ntr_internalLab

site_id <- split(temp.soilcarbon, temp.soilcarbon$siteID)

HARV.soil <- site_id$HARV

KONZ.soil <-site_id$KONZ

##leaf carbon 
DP1.10026.001

neon_download("DP1.10026.001", table = NA, site = c("HARV", "KONZ", "BART", "SRER"),
              start_date = "2018-08-01", end_date = "2020-10-01", 
              type = "expanded", api = "https://data.neonscience.org/api/v0")

temp.leaf <- stackFromStore(filepaths=neon_dir(),
                             dpID="DP1.10026.001", 
                             pubdate="2021-06-01",
                             package="expanded")

temp.leafcarbon <- temp.leaf$cfc_carbonNitrogen

site_id <- split(temp.leafcarbon, temp.leafcarbon$siteID)

HARV.leaf <- site_id$HARV


#####woody carbon##### 

##root carbon
DP1.10067.001

neon_download("DP1.10067.001", table = NA, site = c("HARV", "KONZ", "BART", "SRER"),
              start_date = "2018-08-01", end_date = "2021-06-01", 
              type = "expanded", api = "https://data.neonscience.org/api/v0")

neon_download("DP1.10067.001", table = NA, site = "SRER",
              start_date = "2018-08-01", end_date = "2021-06-01", 
              type = "expanded", api = "https://data.neonscience.org/api/v0")

temp.root <- stackFromStore(filepaths=neon_dir(),
                            dpID="DP1.10067.001", 
                            pubdate="2021-06-01",
                            package="expanded")

temp.rootcarbon <- temp.root$bbc_rootChemistry

site_id <- split(temp.rootcarbon, temp.rootcarbon$siteID)

HARV.root <- site_id$HARV

KONZ.root <- site_id$KONZ

BART.root <- site_id$BART

SRER.root <-site_id$SRER

##downed wood carbon
DP1.10014.001

neon_download("DP1.10014.001", table = NA, site = c("OSBS"),
              start_date = "2016-01-01", end_date = "2021-06-01", 
              type = "basic", api = "https://data.neonscience.org/api/v0")

temp.wood <- stackFromStore(filepaths=neon_dir(),
                            dpID="DP1.10014.001", 
                            pubdate="2021-06-01",
                            package="basic")

temp.woodcarbon <- temp.wood$cdw_densitydisk

site_id <- split(temp.woodcarbon, temp.woodcarbon$siteID)

HARV.wood <- site_id$HARV

KONZ.wood <- site_id$KONZ

BART.wood <- site_id$BART

SRER.wood <-site_id$SRER

OSBS.wood <- site_id$OSBS


##litter carbon
DP1.10033.001

neon_download("DP1.10033.001", table = NA, site = c("OSBS"),
              start_date = "2016-01-01", end_date = "2021-06-01", 
              type = "basic", api = "https://data.neonscience.org/api/v0")

temp.litter <- stackFromStore(filepaths=neon_dir(),
                            dpID="DP1.10033.001", 
                            pubdate="2021-06-01",
                            package="basic")

temp.littercarbon <- temp.litter$ltr_litterCarbonNitrogen

site_id <- split(temp.littercarbon, temp.littercarbon$siteID)

HARV.litter <- site_id$HARV

KONZ.litter <- site_id$KONZ

BART.litter <- site_id$BART

SRER.litter <-site_id$SRER

OSBS.litter <-site_id$OSBS


##aboveground carbon

library(tidyverse)


HARV.leafsum <- data.frame(HARV.leaf$uid, HARV.leaf$namedLocation, 
                           HARV.leaf$siteID, HARV.leaf$collectDate,
                           HARV.leaf$d13C, HARV.leaf$carbonPercent)


HARV.leafsum <- rename(HARV.leafsum, 
    uid = HARV.leaf.uid,
    namedLocation = HARV.leaf.namedLocation,
    collectDate = HARV.leaf.collectDate,
    siteID = HARV.leaf.siteID,
    leaf.d13C = HARV.leaf.d13C,
    leaf.carbonPercent = HARV.leaf.carbonPercent,
  )

HARV.littersum <- data.frame(HARV.litter$uid, HARV.litter$namedLocation, 
                           HARV.litter$siteID, HARV.litter$collectDate,
                           HARV.litter$d13C, HARV.litter$carbonPercent)

HARV.littersum <- rename(HARV.littersum, 
                       uid = HARV.litter.uid,
                       namedLocation = HARV.litter.namedLocation,
                       collectDate = HARV.litter.collectDate,
                       siteID = HARV.litter.siteID,
                       litter.d13C = HARV.litter.d13C,
                       litter.carbonPercent = HARV.litter.carbonPercent,
)

HARV.woodsum <- data.frame(HARV.wood$uid, HARV.wood$namedLocation, 
                             HARV.wood$siteID, HARV.wood$collectDate,
                             HARV.wood$diameter, HARV.wood$bulkDensVolume,
                           HARV.wood$diskFreshMass,HARV.wood$sampleFreshMass, 
                           HARV.wood$subsampleFreshMassRatio, HARV.wood$dryMass,
                           HARV.wood$diskDryMass)

HARV.woodsum <- rename(HARV.woodsum, 
                         uid = HARV.wood.uid,
                         namedLocation = HARV.wood.namedLocation,
                         siteID = HARV.wood.siteID,
                        collectDate = HARV.wood.collectDate
)


#HARV.carbon <- full_join(HARV.leafsum, HARV.littersum, HARV.woodsum,
                          by= c("namedLocation", "collectDate"))
                         
#HARV.carbon2 <- merge(HARV.leafsum, HARV.littersum, HARV.woodsum, 
                     by = c("namedLocation", "collectDate"))



df_list <- list(HARV.woodsum, HARV.leafsum, HARV.littersum)


HARV.carbon <-Reduce(function(x, y) merge(x, y, all=TRUE), df_list, accumulate=FALSE)

write.csv( HARV.carbon,"/projectnb/dietzelab/xwilson1/Harv Carbon.csv", row.names = FALSE)



help(write.csv)
                     
                     