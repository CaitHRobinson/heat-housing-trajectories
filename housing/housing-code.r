## Install libraries
library(tidyverse)
library(units)
library(Rcpp)
library(tmap)
library(sf)
library(dplyr)
library(plyr)
library(readr)
library(tidyr)
library(biscale)
library(ggplot2)
library(cowplot)

## Import EPC data from multiple csv. files at once
mydir = "All" # Set directory as folder with all csv in
myfiles = list.files(path=mydir, pattern="*.csv", full.names=TRUE) # Create list of csv file names 
dat_csv_all = ldply(myfiles, read_csv) # Read in all csv files in the list

## Import UPRN and grid boundaries
Grid <- st_read("grid_5km.shp") # Read OA shapefile
UPRN <- st_read("uprn.shp") # Read UPRN shapefile
UPRN$UPRN <- as.character(UPRN$UPRN) # Convert UPRN to character
UPRN_XY <- st_write(UPRN, "UPRN_XY.csv", 
                    layer_options = "GEOMETRY=AS_XY") # Convert UPRN gpkg into a csv. with xy coordinates
UPRN_XY <- read.csv("UPRN_XY.csv")

## Join EPC data to UPRN
dat_csv_all$UPRN <- as.character(dat_csv_all$UPRN)

UPRN_EPC_XY <- dat_csv_all %>% 
  left_join(UPRN_XY, by ="UPRN") # Join two tables together so that all properties with EPC rating have a xy coordinate

UPRN_EPC_XY_new <- UPRN_EPC_XY %>% 
 drop_na(UPRN)

## Clean EPC data
UPRN_EPC_XY_new$ADDRESS_COMBINED <- paste(UPRN_EPC_XY_new$ADDRESS1, 
                                            UPRN_EPC_XY_new$ADDRESS2, 
                                            UPRN_EPC_XY_new$ADDRESS3)

UPRN_EPC_XY_new_1 <- UPRN_EPC_XY_new %>% group_by(ADDRESS_COMBINED) %>% 
  slice(which.max(as.Date(INSPECTION_DATE, '%d/%m/%y'))) # Retain one certificate for each address

UPRN_EPC_XY_new_2 <- UPRN_EPC_XY_new_1 %>% 
  filter(INSPECTION_DATE > '01/09/2012') # Filter for most recent certificates

UPRN_EPC_XY_new_3 <- UPRN_EPC_XY_new_2 %>% # Drop NA
 drop_na(X) %>%
  drop_na(Y)

UPRN_EPC_XY_new_4 <- UPRN_EPC_XY_new_3 %>%
  select(
    "X",
    "Y",
    "ADDRESS_COMBINED",
    "UPRN",
    "TENURE",
    "CURRENT_ENERGY_RATING",
    "POTENTIAL_ENERGY_RATING",
    "PROPERTY_TYPE",
    "BUILT_FORM",
    "INSPECTION_DATE",
    "TRANSACTION_TYPE",
    "TOTAL_FLOOR_AREA",
    "MAINS_GAS_FLAG",
    "MAIN_FUEL",
    "WINDOWS_DESCRIPTION",
    "MECHANICAL_VENTILATION",
    "EXTENSION_COUNT",
    "CONSTRUCTION_AGE_BAND",
    "ROOF_ENERGY_EFF")

UPRN_EPC_XY_sf <- st_as_sf(UPRN_EPC_XY_new_4, coords = c("X", "Y")) # Create sf

UPRN_EPC_XY_sf_select <- UPRN_EPC_XY_sf_select %>% 
  st_set_crs(st_crs(Grid)) # Set same coordinate system 

## Recalculate for LSOA
LSOA <- st_read("LSOA_2021_EW_BFE_V9.shp")
Points <- UPRN_EPC_XY_sf_select

lsoa <- LSOA %>% 
  st_set_crs(st_crs(Points))

### Recalculate efficiency data
Final_lsoa_efficiency <- Points %>%
  st_join(lsoa) %>%
  group_by(LSOA21CD) %>%
  dplyr::summarize(count_with_EPC = n(),
                  count_current_A = sum(CURRENT_EN == "A"),
                  count_current_B = sum(CURRENT_EN == "B"),
                  count_current_F = sum(CURRENT_EN == "F"),
                  count_current_G = sum(CURRENT_EN == "G"),
                  count_potential_A = sum(POTENTIAL_ == "A"),
                  count_potential_B = sum(POTENTIAL_ == "B"),
                  count_potential_F = sum(POTENTIAL_ == "F"),
                  count_potential_G = sum(POTENTIAL_ == "G"))

sum(Final_lsoa_efficiency$count_potential_fg)
Final_lsoa_efficiency[is.na(Final_lsoa_efficiency)] <- 0

Final_lsoa_efficiency <- Final_lsoa_efficiency %>% 
  mutate(count_with_EPC = count_with_EPC,
        count_current_fg = count_current_F + count_current_G,
        count_current_ab = count_current_A + count_current_B,
        count_potential_fg = count_potential_F + count_potential_G,
        count_potential_ab = count_potential_A + count_potential_B)

Final_lsoa_efficiency_scale <- Final_lsoa_efficiency %>%
  as_tibble() %>%
  mutate(LSOA21CD = LSOA21CD,
         z_count_current_fg = scale((count_current_fg/count_with_EPC)*100),
        per_count_current_fg = (count_current_fg/count_with_EPC)*100,
        z_count_current_ab = scale((count_current_ab/count_with_EPC)*100),
        per_count_current_atoc = (count_current_ab/count_with_EPC)*100,
        z_count_potential_fg = scale((count_potential_fg/count_with_EPC)*100),
        per_count_potential_fg = (count_potential_fg/count_with_EPC)*100,
        z_count_potential_ab = scale((count_potential_ab/count_with_EPC)*100),
        per_count_potential_ab = (count_potential_ab/count_with_EPC)*100) # Rescale as z-scores
        
## Recalculate property age data
Points$CONSTRUCTI <- as.character(Points$CONSTRUCTI)
Points$CONSTRUCTI[Points$CONSTRUCTI == 'England and Wales: before 1900'] <- 'x1900'
Points$CONSTRUCTI[Points$CONSTRUCTI == 'England and Wales: 2012 onwards'] <- 'x2012'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2012'] <- 'xx2012'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2013'] <- 'x2013'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2014'] <- 'x2014'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2015'] <- 'x2015'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2016'] <- 'x2016'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2017'] <- 'x2017'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2018'] <- 'x2018'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2019'] <- 'x2019'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2020'] <- 'x2020'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2021'] <- 'x2021'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2022'] <- 'x2022'
Points$CONSTRUCTI[Points$CONSTRUCTI == '2023'] <- 'x2023'

Points_1900 <- Points %>%
  filter(CONSTRUCTI == "x1900")

Final_lsoa_1900 <- Points_1900 %>%
  st_join(lsoa) %>%
  group_by(LSOA21CD) %>%
  dplyr::summarize(count_pre1900 = n())

sum(Final_lsoa_1900$count_pre1900)
Final_lsoa_1900[is.na(Final_lsoa_1900)] <- 0

Final_lsoa_1900$count_pre1900 <- as.numeric(Final_lsoa_1900$count_pre1900)
Final_lsoa_1900$count_with_EPC <- as.numeric(Final_lsoa_1900$count_with_EPC)

Final_lsoa_1900_scale <- Final_lsoa_1900 %>%
  as_tibble() %>%
  mutate(LSOA21CD = LSOA21CD,
         z_count_pre1900 = scale((count_pre1900/count_with_EPC)*100),
        per_count_pre1900 = (count_pre1900/count_with_EPC)*100)

table(Points$CONSTRUCTI)

Points_2012 <- Points %>%
  filter(CONSTRUCTI %in% c("xx2012", "x2012", "x2013", "x2014", 
                           "x2015", "x2016", "x2017", "x2018", 
                           "x2019", "x2020", "x2021", "x2022", 
                           "x2023"))

Final_lsoa_2012 <- Points_2012 %>%
  st_join(lsoa) %>%
  group_by(LSOA21CD) %>%
  dplyr::summarize(count_post2012 = n())

sum(Final_lsoa_2012$count_pre2012)
Final_lsoa_2012[is.na(Final_lsoa_2012)] <- 0

Final_lsoa_2012$count_post2012 <- as.numeric(Final_lsoa_2012$count_post2012)
Final_lsoa_2012$count_with_EPC <- as.numeric(Final_lsoa_2012$count_with_EPC)

Final_lsoa_2012_scale <- Final_lsoa_2012 %>%
  as_tibble() %>%
  mutate(LSOA21CD = LSOA21CD,
         z_count_post2012 = scale((count_post2012/count_with_EPC)*100),
        per_count_post2012 = (count_post2012/count_with_EPC)*100)

## Reclaculcate floor area           
Points$TOTAL_FLOO <- as.numeric(Points$TOTAL_FLOO)

Points_Floor <- Points %>%
  filter(TOTAL_FLOO<50) # Filter less than 50m2
         
Final_lsoa_floor <- Points_Floor %>%
  st_join(lsoa) %>%
  group_by(LSOA21CD) %>%
  dplyr::summarize(count_floor50 = n())

Final_lsoa_floor[is.na(Final_lsoa_floor)] <- 0

Final_lsoa_floor$count_floor50 <- as.numeric(Final_lsoa_floor$count_floor50)
Final_lsoa_floor$count_with_EPC <- as.numeric(Final_lsoa_floor$count_with_EPC)

Final_lsoa_floor_scale <- Final_lsoa_floor %>%
  as_tibble() %>%
  mutate(LSOA21CD = LSOA21CD,
         z_count_floor50 = scale((count_floor50/count_with_EPC)*100),
        per_count_floor50 = (count_floor50/count_with_EPC)*100)

sum(Final_lsoa_floor$count_floor50)

## Recalculate other variables      
table(Points$MAIN_FUEL)
sum(Final_lsoa_other$count_terrace)

Final_lsoa_other <- Points %>%
  st_join(lsoa) %>%
  group_by(LSOA21CD) %>%
  dplyr::summarize(count_with_EPC = n(),
                   count_terrace_end = sum(BUILT_FORM == "End-Terrace"),
                  count_terrace_enclosedend = sum(BUILT_FORM == "End-Terrace Enclosed"),
                  count_terrace_mid = sum(BUILT_FORM == "Mid-Terrace"),
                  count_terrace_enclosedmid = sum(BUILT_FORM == "Enclosed Mid-Terrace"),
                  count_house = sum(PROPERTY_T == "House"),
                  count_bungalow = sum(PROPERTY_T == "Bungalow"),
                  count_flat = sum(PROPERTY_T == "Flat"),
                  count_maisonette = sum(PROPERTY_T == "Maisonette"),
                  count_parkhome = sum(PROPERTY_T == "Park home"),
                  count_mainsgas = sum(MAINS_GAS_ == "N"),
                  count_roofaverage = sum(ROOF_ENERG == "Average"),
                  count_roofspoor = sum(ROOF_ENERG == "Poor"),
                  count_roofverypoor = sum(ROOF_ENERG == "Very Poor"),
                  count_community_elec = sum(MAIN_FUEL == "electricity (community)"),
                  count_community_waste = sum(MAIN_FUEL == "waste combustion (community)"),
                  count_community_oil = sum(MAIN_FUEL == "oil (community)"),
                  count_community_lpg = sum(MAIN_FUEL == "LPG (community)"),
                  count_community_heat = sum(MAIN_FUEL == "from heat network data (community)"),
                  count_community_biodiesel = sum(MAIN_FUEL == "heat from boilers using biodiesel from any biomass source (community)"),
                  count_community_biodiesel2 = sum(MAIN_FUEL == "heat from boilers that can use mineral oil or biodiesel (community)"),
                  count_community_coal = sum(MAIN_FUEL == "coal (community)"),
                  count_community_biomass1 = sum(MAIN_FUEL == "Community heating schemes: heat from boilers - biomass"),
                  count_community_biomass = sum(MAIN_FUEL == "biomass (community)"),
                  count_community_B30D = sum(MAIN_FUEL == "B30D (community)"),
                  count_community_biogas = sum(MAIN_FUEL == "biogas (community)"),
                  count_community_scheme = sum(MAIN_FUEL == "Community Scheme"))

Final_lsoa_other[is.na(Final_lsoa_other)] <- 0

Final_lsoa_other <- Final_lsoa_other %>% 
  mutate(count_community_all = count_community_mainsgas + count_community_elec + count_community_waste +
                               count_community_oil + count_community_lpg + count_community_heat +
                               count_community_biodiesel + count_community_biodiesel2 + count_community_coal +
                               count_community_biomass1 + count_community_biomass + count_community_B30D +
                               count_community_biogas + count_community_scheme,
        count_terrace = count_terrace_end + count_terrace_enclosedend + 
                        count_terrace_mid + count_terrace_enclosedmid,
        count_houseorbungalow = count_house + count_bungalow,
        count_flatormaisonette = count_flat + count_maisonette,
        count_roofbad_all = count_roofaverage + count_roofspoor + count_roofverypoor)

Final_lsoa_other_scale <- Final_lsoa_other %>%
  as_tibble() %>%
  mutate(LSOA21CD = LSOA21CD,
        z_count_community_all = scale((count_community_all/count_with_EPC)*100),
        per_count_community_all = (count_community_all/count_with_EPC)*100,
        z_count_terrace = scale((count_terrace/count_with_EPC)*100),
        per_count_terrace = (count_terrace/count_with_EPC)*100,
        z_count_houseorbungalow = scale((count_houseorbungalow/count_with_EPC)*100),
        per_count_houseorbungalow = (count_houseorbungalow/count_with_EPC)*100,
        z_count_flatormaisonette = scale((count_flatormaisonette/count_with_EPC)*100),
        per_count_flatormaisonette = (count_flatormaisonette/count_with_EPC)*100,
        z_count_roofbad_all = scale((count_roofbad_all/count_with_EPC)*100),
        per_count_roofbad_all = (count_roofbad_all/count_with_EPC)*100)

## Integrate with climate data
Final <- LSOA %>%
  st_join(Grid, join = st_nearest_feature)

Final[is.na(Final)] <- 0
colnames(Final)
