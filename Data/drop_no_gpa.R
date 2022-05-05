###### ADMIN INFO ######
# Date: 01 May 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Drop students without valid GPAs from
# teacher-assigned marks file

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

# Read in W21_4952_TAB_KAR_GRS.csv
if (!interactive()) {print("Start data loading...")}
teacher <- readxl::read_excel("gpa.xlsx", sheet = "STP")
if (interactive()) {names(teacher)} else {print("Data loading complete.")}
# Full data set: N = 64,918

# Drop students without valid GPAs
teacher_gpa <- teacher[!is.na(teacher$GRUNNSKOLEPOENG), ]
if (interactive()) {dim(teacher_gpa)} # 60,618 students remain

# Compute data loss rate (n = 4,300, % = 6.62)
if (interactive()) {
    dim(teacher)[1] - dim(teacher_gpa)[1]
    round((dim(teacher)[1] - dim(teacher_gpa)[1]) / dim(teacher)[1] * 100, 2)
}

# Sort columns by number of valid entries
teacher_sorted <- teacher_gpa[ , order(colSums(is.na(teacher_gpa)))]

# Keep the order of admin variables
teacher_export <- cbind(teacher_gpa[, c(1:8)], teacher_sorted[, -c(1:8)])

# Save the subject list
n_valid <- dim(teacher_export)[1] - colSums(is.na(teacher_export[,-c(1:8)]))
r_valid <- round(n_valid / dim(teacher_export)[1] * 100, 2)
teacher_valid <- cbind(n_valid, r_valid)

# Preserve subject list to an external file
data.table::fwrite(data.frame(teacher_valid), "subject_list.csv", row.names = T)

# Preserve clean dataset
# Data set containing anyone with valid GPA
data.table::fwrite(teacher_export, "./Rolf/stp_valid_gpa.csv", row.names = F)
# Data set containing 13 targeted subjects
data.table::fwrite(teacher_export[, c(1:21)], "./Rolf/stp_13.csv", row.names = F)
# Data set containing 12 targeted subjects
data.table::fwrite(teacher_export[, c(1:20)], "./Rolf/stp_12.csv", row.names = F)

# Remove students whose "first 7" contains >= 4 missings
# Create a placeholder matrix to count the number of missings
na_count <- matrix(NA, nrow = dim(teacher_export)[1], ncol = 2)
na_count[, 1] <- rowSums(is.na(teacher_export[, c(9:15)])) # "First 7"
na_count[, 2] <- rowSums(is.na(teacher_export[, c(16:20)])) # "Next 5"
na_count <- data.frame(na_count)
names(na_count) <- c("first_7", "next_5")

most_three_missing <- teacher_export[which(na_count$first_7 < 4), c(1:20)]
dim(most_three_missing) # 59,462 students remain

# Compute data loss rate (n = 1,156, % = 7.09)
if (interactive()) {
    dim(teacher_export)[1] - dim(most_three_missing)[1]
    round((dim(teacher)[1] - dim(teacher_gpa)[1]) / dim(teacher_export)[1] * 100, 2)
}

# Save most_three_missing dataset to an external file
data.table::fwrite(most_three_missing, "./Rolf/most_three_missing.csv", row.names = F)

  #                            #  
 ###                          ### 
#####       End script       #####
