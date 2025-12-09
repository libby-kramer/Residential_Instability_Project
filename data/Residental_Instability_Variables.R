### Residential Instability Variable Data Setup
### Libby Kramer
### 12-8-2025

# This file uses code from the SIPP website in order to load in on the variables that are required for this analysis. 
# This way you can use the data without downloading the whole file onto R studio


# set your working directory, if necessary
# setwd()

install.packages("data.table")

library(data.table)
library(dplyr)
library(bit64)

#Load the "data.table", "dplyr", and "bit64" libraries
require("data.table")
require("bit64")
require("dplyr")

#Read in the Primary Data file. Choose only the variables you want to read in in order to save on memory.
#This code assumes that your working directory is the same directory as the data.
ds <- c("pu2024-2.csv")

pu <- fread(ds, sep = "|", select = c("ECLUB", "EEXPSCH", "EREADCWB", "EREPGRD", "ESPORT", "EEHC_MVMO", "EEHC_PVTEN", "EEHC_WHY", "ERH_BMONTH", "ERH_EMONTH", "TEHC_MVYR", "EDOB_BMONTH", "TAGE", "TDOB_BYEAR", "ERACE", "TRACE", "ESEX"))

names(pu) <- toupper(names(pu))

head(pu, 20)

#check some means against the validation xls file to help ensure that the data
#	were read in correctly. Note that the validation xls files do not include all variables.
mean(pu[["TPTOTINC"]], na.rm = TRUE)

#Read in the replicate-weight data. This dataset is small enough that most machines
#	can read the whole file into memory
dw <- c("rw2024.csv")
rw <- fread(dw, sep = "|")

#Make sure all the column names are upper-case
names(rw) <- toupper(names(rw))

#Preview the data
head(rw, 20)


#check some means against the validation xls file to help ensure that the data
#	were read in correctly. Note that the validation xls files do not include all variables.
mean(rw[["REPWGT100"]], na.rm = TRUE)

#Merge primary data and replicate weights on SSUID, PNUM, MONTHCODE, SPANEL, and SWAVE
data <- inner_join(pu, rw, by = c("SSUID","PNUM","MONTHCODE", "SPANEL", "SWAVE"))


#preview the merged data
head(data, 20)