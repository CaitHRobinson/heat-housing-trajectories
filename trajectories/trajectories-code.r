## Install libraries
library(tidyr)
library(tidyverse)
library(cli)
library(sf)
library(tmap)
library(TraMineR)
library(cluster)
library(dplyr)
library(gridExtra)
library(WeightedCluster)
library(factoextra)

## Reclassify the data
Allyears_EngandWales <- st_read("Allyears_EngandWales.shp")
Allyears_EngandWales_df <- as.data.frame(Allyears_EngandWales)
mean(Allyears_EngandWales_df[ , c(1:20)])

## Map data
tm_shape(Allyears_EngandWales)+
  tm_dots("X2080", palette = "YlOrRd",
          size = 0.05)

## Make spatial data in data frame
Climate_df_raw <- as.data.frame(Allyears_EngandWales)

## Clean data
Climate_df_raw[1:60] <- round(Climate_df_raw[1:60], digits = 0) # Round up data

Climate_df_new <- Climate_df_raw %>% mutate_at(vars(one_of('X1981', 'X1982', 'X1983', 'X1984', 'X1985',
                                                       'X1986', 'X1987', 'X1988', 'X1989', 'X1990',
                                                       'X1991', 'X1992', 'X1993', 'X1994', 'X1995',
                                                       'X1996', 'X1997', 'X1998', 'X1999', 'X2000',
                                                       'X2021', 'X2022', 'X2023', 'X2024', 'X2025',
                                                       'X2026', 'X2027', 'X2028', 'X2029', 'X2030', 
                                                       'X2031', 'X2032', 'X2033', 'X2034', "X2035",
                                                       "X2036", "X2037", "X2038", "X2039", "X2040",     
                                                        "X2061", "X2062", "X2063", "X2064", "X2065", 
                                                        "X2066", "X2067", "X2068", "X2069", "X2070",
                                                       "X2071", "X2072", "X2073", "X2074", "X2075",
                                                       "X2076", "X2077", "X2078", "X2079", "X2080")),
                                           funs(case_when(. >= 11 & . <= 12 ~ '11-12',
                                                          . >= 13 & . <= 14 ~ '13-14',
                                                          . >= 15 & . <= 16 ~ '15-16',
                                                          . >= 17 & . <= 18 ~ '17-18',
                                                          . >= 19 & . <= 20 ~ '19-20',
                                                          . >= 21 & . <= 22 ~ '21-22',
                                                          . >= 23 & . <= 24 ~ '23-24',
                                                          . >= 25 & . <= 26 ~ '25-26',
                                                          . >= 27 & . <= 28 ~ '27-28',
                                                          . >= 29 & . <= 30 ~ '29-30',
                                                          . >= 31 & . <= 32 ~ '31-32',
                                                          . >= 33 & . <= 34 ~ '33-34'))) # Reclassify data

data_alpha <- c("11-12", "13-14", "15-16", "17-18", "19-20", 
                "21-22", "23-24", "25-26", "27-28", "29-30", 
                "31-32", "33-34") # Create a list of states

## Sequence analysis 
# Create a state sequence object
climate_seq <- seqdef(Climate_df_new, 1:60, ststep=NULL, alphabet=data_alpha) # Alphabet is the list of states
cpal(climate_seq) <- c("#FEFBE9", "#F5F3C1", "#DDECBF", "#C2E3D2", 
                      "#A8D8DC", "#8DCBE4", "#7BBCE7", "#88A5DD", 
                      "#9B8AC4", "#9A709E", "#805770", "#46353A")

# Set the colour palette according to the sequence
# The sequence data can then be plotted, both from the start and from the end.
seqIplot(climate_seq, sortv = "from.start")
seqIplot(climate_seq, sortv = "from.end")

cost <- seqsubm(climate_seq, method = "TRATE") # calculate transition rate
OM_first <- seqdist(climate_seq, method = "OM", sm = cost) # Optimal matching

## Cluster analysis
clusterward <- agnes(OM_first, diss = TRUE, method = "ward")
plot(clusterward)

cl4 <- cutree(clusterward, k = 4)
# Rename labels with cluster names
cl7.lab <- factor(cl7, labels = paste("Cluster", 1:4))

## Visualise outputs
seqdplot(climate_seq, group = cl4.lab, border = NA, col = 2) # State distribution plots
seqHtplot(climate_seq, group = cl4.lab, border = NA, cols = 2) # Transversal entropy plots
seqmtplot(climate_seq, group = cl4.lab, border = NA, cols = 2) # Mean times plots
seqIplot(climate_seq, group = cl4.lab, border = NA, cols = 2) # Whole set index plots
seqiplot(climate_seq, group = cl4.lab, border = NA, cols = 2) # Individual sequences
seqpcplot(climate_seq,group = cl4.lab, border = NA, rows = 2, cols = 2) # Parallel coordinate plots
seqmsplot(climate_seq, group = cl4.lab, border = NA, cols = 2) # Modal state sequences

## Generate maps of clusters
Climate_df_sf <- st_as_sf(Climate_df_raw)
final <- st_join(Allyears_EngandWales, Climate_df_sf, by.x = "geometry", by.y = "geometry")

tm_shape(final)+
  tm_dots(size = 0.07,
          col = "Cluster_4", palette =c("1" ="#66CCEE", "2" = "#CCBB44", "3"= "#EE6677", "4" = "#AA3377"), title = "Trajectory clusters")+
  tm_scale_bar(text.size = 0.6)+
  tm_layout(frame = FALSE, legend.title.fontface = "bold")

# Violin plot of clusters
ggplot(final, aes(x= Cluster_4, y= X2080.x)) + 
  geom_violin(aes(fill=Cluster_4), color=NA)+
  labs(title="Climate projection trajectories",y="Temperature (Celius)", x="Clusters")+
  scale_fill_manual(values=c("1" ="#66CCEE", "2" = "#CCBB44", "3"= "#EE6677", "4" = "#AA3377"), # Manually change the colours of the clusters based on ColorBrewer palette
                    name="Cluster",
                    breaks=c("C1", "C2", "C3", "C4"),
                    labels=c("C1", "C2", "C3", "C4"))+
  theme_light()+
  theme(plot.title=element_text(face="bold"),
        axis.text.x=element_text(size = 12), axis.title.x=element_text(size = 12), axis.ticks.x=element_blank(),
        axis.text.y=element_text(size=12), axis.title.y=element_text(size=12),
        strip.text=element_text(size=12), 
        legend.text = element_text(size=12),legend.title=element_blank())+
  stat_summary(fun = median, geom = "point",
               position = position_dodge(0.9))
