###### ADMIN INFO ######
# Date: 23 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Re-format GPA data into student-by-subject shape

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

# Read in W21_4952_TAB_KAR_GRS.csv
gpa <- data.table::fread("W21_4952_TAB_KAR_GRS.csv")

# Only keep 2019 data and only keep GPA (STP in Norwegian and in data set)
gpa2019 <- gpa[which(gpa$AVGDATO == 201906), -c(5,6,8,9,10)]
n_student <- dim(gpa2019)[1] # 1,073,204 obs

# Inspect unusual grades in the "STP" column
table(unlist(gpa2019$STP))
# These marks are not usable:
#   '' empty [n = 20042],
#   D [n = 58182],
#   F [n = 37273],
#   GK [n = 55],
#   IM [n = 2],
#   IV [n = 12576].

# Recode un-usable GPA grades into NA
gpa2019$STP <- car::recode(gpa2019$STP, "
    c('', 'D', 'F', 'GK', 'IM', 'IV') = NA
")



# Part 1: Re-shape columns: one subject per column

# How many subjects there are? (Answer: 200 different subjects in total)
# How many times each subject name appeared (with or without valid score)?
(subject_frequency <- sort(table(unlist(gpa2019$FAGKODE)), decreasing = T))
# Save subject list
subject_list <- as.character(data.frame(subject_frequency)[, 1])
# Save total number of subjects
n_subject <- length(subject_list)

# Create a placeholder spreadsheet
gpa_spreadsheet <- data.frame(matrix(NA, nrow = n_student, ncol = n_subject))
colnames(gpa_spreadsheet) <- subject_list

# Stitch gpa2019 and this empty placeholder spreadsheet together
gpa_allocation <- cbind(gpa2019, gpa_spreadsheet)
names(gpa_allocation)

for (j in 6:dim(gpa_allocation)[2]) {
    # Create a placeholder list
    temp <- rep(names(gpa_allocation)[j], n_student)
    # Test whether subject names match
    equal_test <- temp == gpa_allocation[, 4]
    # Turn FALSE/TRUE to 0/1
    equal_test <- equal_test + 0

    # If subject name matches, copy-paste GPA into the temp_subject column
    temp_subject <- equal_test * gpa_allocation[, 5]
    # Turn off list property (in order to recode)
    temp_subject <- as.numeric(unlist(temp_subject))
    # Recode 0 to NA
    gpa_allocation[, j] <- car::recode(temp_subject, "0 = NA")

    # Clear the deck for the next iteration
    rm(temp)
    rm(equal_test)
    rm(temp_subject)
}

# Remove subject name and STP columns
gpa_allocation <- gpa_allocation[, -c(4,5)]
# Inspect the newly shaped data set
chead(gpa_allocation, 20)
# Save to external file.
if (Sys.info()["sysname"] == "Linux") {
    write.table(gpa_allocation,
        "/tsd/p1708/home/p1708-tctan/Documents/gpa0.csv",
        row.names = F
    )
} else {
    write.table(gpa_allocation,
        "M:/p1708-tctan/Documents/gpa0.csv",
        row.names = F
    )
}



# Part 2: Re-shape rows: one student per row

# How many (unique) students there are? (Answer: 64,918 unique students)
# How many times each student ID appeared (with or without valid score)?
student_frequency <- data.frame(sort(
    table(unlist(gpa_allocation$w21_4952_lopenr_person)),
    decreasing = T
))
# Display the top 20 students who took the most number of subjects
head(student_frequency, 20)
# Display the bottom 20 students who took the least number of subjects
tail(student_frequency, 20)
# Save student list
student_list <- as.character(student_frequency[, 1])
# Save total number of unique students
n_unique_student <- length(student_list) # 64,918 unique students

# Set up a placeholder spreadsheet
gpa_spreadsheet_final <- matrix(
    nrow = n_unique_student, ncol = dim(gpa_allocation)[2]
)
colnames(gpa_spreadsheet_final) <- names(gpa_allocation)
gpa_spreadsheet_final <- data.frame(gpa_spreadsheet_final)

# Prepare multi-core processing
if (Sys.info()["sysname"] == "Linux") {
    n_cores <- parallel::detectCores()
    n_cores <- num_cores - 1 # Reserve one core for Linux admin
} else {
    n_cores <- 1 # Windows cannot take advantage of multicore
}

for(i in 1:n_unique_student) {
    # Pull out lines that share the same Student ID
    student_temp <- gpa_allocation[which(gpa_allocation[, 1] == student_list[i]), ]
    # Collapse multiple lines into one line
    student_temp_gpa <- parallel::mclapply(student_temp[, -c(1:3)],
    function(x) max(x, na.rm = T), mc.cores = n_cores) # In cases where, same person, same subject, but multiple scores, take the maximum, because I do not know which score was given first.
    # Recode 0 to NA
    student_temp_gpa <- car::recode(student_temp_gpa, "
        0 = NA
    ")
    # Stitch admin variables to student_temp_gpa (need transpose)
    gpa_spreadsheet_final[i, ] <- data.frame(cbind(
        student_temp[1, c(1:3)], t(student_temp_gpa)
    ))
}

if (Sys.info()["sysname"] == "Linux") {
    write.table(gpa_spreadsheet_final,
        "/tsd/p1708/home/p1708-tctan/Documents/gpa1.csv",
        row.names = F
    )
} else {
    write.table(gpa_spreadsheet_final,
        "M:/p1708-tctan/Documents/gpa1.csv",
        row.names = F
    )
}

  #                            #  
 ###                          ### 
#####       End script       #####