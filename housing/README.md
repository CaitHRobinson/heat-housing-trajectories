# Contextualising trajectories with housing data for neighbourhoods

💬 **Language:** R 

📌**Section summary:** Heat trajectories are juxtaposed with housing data for ~15 million individual properties detailing type, quality, and characteristics, derived from Energy Performance Certificates, as well as other socio-demographic data. 

*EPC data:* EPC data is available at the Unique Property Reference Number property scale from [Open Data Communities](https://epc.opendatacommunities.org/). It contains information about property energy performance, structural characteristics and typical energy costs. Certificates are issued when a property is bought, sold, or rented. Our dataset includes 15,763,320 domestic properties with an EPC between 1st September 2012 and 1st September 2022, retaining only recent certificates for each property. EPC variables are recalculated for LSOA using percentages and z-scores.

*Data aggregation:* EPC property-scale data is aggregated to [Lower Super Output Area (LSOA) scale](https://www.ons.gov.uk/methodology/geography/ukgeographies/censusgeographies/census2021geographies), a neighbourhood unit more representative of population distribution. During aggregation, proportions of properties with different characteristics in each LSOA are computed. We then match an [LSOA population weighted centroid](https://geoportal.statistics.gov.uk/datasets/c8b3fc3c98a842708e201c8af1db15e3)  with the spatially corresponding, or nearest, climate grid square, to identify a [heat trajectory](https://github.com/CaitHRobinson/heat-housing-trajectories/tree/main/trajectories) for every neighbourhood.

*Social and demographic data:* To complement the EPC, we include a range of variables from the [2021 Census](https://www.ons.gov.uk/census) at Lower Super Output Area (LSOA) scale. Some variables complement housing variables, providing additional information about tenure relations or over-occupancy. Others provide wider contextual information, including age-related variables illustrative of physiological vulnerability to heat, as well as material deprivation and ethnicity, shown to increase vulnerability to overheating.

📊 **Data download:** Final EPC housing variables aggregated to LSOA scale are [available here](https://github.com/CaitHRobinson/heat-housing-trajectories/blob/main/housing/LSOA_EPC_Variables.csv) for comparison with heat trajectory data.

https://github.com/user-attachments/assets/3440032f-273c-4e31-8b42-d72082fb4a04



