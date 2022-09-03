###### ADMIN INFO ######
# Date: 12 August 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract parents' and household's income

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
if (interactive()) {
    getwd()
} else {
    cat(paste0(
        "Working directory is now set to ", getwd(), "\n"
    ))
}

        #################################
        ### Parents' after-tax income ###
        #################################

# Read in income data. Show header names if interactive.
if (!interactive()) {
    print("Start data loading...")
}
income <- data.table::fread("W21_4952_INNT.csv")
if (interactive()) {
    names(income)
} else {
    print("Data loading complete.")
}

# Only keep after-tax income data between 2015 and 2020
#   Column  Variable
#   1       Person ID (lopenr_person)
#   3       Year (aargang)
#   34      After-tax income (ies = inntekt etter skatt)
income_temp <- income[
    income$aargang >= 2015 & income$aargang <= 2020,
    c(1, 3, 34)
]

# Rename columns to mother version
names(income_temp) <- c(
    "idmo",
    "cohort",
    "ati_mo"
)
# Save income mother version
data.table::fwrite(income_temp, "N:/no-backup/COVID/04_income_mo.csv")

# Rename columns to father version
names(income_temp) <- c(
    "idfa",
    "cohort",
    "ati_fa"
)
# Save income mother version
data.table::fwrite(income_temp, "N:/no-backup/COVID/04_income_fa.csv")

        #########################################################
        ### Household's after-tax income per consumption unit ###
        #########################################################

    # Read in household income data
if (!interactive()) {
        print("Start data loading...")
}
hhincome <- data.table::fread("W21_4952_HUSHINNT.csv")
if (interactive()) {
    names(hhincome)
} else {
    print("Data loading complete.")
}

# Only keep household income data between 2015 and 2020. Keep all columns.
#   Column  Variable
#   1       Person ID (lopenr_person)
#   2       Household ID (lopenr_husholdning)
#   3       Year (aargang)
#   4       Household after-tax income (hush_ies)
#   5       Household after-tax income per consumption unit (hush_ies_eu)
hhincome_temp <- hhincome[
    hhincome$aargang >= 2015 & hhincome$aargang <= 2020,
]

# Rename columns to mother version
names(hhincome_temp) <- c(
    "idmo",
    "idhh_mo",
    "cohort",
    "ati_hh_mo",
    "atipcu_mo"
)
# Save household income mother version
data.table::fwrite(hhincome_temp, "N:/no-backup/COVID/04_hhincome_mo.csv")

# Rename columns to father version
names(hhincome_temp) <- c(
    "idfa",
    "idhh_fa",
    "cohort",
    "ati_hh_fa",
    "atipcu_fa"
)
# Save household income mother version
data.table::fwrite(hhincome_temp, "N:/no-backup/COVID/04_hhincome_fa.csv")

  #                            #  
 ###                          ### 
#####       End script       #####
