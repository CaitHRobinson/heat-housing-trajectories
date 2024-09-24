## Install packages and libraries
library(tidyr)
library(tidyverse)
library(cli)
library(sf)
library(tmap)
library(dplyr)

## Read climate projection data
summer_1981 <- read.csv("1981.csv", check.names = FALSE)
summer_1981_gather <- gather(summer_1981, key="Eastings", value="1981", c(2:154))

summer_1982 <- read.csv("1982.csv", check.names = FALSE)
summer_1982_gather <- gather(summer_1982, key="Eastings", value="1982", c(2:154))

summer_1983 <- read.csv("1983.csv", check.names = FALSE)
summer_1983_gather <- gather(summer_1983, key="Eastings", value="1983", c(2:154))

summer_1984 <- read.csv("1984.csv", check.names = FALSE)
summer_1984_gather <- gather(summer_1984, key="Eastings", value="1984", c(2:154))

summer_1985 <- read.csv("1985.csv", check.names = FALSE)
summer_1985_gather <- gather(summer_1985, key="Eastings", value="1985", c(2:154))

summer_1986 <- read.csv("1986.csv", check.names = FALSE)
summer_1986_gather <- gather(summer_1986, key="Eastings", value="1986", c(2:154))

summer_1987 <- read.csv("1987.csv", check.names = FALSE)
summer_1987_gather <- gather(summer_1987, key="Eastings", value="1987", c(2:154))

summer_1988 <- read.csv("1988.csv", check.names = FALSE)
summer_1988_gather <- gather(summer_1988, key="Eastings", value="1988", c(2:154))

summer_1989 <- read.csv("1989.csv", check.names = FALSE)
summer_1989_gather <- gather(summer_1989, key="Eastings", value="1989", c(2:154))

summer_1990 <- read.csv("1990.csv", check.names = FALSE)
summer_1990_gather <- gather(summer_1990, key="Eastings", value="1990", c(2:154))

summer_1991 <- read.csv("1991.csv", check.names = FALSE)
summer_1991_gather <- gather(summer_1991, key="Eastings", value="1991", c(2:154))

summer_1992 <- read.csv("1992.csv", check.names = FALSE)
summer_1992_gather <- gather(summer_1992, key="Eastings", value="1992", c(2:154))

summer_1993 <- read.csv("1993.csv", check.names = FALSE)
summer_1993_gather <- gather(summer_1993, key="Eastings", value="1993", c(2:154))

summer_1994 <- read.csv("1994.csv", check.names = FALSE)
summer_1994_gather <- gather(summer_1994, key="Eastings", value="1994", c(2:154))

summer_1995 <- read.csv("1995.csv", check.names = FALSE)
summer_1995_gather <- gather(summer_1995, key="Eastings", value="1995", c(2:154))

summer_1996 <- read.csv("1996.csv", check.names = FALSE)
summer_1996_gather <- gather(summer_1996, key="Eastings", value="1996", c(2:154))

summer_1997 <- read.csv("1997.csv", check.names = FALSE)
summer_1997_gather <- gather(summer_1997, key="Eastings", value="1997", c(2:154))

summer_1998 <- read.csv("1998.csv", check.names = FALSE)
summer_1998_gather <- gather(summer_1998, key="Eastings", value="1998", c(2:154))

summer_1999 <- read.csv("1999.csv", check.names = FALSE)
summer_1999_gather <- gather(summer_1999, key="Eastings", value="1999", c(2:154))

summer_2000 <- read.csv("2000.csv", check.names = FALSE)
summer_2000_gather <- gather(summer_2000, key="Eastings", value="2000", c(2:154))

summer_2021 <- read.csv("2021.csv", check.names = FALSE)
summer_2021_gather <- gather(summer_2021, key="Eastings", value="2021", c(2:154))

summer_2022 <- read.csv("2022.csv", check.names = FALSE)
summer_2022_gather <- gather(summer_2022, key="Eastings", value="2022", c(2:154))

summer_2023 <- read.csv("2023.csv", check.names = FALSE)
summer_2023_gather <- gather(summer_2023, key="Eastings", value="2023", c(2:154))

summer_2024 <- read.csv("2024.csv", check.names = FALSE)
summer_2024_gather <- gather(summer_2024, key="Eastings", value="2024", c(2:154))

summer_2025 <- read.csv("2025.csv", check.names = FALSE)
summer_2025_gather <- gather(summer_2025, key="Eastings", value="2025", c(2:154))

summer_2026 <- read.csv("2026.csv", check.names = FALSE)
summer_2026_gather <- gather(summer_2026, key="Eastings", value="2026", c(2:154))

summer_2027 <- read.csv("2027.csv", check.names = FALSE)
summer_2027_gather <- gather(summer_2027, key="Eastings", value="2027", c(2:154))

summer_2028 <- read.csv("2028.csv", check.names = FALSE)
summer_2028_gather <- gather(summer_2028, key="Eastings", value="2028", c(2:154))

summer_2029 <- read.csv("2029.csv", check.names = FALSE)
summer_2029_gather <- gather(summer_2029, key="Eastings", value="2029", c(2:154))

summer_2030 <- read.csv("2030.csv", check.names = FALSE)
summer_2030_gather <- gather(summer_2030, key="Eastings", value="2030", c(2:154))

summer_2031 <- read.csv("2031.csv", check.names = FALSE)
summer_2031_gather <- gather(summer_2031, key="Eastings", value="2031", c(2:154))

summer_2032 <- read.csv("2032.csv", check.names = FALSE)
summer_2032_gather <- gather(summer_2032, key="Eastings", value="2032", c(2:154))

summer_2033 <- read.csv("2033.csv", check.names = FALSE)
summer_2033_gather <- gather(summer_2033, key="Eastings", value="2033", c(2:154))

summer_2034 <- read.csv("2034.csv", check.names = FALSE)
summer_2034_gather <- gather(summer_2034, key="Eastings", value="2034", c(2:154))

summer_2035 <- read.csv("2035.csv", check.names = FALSE)
summer_2035_gather <- gather(summer_2035, key="Eastings", value="2035", c(2:154))

summer_2036 <- read.csv("2036.csv", check.names = FALSE)
summer_2036_gather <- gather(summer_2036, key="Eastings", value="2036", c(2:154))

summer_2037 <- read.csv("2037.csv", check.names = FALSE)
summer_2037_gather <- gather(summer_2037, key="Eastings", value="2037", c(2:154))

summer_2038 <- read.csv("2038.csv", check.names = FALSE)
summer_2038_gather <- gather(summer_2038, key="Eastings", value="2038", c(2:154))

summer_2039 <- read.csv("2039.csv", check.names = FALSE)
summer_2039_gather <- gather(summer_2039, key="Eastings", value="2039", c(2:154))

summer_2040 <- read.csv("2040.csv", check.names = FALSE)
summer_2040_gather <- gather(summer_2040, key="Eastings", value="2040", c(2:154))

summer_2061 <- read.csv("2061.csv", check.names = FALSE)
summer_2061_gather <- gather(summer_2061, key="Eastings", value="2061", c(2:154))

summer_2062 <- read.csv("2062.csv", check.names = FALSE)
summer_2062_gather <- gather(summer_2062, key="Eastings", value="2062", c(2:154))

summer_2063 <- read.csv("2063.csv", check.names = FALSE)
summer_2063_gather <- gather(summer_2063, key="Eastings", value="2063", c(2:154))

summer_2064 <- read.csv("2064.csv", check.names = FALSE)
summer_2064_gather <- gather(summer_2064, key="Eastings", value="2064", c(2:154))

summer_2065 <- read.csv("2065.csv", check.names = FALSE)
summer_2065_gather <- gather(summer_2065, key="Eastings", value="2065", c(2:154))

summer_2066 <- read.csv("2066.csv", check.names = FALSE)
summer_2066_gather <- gather(summer_2066, key="Eastings", value="2066", c(2:154))

summer_2067 <- read.csv("2067.csv", check.names = FALSE)
summer_2067_gather <- gather(summer_2067, key="Eastings", value="2067", c(2:154))

summer_2068 <- read.csv("2068.csv", check.names = FALSE)
summer_2068_gather <- gather(summer_2068, key="Eastings", value="2068", c(2:154))

summer_2069 <- read.csv("2069.csv", check.names = FALSE)
summer_2069_gather <- gather(summer_2069, key="Eastings", value="2069", c(2:154))

summer_2070 <- read.csv("2070.csv", check.names = FALSE)
summer_2070_gather <- gather(summer_2070, key="Eastings", value="2070", c(2:154))

summer_2071 <- read.csv("2071.csv", check.names = FALSE)
summer_2071_gather <- gather(summer_2071, key="Eastings", value="2071", c(2:154))

summer_2072 <- read.csv("2072.csv", check.names = FALSE)
summer_2072_gather <- gather(summer_2072, key="Eastings", value="2072", c(2:154))

summer_2073 <- read.csv("2073.csv", check.names = FALSE)
summer_2073_gather <- gather(summer_2073, key="Eastings", value="2073", c(2:154))

summer_2074 <- read.csv("2074.csv", check.names = FALSE)
summer_2074_gather <- gather(summer_2074, key="Eastings", value="2074", c(2:154))

summer_2075 <- read.csv("2075.csv", check.names = FALSE)
summer_2075_gather <- gather(summer_2075, key="Eastings", value="2075", c(2:154))

summer_2076 <- read.csv("2076.csv", check.names = FALSE)
summer_2076_gather <- gather(summer_2076, key="Eastings", value="2076", c(2:154))

summer_2077 <- read.csv("2077.csv", check.names = FALSE)
summer_2077_gather <- gather(summer_2077, key="Eastings", value="2077", c(2:154))

summer_2078 <- read.csv("2078.csv", check.names = FALSE)
summer_2078_gather <- gather(summer_2078, key="Eastings", value="2078", c(2:154))

summer_2079 <- read.csv("2079.csv", check.names = FALSE)
summer_2079_gather <- gather(summer_2079, key="Eastings", value="2079", c(2:154))

summer_2080 <- read.csv("2080.csv", check.names = FALSE)
summer_2080_gather <- gather(summer_2080, key="Eastings", value="2080", c(2:154))

## Join into single dataset
Allyears <- left_join(summer_1981_gather, summer_1982_gather, 
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1983_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1984_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1985_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1986_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1987_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1988_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1989_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1990_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1991_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1992_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1993_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1994_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1995_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1996_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1997_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1998_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_1999_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2000_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2021_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2022_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2023_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2024_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2025_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2026_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2027_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2028_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2029_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2030_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2031_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2032_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2033_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2034_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2035_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2036_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2037_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2038_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2039_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2040_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2061_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2062_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2063_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2064_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2065_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2066_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2067_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2068_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2069_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2070_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2071_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2072_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2073_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2074_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2075_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2076_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2077_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2078_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2079_gather,
                          by = c("Northings", "Eastings")) %>%
                  left_join(summer_2080_gather,
                          by = c("Northings", "Eastings")) 

## Plot data spatially
### Map points using Eastings and Northings
Allyears_sf <- st_as_sf(Allyears, coords = c("Eastings", "Northings"), crs = 27700)

tm_shape(Allyears_sf) + 
  tm_dots("2080") 

## Clip to coastline of England and Wales
### Transform coordinate system if you need to
st_transform(Allyears_sf, crs = 4277)

country <- read_sf("EnglandandWales_Region_2020_BGC.shp")

tm_shape(country)+
  tm_polygons()

Allyears_EngandWales <- st_intersection(Allyears_sf, country, check.names = FALSE)
st_write(Allyears_EngandWales, "Allyears_EngandWales.shp")
