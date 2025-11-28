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
groundhog.library(dplyr,"2025-04-12")
groundhog.library(faux, "2025-04-12")
groundhog.library(summarytools, "2025-04-12")
groundhog.library(missMethods, "2025-04-12")
            
sessionInfo()
# R version 4.5.0
# groundhog_3.2.3
# summarytools_1.1.4
# faux_1.2.3
# missMethods_0.4.0
# dplyr_1.1.4


# using sample() to simulate items 

# read in data file
dict <- read.csv("Residential_Stability_Wellbeing_data_dictionary.csv")
dict

# create empty data frame and populate with id variable based on your N (N = 6691 here)

dat_sim <- data.frame(id = c(1:6691))
head(dat_sim)

# now simulate individual items based on properties of interest

dat_sim$cwb_1_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.40, .60))
table(dat_sim$cwb_1)

dat_sim$cwb_2_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.90, .10))
table(dat_sim$cwb_2_sim)

dat_sim$cwb_3_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.95, .05))
table(dat_sim$cwb_3_sim)

dat_sim$cwb_4_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.50, .50))
table(dat_sim$cwb_4_sim)

dat_sim$res_1_sim <- sample(1:3, size = 6691, replace = TRUE, prob = c(.30, .50, .20))
table(dat_sim$res_1)

dat_sim$res_2_sim <- sample(1:16, size = 6691, replace = TRUE, prob = c(.0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625, .0625))
table(dat_sim$res_2)

dem_1 <- (dat$TAGE)
dem_2 <- (dat$ERACE)
dem_3 <- (dat$ESEX)
table(dem_2)

dat_sim$dem_1_sim <- sample(0:90, size = 6691, replace = TRUE)
table(dat_sim$dem_1_sim)

dat_sim$dem_2_sim <- sample(1:4, size = 6691, replace = TRUE, prob = c(.75, .10, .10, .05))
table(dat_sim$dem_2_sim)

dat_sim$dem_3_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.05, .95))
table(dem_3)
table(dat_sim$dem_3_sim)

# include missing data in results
# just using 40% for missing values because the actual amount was so large
dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "cwb_1_sim")
dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "cwb_2_sim")
dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "cwb_3_sim")
dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "cwb_4_sim")

dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "res_1_sim")
dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "res_2_sim")

dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "dem_1_sim")
dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "dem_2_sim")
dat_sim <- missMethods::delete_MCAR(dat_sim, .40, "dem_3_sim")


dat_sim %>% dplyr::select(cwb_1_sim) %>% summarytools::freq()
dat_sim

write.csv(dat_sim, "residential_stability_simulated_data_2025_11-17.csv", row.names = FALSE)

