###### ADMIN INFO ######
# Date: 12 August 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract kinship data from SLEKT register

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

# Read in kinship data. Show header names if interactive.
if (!interactive()) {
    print("Start data loading...")
}
kinship <- data.table::fread("W21_4952_SLEKT.csv")
if (interactive()) {
    names(kinship)
} else {
    print("Data loading complete.")
}

# Only retain variables we need
#   Column  Variable
#   1       Person ID
#   2       Sex
#   49      Mother's personal ID
#   50      Father's personal ID
#   159     Birth year and month
kinship <- kinship[, c(1, 2, 49, 50, 159)]
# Inspect kinship data
head(kinship)

# Rename columns
names(kinship) <- c(
    "idper",
    "sex",
    "idmo",
    "idfa",
    "birth"
)

# Export kinship data to M Drive
data.table::fwrite(kinship, "N:/no-backup/COVID/02_kinship.csv")

  #                            #  
 ###                          ### 
#####       End script       #####
