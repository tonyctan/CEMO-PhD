###### ADMIN INFO ######
# Date: 26 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Re-format written exam marks into student-by-subject shape

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to
# files containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to the location of all registry datasets,
# depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("N:/durable/data/registers")
} else {
    setwd("/tsd/p1708/data/durable/data/registers")
}
if (interactive()) {getwd()} else {cat(paste0(
    "Working directory is now set to ", getwd(), "\n"
))}


# Read in W21_4952_TAB_KAR_GRS.csv
if (!interactive()) {print("Start data loading...")}
gpa <- data.table::fread("W21_4952_TAB_KAR_GRS.csv")
# Display dataset info only if in interactive mode
if (interactive()) {names(gpa)} else {print("Data loading complete.")}
if (interactive()) {dim(gpa)}

# Only keep 2019 written exam data (SKR, Column 8)
written_2019 <- gpa[which(gpa$AVGDATO == 201906), c(1:4, 8)]
# Verify the correct N obs have been imported
n_student <- dim(written_2019)[1] # Should be 1,073,204 obs
if (interactive()) {n_student}

# Inspect unusual marks in the "SKR" column
if (interactive()) {
    table(unlist(written_2019$SKR))
}
# These marks are not usable:
#   '' empty [n = 995,078],
#   D [n = 1],
#   F [n = 977],
#   IM [n = 1,723],
#   IV [n = 19].

# Recode un-usable SKR into NA
written_2019$SKR <- car::recode(written_2019$SKR, "
    c('', 'D', 'F', 'IM', 'IV') = NA
")



# Part 1: Re-shape written exam marks columns: one subject per column

# How many subjects there are? (Answer: 200 different subjects in total)
# How many times each subject name appeared (with or without valid score)?
subject_frequency <- sort(
        table(unlist(written_2019$FAGKODE)),
        decreasing = T
)
if (interactive()) {subject_frequency}

# Save subject list
subject_list <- as.character(data.frame(subject_frequency)[, 1])
# Save total number of subjects
n_subject <- length(subject_list)
if (interactive()) {n_subject} # Should be 200 subjects in total

# Create a placeholder spreadsheet
written_spreadsheet <- data.frame(
    matrix(NA, nrow = n_student, ncol = n_subject)
)
colnames(written_spreadsheet) <- subject_list

# Stitch SKR and this empty placeholder spreadsheet together
written_reshape <- cbind(written_2019, written_spreadsheet)
if (interactive()) {names(written_reshape)}

# Set up a progress bar
library(progress)
n_iter <- dim(written_reshape)[2] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

for (j in 6:n_iter) { # 200 cycles
    # Insert progress bar here
    pb$tick() # Update progress bar

    # Create a placeholder list
    temp <- rep(names(written_reshape)[j], n_student)
    # Test whether subject names match
    equal_test <- temp == written_reshape[, 4]
    # Turn FALSE/TRUE to 0/1
    equal_test <- equal_test + 0

    # If subject name matches, copy-paste written exam marks into
    # the temp_subject column
    temp_subject <- equal_test * written_reshape[, 5]
    # Turn off list property (in order to recode)
    temp_subject <- as.numeric(unlist(temp_subject))
    # Recode 0 to NA
    written_reshape[, j] <- car::recode(temp_subject, "0 = NA")

    # Clear the deck for the next iteration
    rm(temp)
    rm(equal_test)
    rm(temp_subject)
}

# Remove subject name and SKR columns
written_reshaped <- written_reshape[, -c(4, 5)]

# Inspect the newly shaped data set
if (interactive()) {head(written_reshaped, 20)}

# Save to external file.
if (Sys.info()["sysname"] == "Windows") {
    data.table::fwrite(written_reshaped,
        "M:/p1708-tctan/Documents/02_written0.csv",
        row.names = F
    )
} else {
    data.table::fwrite(written_reshaped,
        "/tsd/p1708/home/p1708-tctan/Documents/02_written0.csv",
        row.names = F
    )
}
# Should be 661,743 KB in size



# Part 2: Re-shape rows: one student per row

# In order to maintain consistency, use the standard Student ID list
if (Sys.info()["sysname"] == "Windows") {
    student_list <- data.table::fread(
        "M:/p1708-tctan/Documents/01_student_id.csv"
    )
} else {
    student_list <- data.table::fread(
        "/tsd/p1708/home/p1708-tctan/Documents/01_student_id.csv"
    )
}
# Save total number of unique students
n_unique_student <- dim(student_list)[1] # 64,918 unique students
if (interactive()) {n_unique_student}

# Set up a placeholder spreadsheet
written_reshaped_final <- matrix(
    nrow = n_unique_student,
    ncol = dim(written_reshaped)[2]
)
colnames(written_reshaped_final) <- names(written_reshaped)
written_reshaped_final <- data.frame(written_reshaped_final)

### Multi-core always breaks RAM. For the time being just use single core.
n_cores <- 1
# # Prepare multi-core processing
# if (Sys.info()["sysname"] == "Windows") { # Windows can only use single core
#     n_cores <- 1
# } else { # Both Linux and Mac can implement multicore
#     n_cores <- parallel::detectCores() # Count the total number of CPU cores
#     n_cores <- n_cores - 1 # Reserve one core for system admin
# }

# Reset progress bar
n_iter <- n_unique_student # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

for (i in 1:n_iter) {pb$tick()
    # Pull out lines that share the same Student ID
    student_temp <- written_reshaped[which(
        written_reshaped[, 1] == as.character(student_list[i, 1])
    ), ]

    # Collapse multiple lines into one line
    student_temp_written <- parallel::mclapply(student_temp[, -c(1:3)],
    function(x) max(x, na.rm = T), mc.cores = n_cores)

    # In cases where, same person, same subject, but multiple marks,
    # take the maximum, because I do not know which score was given first.

    # When I asked R to compute max from a column containing NA only,
    # R produced -Inf and a warning. Safe to ignore these warnings and
    # turn -Inf to NA.

    # Recode 0 and -inf to NA
    student_temp_written <- car::recode(student_temp_written, "
        c('0', '-Inf') = NA
    ")

    # Stitch admin variables to student_temp_written (need transpose)
    written_reshaped_final[i, ] <- data.frame(cbind(
        student_temp[1, c(1:3)],
        t(student_temp_written) # t(...) = transpose
    ))
}

# Save written exam marks
if (Sys.info()["sysname"] == "Windows") {
    data.table::fwrite(written_reshaped_final,
        "M:/p1708-tctan/Documents/02_written1.csv",
        row.names = F
    )
} else {
    data.table::fwrite(written_reshaped_final,
        "/tsd/p1708/home/p1708-tctan/Documents/02_written1.csv",
        row.names = F
    )
}
# Should be 14,496 KB in size

  #                            #  
 ###                          ### 
#####       End script       #####