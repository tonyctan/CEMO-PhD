###### ADMIN INFO ######
# Date: 03 May 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: IRT analysis of subject difficulties

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
    setwd("M:/p1708-tctan/Documents")
} else {
    setwd("/tsd/p1708/home/p1708-tctan/Documents/")
}
if (interactive()) {getwd()} else {cat(paste0(
    "Working directory is now set to ", getwd(), "\n"
))}

# Read in ./Rolf/most_three_missing.csv
if (!interactive()) {print("Start data loading...")}
difficulty <- data.table::fread("./Rolf/most_three_missing.csv")
if (interactive()) {names(difficulty)} else {print("Data loading complete.")}
if (interactive()) {dim(difficulty)} # N = 59,462













  #                            #  
 ###                          ### 
#####       End script       #####
