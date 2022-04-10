###### ADMIN INFO ######
# Date: 04 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract variable names from registry datasets for auditing purpose

###### DATA PROTECTION ######
# Nature: An R script scraping Norwegian registry data leading to files containing no personal info
# Security level (input-script-output): black-yellow-yellow
# Computer environment (store-view-edit-execute): any-any-any-TSD

##### Begin script #####
 ###                ###
  #                  #

# Point working directory to the location of all registry datasets
setwd("N:/durable/data/registers/")

# Create an empty list that contains all CSV file names
file_names <- list.files(getwd(), pattern = "*.csv", full.names = F)

# Create a placeholder matrix to receive dimension info of each dataset
dim_list <- matrix(nrow = length(file_names), ncol = 2)

# Read in each data file
data.table::setDTthreads(16) # Use all 16 CPU cores

# Save variable names of each dataset into a separate file
for (i in 1:length(file_names)) {
    temp <- data.table::fread(file_names[i]) # Read in dataset one at a time

    dim_list[i, ] <- dim(temp) # Save dimension info to dim_list

    var_names <- attributes(temp)[1] # Extract variable names

    write.table(var_names, # Save variable names to M drive
        paste0("M:/p1708-tctan/Documents/Variable_names/", file_names[i]),
        quote = F # Do not put quotation marks around data
    )

    rm(temp) # Dump the temporary file to free up RAM
    rm(var_names) # Dump the temporary variable name list for next cycle
}

# Save dimension info of all datasets
write.table(cbind(file_names, dim_list),
    "M:/p1708-tctan/Documents/Variable_names/dim_list.csv",
    quote = F # Do not put quotation marks around data
)

  #                #
 ###              ###
##### End script #####
