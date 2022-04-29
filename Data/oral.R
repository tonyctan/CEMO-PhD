###### ADMIN INFO ######
# Date: 26 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Re-format oral exam marks into student-by-subject shape

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
if (interactive()) {} else {print(paste0(
    "Working directory is now set to ", getwd()
))}

# Read in W21_4952_TAB_KAR_GRS.csv
if (interactive()) {} else {print("Start data loading...")}
gpa <- data.table::fread("W21_4952_TAB_KAR_GRS.csv")
# Display column names only if in interactive mode
if (interactive()) {names(gpa)} else {print("Data loading complete.")}

# Only keep 2019 oral exam data (MUN, Column 9)
oral_mk <- gpa[which(gpa$AVGDATO == 201906), c(1:4, 9)]
# Verify the correct N obs have been imported
n_student <- dim(oral_mk)[1] # Should be 1,073,204 obs
if (interactive()) {n_student}

# Inspect unusual marks in the "MUN" column
if (interactive()) {
    table(unlist(oral_mk$MUN))
}
# These marks are not usable:
#   '' empty [n = 1,011,693],
#   F [n = 451],
#   IM [n = 1804],
#   IV [n = 7],
#   Z [n = 1].

# Recode un-usable MUN into NA
oral_mk$MUN <- car::recode(oral_mk$MUN, "
    c('', 'F', 'IM', 'IV', 'Z') = NA
")



# Part 1: Re-shape oral exam marks columns: one subject per column

# How many subjects there are?
# How many times each subject name appeared (with or without valid score)?
subject_frequency <- sort(table(unlist(oral_mk$FAGKODE)), decreasing = T)
if (interactive()) {subject_frequency}
# Save subject list
subject_list <- as.character(data.frame(subject_frequency)[, 1])
# Save total number of subjects
n_subject <- length(subject_list)
if (interactive()) {n_subject} # Should be 200 subjects in total

# Create a placeholder spreadsheet
mun_spreadsheet <- data.frame(matrix(NA, nrow = n_student, ncol = n_subject))
colnames(mun_spreadsheet) <- subject_list

# Stitch MUN and this empty placeholder spreadsheet together
oral_reshape <- cbind(oral_mk, mun_spreadsheet)
if (interactive()) {names(oral_reshape)}

for (j in 6:dim(oral_reshape)[2]) { # 200 cycles
    # Create a placeholder list
    temp <- rep(names(oral_reshape)[j], n_student)
    # Test whether subject names match
    equal_test <- temp == oral_reshape[, 4]
    # Turn FALSE/TRUE to 0/1
    equal_test <- equal_test + 0

    # If subject name matches, copy-paste oral exam marks into
    # the temp_subject column
    temp_subject <- equal_test * oral_reshape[, 5]
    # Turn off list property (in order to recode)
    temp_subject <- as.numeric(unlist(temp_subject))
    # Recode 0 to NA
    oral_reshape[, j] <- car::recode(temp_subject, "0 = NA")
    if (interactive()) {} else {
        print(paste0(
            "Iterating Subject ", j - 5, "/200"
        ))
    }

    # Clear the deck for the next iteration
    rm(temp)
    rm(equal_test)
    rm(temp_subject)
}

# Remove subject name and MUN columns
oral_reshaped <- oral_reshape[, -c(4, 5)]

# # Inspect the newly shaped data set
# head(oral_reshaped, 20)
# # Save to external file.
# if (Sys.info()["sysname"] == "Windows") {
#     data.table::fwrite(oral_reshaped,
#         "M:/p1708-tctan/Documents/oral0.csv",
#         row.names = F
#     )
# } else {
#     data.table::fwrite(oral_reshaped,
#         "/tsd/p1708/home/p1708-tctan/Documents/oral0.csv",
#         row.names = F
#     )
# }
# # Should be 661,759 KB in size



# Part 2: Re-shape rows: one student per row

# In order to maintain consistency, use the standard Student ID list
# if (interactive) {
#     if (Sys.info()["sysname"] == "Windows") {
#         student_list <- data.table::fread(
#             "M:/p1708-tctan/Documents/student_id.csv"
#         )
#     } else {
#         student_list <- data.table::fread(
#             "/tsd/p1708/home/p1708-tctan/Documents/student_id.csv"
#         )
#     }
# } else {
#     student_list <- data.table::fread(
#         "M:/p1708-tctan/Documents/student_id.csv"
#     )
# }


student_list <- data.table::fread("M:/p1708-tctan/Documents/student_id.csv")


# Save total number of unique students
n_unique_student <- dim(student_list)[1] # 64,918 unique students
if (interactive()) {n_unique_student}

# Set up a placeholder spreadsheet
oral_reshaped_final <- matrix(
    nrow = n_unique_student, ncol = dim(oral_reshaped)[2]
)
colnames(oral_reshaped_final) <- names(oral_reshaped)
oral_reshaped_final <- data.frame(oral_reshaped_final)

# Prepare multi-core processing
if (Sys.info()["sysname"] == "Linux") {
    n_cores <- parallel::detectCores()
    n_cores <- n_cores - 1 # Reserve one core for Linux admin
} else {
    n_cores <- 1 # Windows cannot take advantage of multicore
}

# Chop a large loop into many small loops
args <- commandArgs(trailingOnly = T)

for (i in as.numeric(args[1]):as.numeric(args[2])) {
    # Pull out lines that share the same Student ID
    student_temp <- oral_reshaped[which(
        oral_reshaped[, 1] == as.character(student_list[i, 1])
    ), ]
    # Collapse multiple lines into one line
    student_temp_oral <- parallel::mclapply(student_temp[, -c(1:3)],
    function(x) max(x, na.rm = T), mc.cores = n_cores)
    # In cases where, same person, same subject, but multiple marks,
    # take the maximum, because I do not know which score was given first.
    # When I asked R to compute max from a column containing NA only,
    # R produced -Inf and a warning. Safe to ignore these warnings and
    # turn -Inf to NA.
    # Recode 0 and -Inf to NA
    student_temp_oral <- car::recode(student_temp_oral, "
        c('0', '-Inf') = NA
    ")
    # Stitch admin variables to student_temp_oral (need transpose)
    oral_reshaped_final[i, ] <- data.frame(cbind(
        student_temp[1, c(1:3)], t(student_temp_oral)
    ))
    if (interactive()) {} else {
        print(paste0(
            "Iterating Student ", i, "/", as.numeric(args[2]) - as.numeric(args[1]) + 1
        ))
    }

    # # Save intermediate files
    # if (interactive()) {
    #     if (Sys.info()["sysname"] == "Windows") {
    #         data.table::fwrite(
    #             oral_reshaped_final[c(as.numeric(args[1]):as.numeric(args[2])),],
    #             paste0("M:/p1708-tctan/Documents/oral/", args[1], ".csv"),
    #             row.names = F
    #         )
    #     } else {
    #         data.table::fwrite(
    #             oral_reshaped_final[c(as.numeric(args[1]):as.numeric(args[2])),],
    #             paste0("/tsd/p1708/home/p1708-tctan/Documents/oral/", args[1], ".csv"),
    #             row.names = F
    #         )
    #     }
    # } else {
    #     data.table::fwrite(
    #         oral_reshaped_final[c(as.numeric(args[1]):as.numeric(args[2])),],
    #         paste0("M:/p1708-tctan/Documents/oral/", args[1], ".csv"),
    #         row.names = F
    #     )
    # }

data.table::fwrite(
    oral_reshaped_final[c(as.numeric(args[1]):as.numeric(args[2])), ],
    paste0("M:/p1708-tctan/Documents/oral/", args[1], ".csv"),
    row.names = F, col.names = F
)

}


if (Sys.info()["sysname"] == "Windows") {
    data.table::fwrite(oral_reshaped_final,
        "M:/p1708-tctan/Documents/oral1.csv",
        row.names = F
    )
} else {
    data.table::fwrite(oral_reshaped_final,
        "/tsd/p1708/home/p1708-tctan/Documents/oral1.csv",
        row.names = F
    )
}
# Should be 14,480 KB in size


  #                            #  
 ###                          ### 
#####       End script       #####