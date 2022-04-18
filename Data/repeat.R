###### ADMIN INFO ######
# Date: 16 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Repeat file names enough times to match the size of variable descriptive statistics

###### DATA PROTECTION ######
# Nature: An R script lenthening dim_list.csv
# Security level (input-script-output): yellow-yellow-yellow
# Computer environment (store-view-edit-execute): any-any-any-any

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Set working directory depending on the operating system
Orcs::setwdOS(lin = "~/uio/", win = "M:/", ext = "pc/Dokumenter/PhD/Data/")
dim_list <- read.csv("dim_list.csv", header = F, sep = " ")

# Obtain a "standard file name" list from dim_list.csv
# Windows and Linux differ in how they sort file names.
# Do NOT rely on operating systems to sort files but follow dim_list.csv's order
file_names <- dim_list[,2]

# Calculate total number of CSV files
total_files <- length(file_names) # Should be 183

# Invent a "repeat row" function
rep.row <- function(r, n) {
    plyr::colwise(function(x) rep(x, n))(r)
}

# Repeat each row in dim_list.csv enough times to match descriptive statistics
setwd("./Repeat/") # Save subsequent files in "Library" folder
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