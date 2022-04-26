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
names(gpa)

# Only keep 2019 data
# STP (Teacher assigned marks)
teacher_mk <- gpa[which(gpa$AVGDATO == 201906), c(1:4, 7)]
# Verify the correct N obs have been imported
(n_student <- dim(teacher_mk)[1]) # Should be 1,073,204 obs

# Inspect unusual marks in the "STP" column
table(unlist(teacher_mk$STP))
# These marks are not usable:
#   '' empty [n = 20,042],
#   D [n = 58,182],
#   F [n = 37,273],
#   GK [n = 55],
#   IM [n = 2],
#   IV [n = 12,576].

# Recode un-usable STP into NA
teacher_mk$STP <- car::recode(teacher_mk$STP, "
    c('', 'D', 'F', 'GK', 'IM', 'IV') = NA
")



# Part 1: Re-shape teacher-assigned marks columns: one subject per column

# How many subjects there are? (Answer: 200 different subjects in total)
# How many times each subject name appeared (with or without valid score)?
(subject_frequency <- sort(table(unlist(teacher_mk$FAGKODE)), decreasing = T))
# Save subject list
subject_list <- as.character(data.frame(subject_frequency)[, 1])
# Save total number of subjects
n_subject <- length(subject_list)

# Create a placeholder spreadsheet
stp_spreadsheet <- data.frame(matrix(NA, nrow = n_student, ncol = n_subject))
colnames(stp_spreadsheet) <- subject_list

# Stitch STP and this empty placeholder spreadsheet together
teacher_reshape <- cbind(teacher_mk, stp_spreadsheet)
names(teacher_reshape)

for (j in 6:dim(teacher_reshape)[2]) { # 200 cycles
    # Create a placeholder list
    temp <- rep(names(teacher_reshape)[j], n_student)
    # Test whether subject names match
    equal_test <- temp == teacher_reshape[, 4]
    # Turn FALSE/TRUE to 0/1
    equal_test <- equal_test + 0

    # If subject name matches, copy-paste teacher-assign marks into the temp_subject column
    temp_subject <- equal_test * teacher_reshape[, 5]
    # Turn off list property (in order to recode)
    temp_subject <- as.numeric(unlist(temp_subject))
    # Recode 0 to NA
    teacher_reshape[, j] <- car::recode(temp_subject, "0 = NA")

    # Clear the deck for the next iteration
    rm(temp)
    rm(equal_test)
    rm(temp_subject)
}

# Remove subject name and STP columns
teacher_reshaped <- teacher_reshape[, -c(4,5)]
# Inspect the newly shaped data set
head(teacher_reshaped, 20)
# Save to external file.
if (Sys.info()["sysname"] == "Linux") {
    write.table(teacher_reshaped,
        "/tsd/p1708/home/p1708-tctan/Documents/teacher0.csv",
        row.names = F
    )
} else {
    write.table(teacher_reshaped,
        "M:/p1708-tctan/Documents/teacher0.csv",
        row.names = F
    )
}
# Should be 660,894 KB in size



# Part 2: Re-shape rows: one student per row

# How many (unique) students there are? (Answer: 64,918 unique students)
# How many times each student ID appeared (with or without valid score)?
student_frequency <- data.frame(sort(
    table(unlist(teacher_reshaped$w21_4952_lopenr_person)),
    decreasing = T
))
# Display the top 20 students who took the most number of subjects
head(student_frequency, 20)
# Display the bottom 20 students who took the least number of subjects
tail(student_frequency, 20)
# Save student list
student_list <- as.character(student_frequency[, 1])
# Save total number of unique students
(n_unique_student <- length(student_list)) # 64,918 unique students

# Set up a placeholder spreadsheet
teacher_reshaped_final <- matrix(
    nrow = n_unique_student, ncol = dim(teacher_reshaped)[2]
)
colnames(teacher_reshaped_final) <- names(teacher_reshaped)
teacher_reshaped_final <- data.frame(teacher_reshaped_final)

# Prepare multi-core processing
if (Sys.info()["sysname"] == "Linux") {
    n_cores <- parallel::detectCores()
    n_cores <- num_cores - 1 # Reserve one core for Linux admin
} else {
    n_cores <- 1 # Windows cannot take advantage of multicore
}

for(i in 1:n_unique_student) {
    # Pull out lines that share the same Student ID
    student_temp <- teacher_reshaped[which(teacher_reshaped[, 1] == student_list[i]), ]
    # Collapse multiple lines into one line
    student_temp_teacher <- parallel::mclapply(student_temp[, -c(1:3)],
    function(x) max(x, na.rm = T), mc.cores = n_cores) # In cases where, same person, same subject, but multiple scores, take the maximum, because I do not know which score was given first.
    # When I asked R to compute max from a column containing NA only, R produced -Inf and a warning. Safe to ignore these warnings and turn -Inf to NA.
    # Recode 0 to NA
    student_temp_teacher <- car::recode(student_temp_teacher, "
        c('0', '-Inf') = NA
    ")
    # Stitch admin variables to student_temp_teacher (need transpose)
    teacher_reshaped_final[i, ] <- data.frame(cbind(
        student_temp[1, c(1:3)], t(student_temp_teacher)
    ))
}

if (Sys.info()["sysname"] == "Linux") {
    write.table(teacher_reshaped_final,
        "/tsd/p1708/home/p1708-tctan/Documents/teacher1.csv",
        row.names = F
    )
} else {
    write.table(teacher_reshaped_final,
        "M:/p1708-tctan/Documents/teacher1.csv",
        row.names = F
    )
}
# Should be 93,112 KB in size

  #                            #  
 ###                          ### 
#####       End script       #####