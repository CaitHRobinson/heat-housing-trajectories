# Temperature data from UK Climate Projections 2018

💬 **Language:** R

📌 **Section summary:** Climate change researchers have made sustained efforts to quantify and project futures at increasingly high resolution, fine grain scales. We analyse Met Office UKCP18 climate projections.

*Temperature data:* We take the highest daily maximum air temperature at 1.5m above the ground in the summer months - June, July, and August. This provides us with information about extreme temperature. Maximum summer temperatures are therefore considered illustrative of heatwave risk – an extended period of hot weather. We use data at a 2.2km scale (mapped on a 5km2 grid) for three 20-year periods: 1981-2000, 2021-2040, and 2061-2080.

*Underlying climate models:* UKCP18 projections are based on Convection Permitting Models (CPM) that provide climate information at city scale. we use RCP 8.5, iteration 01 (Met Office, 2019), a high emissions scenario commonly adopted by organisations tasked with planning for future climatic changes. RCP8.5 reflects a relatively fossil-fuel intensive future that excludes climate change mitigation policies, resulting in almost 4.3°C of warming globally by 2100. we use RCP 8.5, iteration 01, a high emissions scenario commonly adopted by organisations tasked with planning for future climatic changes. RCP8.5 reflects a relatively fossil-fuel intensive future that excludes climate change mitigation policies, resulting in almost 4.3°C of warming globally by 2100. Researchers have [expressed concern](https://www.nature.com/articles/d41586-020-00177-3) that this has been interpreted as a ‘business as usual’ outcome by many, ignoring the multitude of plausible pathways in between.

*Clip to coast:* We clip the climate projection data to the boundary of England and Wales.

📊 **Data download:** Due to the size of the dataset, the underlying temperature data can be [downloaded from Met Office](http://data.ceda.ac.uk/badc/ukcp18/data/land-cpm/uk/5km/rcp85/01/tasmax/seas/v20210615/). 
