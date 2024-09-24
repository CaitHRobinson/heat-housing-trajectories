# Sequence and cluster analysis to create heat trajectories

💬 Language: R

📌 **Section summary:** 60 years’ worth of climate projection data at 5km2 resolution is tricky to interpret. This section details [code to apply sequence and cluster analysis](https://github.com/CaitHRobinson/heat-housing-trajectories/edit/main/trajectories/trajectories-code.r), a technique for the mining and visualising sequences of categorical data, to identify common trajectories in the data. 

*Sequence analysis:* Our [sequence analysis](http://traminer.unige.ch/) measures the differences in maximum summer temperature over time across grid squares. The maximum summer temperature projection data analysed is [available here](https://github.com/CaitHRobinson/heat-housing-trajectories/blob/main/heat/AllYears_EngandWales.csv). We choose an Optimal Matching sequence algorithm that conceptualises similarity as the minimum number of operations that are required to turn one sequence into another. To generate the dissimilarity matrix, we set the substitution cost as based on the transition rates observed between all pairs of states in the data, with a cost of one for deleting or inserting an element into the sequence. 

*Cluster analysis:* Sequences are clustered to identify common trajectories. We opt for a ward clustering approach and test cluster solutions from 1-20. Using common diagnostics, a four-cluster solution is identified as most appropriate, minimising within- and between-cluster variation. 

*Naming clusters:* We name the trajectories: ‘Cooler extremes’, ‘Moderately cooler extremes’, ‘Moderately warmer extremes’, and ‘Warmer extremes’. Names are based on the temperatures and change over time and are relative to one another.

**Data download:** 

<img src="https://github.com/user-attachments/assets/0fdfc99b-e1ef-4ee5-a617-249dfe1c6903" width=80% height=80%>

