###### ADMIN INFO ######
# Date: 26 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Re-format teacher-assigned marks into student-by-subject shape

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to the location of all registry datasets,
# depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("N:/durable/data/registers")
} else {
    setwd("/tsd/p1708/data/durable/data/registers")
}
if (interactive()) {getwd()} else {cat(paste0(
    "Working directory is now set to ", getwd(), "\n"
))}

# Read in W21_4952_TAB_KAR_GRS.csv
if (!interactive()) {print("Start data loading...")}
gpa <- data.table::fread("W21_4952_TAB_KAR_GRS.csv")
if (interactive()) {names(gpa)} else {print("Data loading complete.")}

# Our data set stopped at June 2020
table(unlist(gpa$AVGDATO))

# Extract June 2020 record
test2020 <- gpa[which(gpa$AVGDATO == "202006"), ]

# See whether exam marks were available for June 2020 record. Answer: very few
table(unlist(test2020$SKR))
table(unlist(test2020$MUN))
