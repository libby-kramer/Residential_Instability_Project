#### Libby Kramer
### Data Simulation
### November 11th, 2025
### Residential Instability and Well-being Project


# workspace setup
install.packages("groundhog")
install.packages("faux")
install.packages("summarytools")
install.packages("missMethods")
install.packages("dplyr")
sessionInfo()

library(groundhog)
groundhog.library(dplyr,"2025-04-11")
groundhog.library(faux, "2025-04-11")
groundhog.library(summarytools, "2025-04-11")
groundhog.library(missMethods, "2025-04-11")
            
sessionInfo()
# R version 4.5.0
# groundhog_3.2.3
# summarytools_1.1.4
# faux_1.2.3
# missMethods_0.4.0
# dplyr_1.1.4

# setting seed!
set.seed(0628)

# rnorm raw

