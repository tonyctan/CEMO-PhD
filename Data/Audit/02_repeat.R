###### ADMIN INFO ######
# Date: 16 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Repeat file names enough times to match the size of variable descriptive statistics

###### DATA PROTECTION ######
# Nature: An R script lengthening dim_list.csv
# Security level (input-script-output): green-green-green
# Computer environment (store-view-edit-execute): any-any-any-any

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Read in dim_list.csv
# Set working directory depending on the operating system
Orcs::setwdOS(
  lin = "/tsd/p1708/home/",
  win = "M:/",
    ext = "p1708-tctan/Documents/Data_audit"
)
dim_list <- read.csv("01_dim_list.csv", header = F, sep = " ")

# Obtain a list of file names from "Desc_stat" folder
file_names <- list.files("./01_desc_stat/", pattern = "*.csv", full.names = F)

# Calculate total number of CSV files
total_files <- length(file_names) # Should be 183

# Invent a "repeat row" function
rep.row <- function(r, n) {
    plyr::colwise(function(x) rep(x, n))(r)
}

# Repeat each row in dim_list.csv enough times to match descriptive statistics
setwd("./02_repeat/") # Save subsequent files in "Library" folder
for (i in 1:total_files) {
    temp <- rep.row(dim_list[i, ], dim_list[i, 4])
    write.table(
      temp, file_names[i], quote = F, row.names = F, col.names = F
    )
    rm(temp)
}

  #                            #  
 ###                          ### 
#####       End script       #####