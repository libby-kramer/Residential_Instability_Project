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

# setting seed!
set.seed(0628)

###############
# rnorm raw
# simulated cwb_scale data
rnorm(n = 10, mean = 1.83829, sd = 0.2523522)

outcome <- rnorm(n = 10, mean = 1.83829, sd = 0.2523522)
# does this still work if I am not using continuous data
dat_rnorm <- data.frame(outcome)
head(dat_rnorm)

mean(dat_rnorm$outcome)
sd(dat_rnorm$outcome)

# setting up a function
data_generate <- function(n, m, sd) {
  set.seed(0628)
  g <- rnorm(n = n, mean = m, sd = sd)
  data <- data.frame(
    return(data)
  )
}

# set parameters and create data
dat_rnorm_func <- data_generate(n = 10, m = 1.83829, sd = 0.2523522)
dat_rnorm_func

# GETTING AN ERROR HERE
mean(dat_rnorm_func$outcome)
sd(dat_rnorm_func$outcome)


# rnorm, but now two groups
data_generate <- function(n1, n2, m1, m2, sd1, sd2) {
  set.seed(0628)
  
  g1 <- rnorm(n = n1, mean = m1, sd = sd1)
  g2 <- rnorm(n = n2, mean = m2, sd = sd2)
  
  data <- data.frame(
    group = rep(c("1", "2"), times = c(n1, n2)),
    outcome = c(g1, g2)
  )
  return(data)
}

# set parameters and create data
dat_rnorm_func_two <- data_generate(n1 = 50, n2 = 50,
                                    m1 = 1.83829, m2 = 1.816171,
                                    sd1 = 0.2523522, sd2 = 0.6098213)
# checks
head(dat_rnorm_func_two)

### ERROR could not find function "%>%"
dat_rnorm_func_two %>% dplyr::group_by(group) %>% 
  dplyr::summarise(mean = mean(outcome, na.rm = TRUE), sd = sd(outcome, na.rm = TRUE))


#############################
# rnorm_multi() from the faux package
# set the parameters

n <- 100
m1 <- 1.83829
sd1 <- 0.2523522
m2 <- 1.816171
sd2 <- 0.6098213


# create the data file
dat_faux <- faux::rnorm_multi(n = n,
                              mu = c(m1, m2),
                              sd = c(sd1, sd2),
                              varnames = c("g1", "g2"))

# checks
head(dat_faux)
mean(dat_faux$g1)
mean(dat_faux$g2)
sd(dat_faux$g1)
sd(dat_faux$g2)

##############################
# using sample() to simulate items - most useful for preregistration
# get info on data specs from dictionary

dict <- read.csv("Residential_Stability_Wellbeing_data_dictionary.csv")
dict

# create empty data frame and populate with id variable based on your N (N = 100 here)

dat_sim <- data.frame(id = c(1:6691))
head(dat_sim)

# now simulate individual items based on properties of interest
# binary item, equal probability

dat_sim$cwb_1_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.40, .60))
table(dat_sim$cwb_1)

dat_sim$cwb_2_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.90, .10))
table(dat_sim$cwb_2_sim)

dat_sim$cwb_3_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.95, .05))
table(dat_sim$cwb_3_sim)

dat_sim$cwb_4_sim <- sample(1:2, size = 6691, replace = TRUE, prob = c(.50, .50))
table(dat_sim$cwb_4_sim)

### simulate raw data and recode it later

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
