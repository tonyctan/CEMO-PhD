###### ADMIN INFO ######
# Date: 04 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract variable names and their descriptive statistics from registry datasets

###### DATA PROTECTION ######
# Nature: An R script scraping Norwegian registry data leading to files containing no personal info
# Security level (input-script-output): black-yellow-yellow
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to the location of all registry datasets
setwd("N:/durable/data/registers/")

# Create an empty list that contains all CSV file names
file_names <- list.files(getwd(), pattern = "*.csv", full.names = F)
# Remember how many files there are in total
total_files <- length(file_names) # Should be 183

# Create a placeholder matrix to receive dimension info of each dataset
dim_list <- matrix(nrow = total_files, ncol = 2)

# Read in each data file
data.table::setDTthreads(16) # Use all 16 CPU cores---not interesting in Windows but will be much more efficient in Linux

# Save descriptive statistics of each variable
for (i in 1:total_files) {
    temp <- data.table::fread(file_names[i]) # Read in dataset one at a time
    temp <- janitor::clean_names(temp) # Replace " " in var names with "_"

    dim_list[i, ] <- dim(temp) # Save dimension info to dim_list

    # Variable name
    var_names <- data.frame(attributes(temp)[1])[,1] # Extract variable names

    # Missings
    na_count <- data.frame(colSums(is.na(temp)))[,1] # Number of missings
    na_percent <- na_count / dim(temp)[1] * 100 # Turn to missing percentages

    # Descriptive statistics
    # parallel::mclapply() not interesting for Windows but super quick for Linux
    min <- as.numeric(parallel::mclapply(temp, function(x) min(x, na.rm=T)))
    max <- as.numeric(parallel::mclapply(temp, function(x) max(x, na.rm=T)))
    mean <- as.numeric(parallel::mclapply(temp, function(x) mean(x, na.rm=T)))
    median <- as.numeric(parallel::mclapply(temp, function(x) median(x, na.rm=T)))
    variance <- as.numeric(parallel::mclapply(temp, function(x) var(x, na.rm=T)))
    sd <- as.numeric(parallel::mclapply(temp, function(x) sd(x, na.rm=T)))
    # Skewness and kurtosis need extra packages
    skewness <- as.numeric(parallel::mclapply(temp, function(x) DescTools::Skew(x, na.rm=T)))
    kurtosis <- as.numeric(parallel::mclapply(temp, function(x) DescTools::Kurt(x, na.rm=T)))

    write.table(
        cbind(var_names, # This column is text.
            round(cbind(
                na_count, na_percent,
                min, max,
                mean, median,
                variance, sd,
                skewness, kurtosis),
            digits = 2) # These columns are numeric
        ), # Text + numeric = quotation marks everywhere
        paste0("M:/p1708-tctan/Documents/Variable_names/", file_names[i]),
        quote = F, # Remove all quotation marks
        col.names = F # Do not print column names
    )

    # Dump temporary files and variables to free up RAM
    rm(temp, var_names)
    rm(na_count, na_percent)
    rm(min, max, mean, median, variance, sd, skewness, kurtosis)
}

# Save dimension info of all datasets
write.table(cbind(file_names, dim_list),
    "M:/p1708-tctan/Documents/Variable_names/dim_list.csv",
    quote = F, # Do not put quotation marks around data
    col.names = F # Do not print column names
)

  #                            #  
 ###                          ### 
#####       End script       #####
