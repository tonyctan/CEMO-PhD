###### ADMIN INFO ######
# Date: 12 August 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract parents' highest education

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

# Read in education data. Show header names if interactive.
if (!interactive()) {
    print("Start data loading...")
}
edu <- data.table::fread("W21_4952_BU_UTD.csv")
if (interactive()) {
    names(edu)
} else {
    print("Data loading complete.")
}

# Only keep education data between 2015 and 2020
#   Column  Variable
#   1       Person ID
#   127     BU Nivå 2015
#   128     BU Nivå 2016
#   129     BU Nivå 2017
#   130     BU Nivå 2018
#   131     BU Nivå 2019
#   132     BU Nivå 2020
edu_temp <- edu[, c(1, 127:132)]

# Rename columns
names(edu_temp) <- c("id", 2015, 2016, 2017, 2018, 2019, 2020)

# Turn wide to long
edu_temp <- data.table::melt(edu_temp,
    id.vars = "id", variable.name = "cohort", value.name = "edu"
)

# Sort data by ID
edu_temp <- edu_temp[order(id, cohort), ]

# Rename columns to mother version
names(edu_temp) <- c("idmo", "cohort", "edu_mo")
# Save education data mother version
data.table::fwrite(edu_temp, "N:/no-backup/COVID/05_edu_mo.csv")

# Rename columns to father version
names(edu_temp) <- c("idfa", "cohort", "edu_fa")
# Save education data mother version
data.table::fwrite(edu_temp, "N:/no-backup/COVID/05_edu_fa.csv")

  #                            #  
 ###                          ### 
#####       End script       #####
