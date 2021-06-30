##download and store data for all sites 
library(neonstore)
library(neonUtilities)

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

##leaf carbon 
DP1.10026.001

neon_download("DP1.10026.001", table = NA, site = c("KONZ", "BART", "SRER"),
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

neon_download("DP1.10014.001", table = NA, site = c("HARV", "KONZ", "BART", "SRER"),
              start_date = "2018-08-01", end_date = "2021-06-01", 
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


##litter carbon
DP1.10033.001

neon_download("DP1.10033.001", table = NA, site = c("HARV", "KONZ", "BART", "SRER"),
              start_date = "2018-08-01", end_date = "2021-06-01", 
              type = "expanded", api = "https://data.neonscience.org/api/v0")

temp.litter <- stackFromStore(filepaths=neon_dir(),
                            dpID="DP1.10033.001", 
                            pubdate="2021-06-01",
                            package="expanded")

temp.littercarbon <- temp.litter$ltr_litterCarbonNitrogen

site_id <- split(temp.littercarbon, temp.littercarbon$siteID)

HARV.litter <- site_id$HARV

KONZ.litter <- site_id$KONZ

BART.litter <- site_id$BART

SRER.litter <-site_id$SRER
