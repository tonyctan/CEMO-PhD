###### ADMIN INFO ######
# Date: 16 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Stitch file names and variable descriptive statistics together

###### DATA PROTECTION ######
# Nature: An R script linking dim_list.csv with other descriptive statistics *.csv files
# Security level (input-script-output): yellow-yellow-yellow
# Computer environment (store-view-edit-execute): any-any-any-any

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Set working directory
library(Orcs) # Set working directory depending on the operating system
setwdOS(lin = "~/uio/", win = "M:/", ext = "pc/Dokumenter/PhD/Data/")

# Obtain a list of file names from "Desc_stat" folder
file_names <- list.files("./Desc_stat/", pattern = "*.csv", full.names = F)

# Calculate total number of CSV files
total_files <- length(file_names) # Should be 183

# Stitch corresponding files in "Desc_stat" and "Repeat" together
setwd("./Stitch/") # Save subsequent files in "Library" folder
for (i in 1:total_files) {
    # Read in a file from "Repeat"
    R <- read.csv(paste0("../Repeat/", file_names[i]), header = F)
    # Read in a file from "Desc_stat"
    D <- read.csv(paste0("../Desc_stat/", file_names[i]), header = F)
    # Stitch R and D together into S
    S <- cbind(R, D)
    write.table(
        S, file_names[i],
        quote = F, row.names = F, col.names = F
    )
    rm(R)
    rm(D)
    rm(S)
}

  #                            #  
 ###                          ### 
#####       End script       #####