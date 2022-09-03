###### ADMIN INFO ######
# Date: 12 August 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Link students to their parents

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to the COVID folder depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("N:/no-backup/COVID/")
} else {
    setwd("/tsd/p1708/data/no-backup/COVID/")
}
if (interactive()) {
    getwd()
} else {
    cat(paste0(
        "Working directory is now set to ", getwd(), "\n"
    ))
}

# Read in both the national test dataset and kinship dataset
math0 <- data.table::fread("01_math0.csv")
read0 <- data.table::fread("01_read0.csv")
kinship <- data.table::fread("02_kinship.csv")

# Give a header to math and read datasets
names(math0) <- c(
    "cohort", "condition1",
    "idper",
    "idsc8", "idsc9",
    "scmu8", "scmu9",
    "types8", "types9",
    "partst8", "partst9",
    "np_math8", "np_math9"
)
names(read0) <- c(
    "cohort", "condition1",
    "idper",
    "idsc8", "idsc9",
    "scmu8", "scmu9",
    "types8", "types9",
    "partst8", "partst9",
    "np_read8", "np_read9"
)

# Merge kinship into math and read
math1 <- dplyr::left_join(math0, kinship, by = "idper")
read1 <- dplyr::left_join(read0, kinship, by = "idper")

# Save merged data to M Drive
data.table::fwrite(math1, "03_math1.csv")
data.table::fwrite(read1, "03_read1.csv")

  #                            #  
 ###                          ### 
#####       End script       #####
