###### ADMIN INFO ######
# Date: 25 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract students' gender info (kjonn, var = 29-59) based on Student ID list (that was derived from File seq = 157)

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
###                          ###
#                            #

# Point working directory to the location of all registry datasets, depending on OS
if (Sys.info()["sysname"] == "Linux") {
    setwd("/tsd/p1708/data/durable/data/registers")
} else {
    setwd("N:/durable/data/registers")
}



# Step 1: Read in gender data and Student ID

# (File seq = 122; File name = "W21_4952_REGSYS_2019.csv")
gender <- data.frame(data.table::fread(
    "W21_4952_REGSYS_2019.csv", select = c(1, 16)
))

# Read in "student_id_match.csv"
student_id <- data.frame(data.table::fread(
    "M:/p1708-tctan/Documents/student_id_match.csv",
    select = c(1)
))



# Step 2: Match students' gender info to their IDs

# Create a placeholder matrix
temp <- data.frame(
    matrix(NA, nrow = dim(student_id)[1], ncol = 2)
)
colnames(temp) <- c(names(gender))

# Fill this placeholder matrix with matching results
for (i in 13001:19500) { # Go through the Student ID list:
    # Test if there is any match
    test <- gender$w21_4952_lopenr_person == student_id[i,1]
    test <- test + 0 # Turn FALSE/TRUE into 0/1
    test_result <- sum(test) # If a match is found, sum > 0

    # If no match is found, record student ID in Column 1 of "temp", leave the rest of the columns untouched, and move to the next student
    if (test_result == 0) {
        temp[i, 1] <- student_id[i,1]
    } else {
        # If a match is found
        temp[i, ] <- data.frame(
            gender[which(gender$w21_4952_lopenr_person == student_id[i,1]), ]
        )
    }
}

write.table(temp[c(13001:19500),], "M:/p1708-tctan/Documents/gender/3.csv", row.names = F, col.names = F)

  #                            #  
 ###                          ### 
#####       End script       #####
