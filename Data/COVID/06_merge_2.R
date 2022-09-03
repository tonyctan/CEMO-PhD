###### ADMIN INFO ######
# Date: 12 August 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Merge parental after-tax income with main datasets

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

# Read in national test data
math1 <- data.table::fread("03_math1.csv")
read1 <- data.table::fread("03_read1.csv")
# Read in parental income
income_mo <- data.table::fread("04_income_mo.csv")
income_fa <- data.table::fread("04_income_fa.csv")
# Read in household income
hhincome_mo <- data.table::fread("04_hhincome_mo.csv")
hhincome_fa <- data.table::fread("04_hhincome_fa.csv")
# Read in parental education
edu_mo <- data.table::fread("05_edu_mo.csv")
edu_fa <- data.table::fread("05_edu_fa.csv")

# Merge parental income to national test data
math2 <- dplyr::left_join(math1, income_mo, by = c("idmo", "cohort"))
math2 <- dplyr::left_join(math2, income_fa, by = c("idfa", "cohort"))
# Merge household income
math2 <- dplyr::left_join(math2, hhincome_mo, by = c("idmo", "cohort"))
math2 <- dplyr::left_join(math2, hhincome_fa, by = c("idfa", "cohort"))
# Merge parental education
math2 <- dplyr::left_join(math2, edu_mo, by = c("idmo", "cohort"))
math2 <- dplyr::left_join(math2, edu_fa, by = c("idfa", "cohort"))

# Merge parental income to national test data
read2 <- dplyr::left_join(read1, income_mo, by = c("idmo", "cohort"))
read2 <- dplyr::left_join(read2, income_fa, by = c("idfa", "cohort"))
# Merge household income
read2 <- dplyr::left_join(read2, hhincome_mo, by = c("idmo", "cohort"))
read2 <- dplyr::left_join(read2, hhincome_fa, by = c("idfa", "cohort"))
# Merge parental education
read2 <- dplyr::left_join(read2, edu_mo, by = c("idmo", "cohort"))
read2 <- dplyr::left_join(read2, edu_fa, by = c("idfa", "cohort"))

# Save merged data
data.table::fwrite(math2, "06_math2.csv")
data.table::fwrite(read2, "06_read2.csv")

  #                            #  
 ###                          ### 
#####       End script       #####
