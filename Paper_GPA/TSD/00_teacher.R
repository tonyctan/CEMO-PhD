###### ADMIN INFO ######
# Date: 26 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Re-format teacher-assigned marks into student-by-subject shape

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to registry data folder depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("N:/durable/data/registers")
} else {
    setwd("/ess/p1708/data/durable/data/registers")
}
if (interactive()) {
    getwd()
} else {
    cat(paste0(
        "Working directory is now set to ", getwd(), "\n"
    ))
}

# Read in W21_4952_TAB_KAR_GRS.csv
if (!interactive()) {
    print("Start data loading...")
}
gpa <- data.table::fread("W21_4952_TAB_KAR_GRS.csv")
if (interactive()) {
    names(gpa)
} else {
    print("Data loading complete.")
}
if (interactive()) {
    dim(gpa)
}

# Immediately change working directory to personal space
if (Sys.info()["sysname"] == "Linux") {
    setwd("/ess/p1708/home/p1708-tctan/Documents/Paper_GPA")
} else {
    setwd("M:/p1708-tctan/Documents/Paper_GPA")
}


# Only keep 2019 teacher-assigned data (STP, Column 7)
teacher_2019 <- gpa[which(gpa$AVGDATO == 201906), c(1:4, 7)]
# Verify the correct N obs have been imported
n_student <- nrow(teacher_2019) # Should be 1,073,204 obs
if (interactive()) {
    print(n_student)
}

# Inspect unusual marks in the "STP" column
if (interactive()) {
    table(unlist(teacher_2019$STP))
}
# These marks are not usable:
#   '' empty [n = 20,042],
#   7 [n = 33],
#   D [n = 58,182],
#   F [n = 37,273],
#   GK [n = 55],
#   IM [n = 2],
#   IV [n = 12,576].

# Recode un-usable STP into NA
teacher_2019$STP <- car::recode(teacher_2019$STP, "
    c('', '7', 'D', 'F', 'GK', 'IM', 'IV') = NA
")



# Part 1: Re-shape teacher-assigned marks columns: one subject per column

# How many subjects there are? (Answer: 200 different subjects in total)
# How many times each subject name appeared (with or without valid score)?
subject_frequency <- sort(
    table(unlist(teacher_2019$FAGKODE)),
    decreasing = TRUE
)
if (interactive()) {
    print(subject_frequency)
}

# Save subject list
subject_list <- as.character(data.frame(subject_frequency)[, 1])
# Save total number of subjects
n_subject <- length(subject_list)
if (interactive()) {
    n_subject
} # Should be 200 subjects in total

# Create a placeholder spreadsheet
stp_spreadsheet <- data.frame(
    matrix(NA, nrow = n_student, ncol = n_subject)
)
colnames(stp_spreadsheet) <- subject_list

# Stitch STP and this empty placeholder spreadsheet together
teacher_reshape <- cbind(teacher_2019, stp_spreadsheet)
if (interactive()) {
    names(teacher_reshape)
}

# Set up multi-core processing
library("doMC")
library("foreach")
registerDoMC(5)

# Set up a progress bar
library(progress)
n_iter <- ncol(teacher_reshape) # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = FALSE,
    width = 100
)

foreach (j = 6:n_iter) %dopar% { # 200 cycles
    # Insert progress bar here
    pb$tick() # Update progress bar

    # Create a placeholder list
    temp <- rep(names(teacher_reshape)[j], n_student)
    # Test whether subject names match
    equal_test <- temp == teacher_reshape[, 4]
    # Turn FALSE/TRUE to 0/1
    equal_test <- equal_test + 0

    # If subject name matches, copy-paste teacher-assign marks (STP)
    # into the temp_subject column
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
teacher_reshaped <- teacher_reshape[, -c(4, 5)]
# Inspect the newly shaped data set
if (interactive()) {
    head(teacher_reshaped, 20)
}



# Part 2: Re-shape rows: one student per row

# How many (unique) students there are? (Answer: 64,918 unique students)
# How many times each student ID appeared (with or without valid score)?
student_frequency <- data.frame(sort(
    table(unlist(teacher_reshaped$w21_4952_lopenr_person)),
    decreasing = TRUE
))
# Display the top and bottom 20 students who took the most number of subjects
if (interactive()) {
    print(head(student_frequency, 20))
    print(tail(student_frequency, 20))
}
# Save student list
student_list <- as.character(student_frequency[, 1])
# Save total number of unique students
n_unique_student <- length(student_list) # 64,918 unique students
if (interactive()) {
    print(n_unique_student)
}

# Set up a placeholder spreadsheet
teacher_reshaped_final <- matrix(
    nrow = n_unique_student,
    ncol = ncol(teacher_reshaped)
)
colnames(teacher_reshaped_final) <- names(teacher_reshaped)
teacher_reshaped_final <- data.frame(teacher_reshaped_final)

### Multi-core always breaks RAM. For the time being just use single core.
n_cores <- 1

# # Prepare multi-core processing
# if (Sys.info()["sysname"] == "Windows") { # Windows can only use single core
#     n_cores <- 1
# } else { # Both Linux and Mac can implement multicore
#     n_cores <- parallel::detectCores() # Count the total number of CPU cores
#     n_cores <- n_cores - 1 # Reserve one core for system admin
# }

# Set up a progress bar
n_iter <- n_unique_student  # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = FALSE,
    width = 100
)

foreach (i = 1:n_iter) %dopar% {
    # Insert progress bar here
    pb$tick()

    # Pull out lines that share the same Student ID
    student_temp <- teacher_reshaped[which(
        teacher_reshaped[, 1] == student_list[i]
    ), ]

    # Collapse multiple lines into one line
    student_temp_teacher <- parallel::mclapply(student_temp[, -c(1:3)],
    function(x) max(x, na.rm = T), mc.cores = n_cores)

    # In cases where, same person, same subject, but multiple marks,
    # take the maximum, because I do not know which score was given first.

    # When I asked R to compute max from a column containing NA only,
    # R produced -Inf and a warning. Safe to ignore these warnings and
    # turn -Inf to NA.

    # Recode 0 and -Inf to NA
    student_temp_teacher <- car::recode(student_temp_teacher, "
        c('0', '-Inf') = NA
    ")

    # Stitch admin variables to student_temp_teacher (need transpose)
    teacher_reshaped_final[i, ] <- data.frame(cbind(
        student_temp[1, c(1:3)], t(student_temp_teacher)
    ))
}

# Save the "standard Student ID list" for future work
student_id <- data.frame(teacher_reshaped_final[, 1]) # Extract the 1st column
names(student_id) <- "student_id" # Give it a column name
data.table::fwrite(
    student_id,
    "./data/00_student_id.csv",
    row.names = FALSE, col.names = TRUE
)
# Should be 888 KB in size

# Save teacher-assigned marks
data.table::fwrite(
    teacher_reshaped_final,
    "./data/01_teacher.csv",
    row.names = FALSE
)
# Should be 15,345 KB in size

  #                            #  
 ###                          ### 
#####       End script       #####
