Contextualising trajectories with housing data for neighbourhoods

*EPC data:* EPC data is available at the Unique Property Reference Number property scale from [Open Data Communities](https://epc.opendatacommunities.org/). It contains information about property energy performance, structural characteristics and typical energy costs. Certificates are issued when a property is bought, sold, or rented. Our dataset includes 15,763,320 domestic properties with an EPC between 1st September 2012 and 1st September 2022, retaining only recent certificates for each property. 

*Social and demographic data:* To complement the EPC, we include a range of variables from the 2021 Census at Lower Super Output Area (LSOA) scale. Some variables complement housing variables, providing additional information about tenure relations or over-occupancy. Others provide wider contextual information, including age-related variables illustrative of physiological vulnerability to heat, as well as material deprivation and ethnicity, shown to increase vulnerability to overheating.

*Data aggregation:* EPC property-scale data is aggregated to [Lower Super Output Area (LSOA) scale](https://www.ons.gov.uk/methodology/geography/ukgeographies/censusgeographies/census2021geographies), a neighbourhood unit more representative of population distribution. During aggregation, proportions of properties with different characteristics in each LSOA are computed. We then match an LSOA population weighted centroid  with the spatially corresponding, or nearest, climate grid square, to identify a [heat trajectory]() for every neighbourhood. 




