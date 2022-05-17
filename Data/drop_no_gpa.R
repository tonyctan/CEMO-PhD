###### ADMIN INFO ######
# Date: 01 May 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Drop students without valid GPAs, too many missing in major-7
# too many missing in minor-5

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to ~/Documents, depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("M:/p1708-tctan/Documents")
} else {
    setwd("/tsd/p1708/home/p1708-tctan/Documents/")
}
if (interactive()) {getwd()} else {cat(paste0(
    "Working directory is now set to ", getwd(), "\n"
))}

# Read in gpa.xlsx, Sheet 1 "STP" (teacher-assigned marks)
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

# Save data set containing anyone with valid GPA
data.table::fwrite(teacher_export, "./Rolf/stp_valid_gpa.csv", row.names = F)

# Save "the 12 subjects" including both Norwegian and Sami as instruction lang
teacher_export_subj_12 <- teacher_export[, c(
    # English x 2
        # ENGW:
    'ENG0012',  # 1 English (written)
        # ENGO:
    'ENG0013',  # 2 English  (oral)
    # HAND: Handcraft
    'KHV0010',  # 3 Handcraft
    'KHV0020',  # 4 Duoji (Sami handcraft)
    # PHED: Physical Education
    'KRO0020',  # 5 P.E.
    # MATH: Mathematics
    'MAT0010',  # 6 Mathematics
    # FOOD: Food and Health
    'MHE0010',  # 7 Food and Health
    'MHE0020',  # 8 Food and Health  (instructed in Sami)
    # MUSI: Music
    'MUS0010',  # 9 Music
    'MUS0020',  # 10 Music  (instructed in Sami)
    # NATS: Natural Sciences
    'NAT0010',  # 11 Natural Sciences
    'NAT0020',  # 12 Natural Sciences  (instructed in Sami)
    # Norwegian x 2
        # NORW:
    'NOR0214',  # 13 Norwegian  (written)
    'NOR0041',  # 14 Norwegian  (written, native language Sami)
        # NORO:
    'NOR0216',  # 15 Norwegian  (oral)
    'NOR0042',  # 16 Norwegian  (oral, native language Sami)
    # RELI: Religion
    'RLE0030',  # 17 Religion
    'RLE0040',  # 18 Religion  (instructed in Sami)
    # SOCS: Social Sciences
    'SAF0010',  # 19 Social Sciences
    'SAF0020'   # 20 Social Sciences (instructed in Sami)
)]
# Add admin variables to "the 12 subjects" list
teacher_export_12 <- cbind(teacher_export[, c(1:8)], teacher_export_subj_12)
# Save "the 12 subjects"
data.table::fwrite(teacher_export_12, "./Rolf/stp_12.csv", row.names = F)



# Merge Norwegian- and Sami-instructed marks

# Create a placeholder matrix
subj_12 <- data.frame(matrix(NA, nrow= dim(teacher_export_12)[1], ncol = 12))
names(subj_12) <- c(
    "ENGW", "ENGO", # 1, 2
    "HAND",         # 3
    "PHED",         # 4
    "MATH",         # 5
    "FOOD",         # 6
    "MUSI",         # 7
    "NATS",         # 8
    "NORW", "NORO", # 9, 10
    "RELI",         # 11
    "SOCS"          # 12
)

# Copy-paste subjects that do not need merges
subj_12[, 1] <- teacher_export_subj_12[, 1] # ENGW: English (written)
subj_12[, 2] <- teacher_export_subj_12[, 2] # ENGO: English (oral)
subj_12[, 4] <- teacher_export_subj_12[, 5] # PHED: Physical education
subj_12[, 5] <- teacher_export_subj_12[, 6] # MATH: Mathematics


# Set up a progress bar
library(progress)

n_iter <- dim(teacher_export_12)[1] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

# Merge HAND
for (i in 1:n_iter) {
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12[i, 3] <- max(
        teacher_export_subj_12[i, 3],
        teacher_export_subj_12[i, 4],
        na.rm = T
    )
}
cat("\n") # Start a new line once progress bar is full

# Reset progress bar
n_iter <- dim(teacher_export_12)[1] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

# Merge FOOD
for (i in 1:n_iter) {
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12[i, 6] <- max(
        teacher_export_subj_12[i, 7],
        teacher_export_subj_12[i, 8],
        na.rm = T
    )
}
cat("\n") # Start a new line once progress bar is full

# Reset progress bar
n_iter <- dim(teacher_export_12)[1] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

# Merge MUSI
for (i in 1:n_iter) {
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12[i, 7] <- max(
        teacher_export_subj_12[i, 9],
        teacher_export_subj_12[i, 10],
        na.rm = T
    )
}
cat("\n") # Start a new line once progress bar is full

# Reset progress bar
n_iter <- dim(teacher_export_12)[1] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

# Merge NATS
for (i in 1:n_iter) {
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12[i, 8] <- max(
        teacher_export_subj_12[i, 11],
        teacher_export_subj_12[i, 12],
        na.rm = T
    )
}
cat("\n") # Start a new line once progress bar is full

# Reset progress bar
n_iter <- dim(teacher_export_12)[1] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

# Merge NORW
for (i in 1:n_iter) {
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12[i, 9] <- max(
        teacher_export_subj_12[i, 13],
        teacher_export_subj_12[i, 14],
        na.rm = T
    )
}
cat("\n") # Start a new line once progress bar is full

# Reset progress bar
n_iter <- dim(teacher_export_12)[1] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

# Merge NORO
for (i in 1:n_iter) {
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12[i, 10] <- max(
        teacher_export_subj_12[i, 15],
        teacher_export_subj_12[i, 16],
        na.rm = T
    )
}
cat("\n") # Start a new line once progress bar is full

# Reset progress bar
n_iter <- dim(teacher_export_12)[1] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

# Merge RELI
for (i in 1:n_iter) {
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12[i, 11] <- max(
        teacher_export_subj_12[i, 17],
        teacher_export_subj_12[i, 18],
        na.rm = T
    )
}
cat("\n") # Start a new line once progress bar is full

# Reset progress bar
n_iter <- dim(teacher_export_12)[1] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

# Merge SOCS
for (i in 1:n_iter) {
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12[i, 12] <- max(
        teacher_export_subj_12[i, 19],
        teacher_export_subj_12[i, 20],
        na.rm = T
    )
}
cat("\n") # Start a new line once progress bar is full

# Turn -Inf to NA column-by-column
# Create a placeholder matrix
subj_12_clean <- matrix(NA, nrow = dim(subj_12)[1], ncol = dim(subj_12)[2])
n_iter <- dim(subj_12_clean)[2] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)
for (j in 1:n_iter) { # 12 cycles
    # Insert progress bar here
    pb$tick() # Update progress bar

    subj_12_clean[, j] <- car::recode(subj_12[, j], "
        '-Inf' = NA
    ")
}
subj_12_clean <- data.frame(subj_12_clean)
names(subj_12_clean) <- names(subj_12)

# Re-order subjects
subj_12_clean <- subj_12_clean[, c(9,10,1,2,5,8,12,4,7,6,3,11)]
# New order:
#   NORW: Norwegian (written)
#   NORO: Norwegian (oral)
#   ENGW: English (wrItten)
#   ENGO: English (oral)
#   MATH: Mathematics
#   NATS: Natural Sciences
#   SOCS: Social Sciences
#   PHED: Physical Education
#   MUSI: Music
#   FOOD: Food and Health
#   HAND: Arts and Handcraft
#   RELI: Religion

# Count the number of missings for each student
missing_12 <- rowSums(is.na(subj_12_clean)) # Total number of missings
missing_7 <- rowSums(is.na(subj_12_clean[, c(1:7)])) # 7 major subjects
missing_5 <- rowSums(is.na(subj_12_clean[, c(8:12)])) # 5 minor subjects

# Stitch admin, missing counts and marks together
teacher_final <- cbind(teacher_export_12[, c(1:8)], # Admin variables
    missing_12, missing_7, missing_5,               # Missing counts
    subj_12_clean                                   # Teacher-assigned marks
)

# Save teacher_final
data.table::fwrite(teacher_final, "./Rolf/60618.csv", row.names = F)

# Keep students with 4 or more of the 7-major subjects

major_4_plus <- teacher_final[which(teacher_final$missing_7 < 4), ]
if (interactive()) {dim(major_4_plus)} # 59,517 students remain

# Compute data loss rate (n = 1,101, % = 1.82)
if (interactive()) {
    dim(teacher_final)[1] - dim(major_4_plus)[1]
    round((dim(teacher_final)[1] - dim(major_4_plus)[1]) / dim(teacher_final)[1] * 100, 2)
}

# Save major_4_plus to an external file
data.table::fwrite(major_4_plus[, -c(9:11)], "./Rolf/59517.csv", row.names = F)

# Keep students with 3 or more of the 5-minor subjects

minor_3_plus <- major_4_plus[which(major_4_plus$missing_5 < 3), ]
dim(minor_3_plus) # 57,730 students remain

# Compute data loss rate (n = 1,787, % = 3)
if (interactive()) {
    dim(major_4_plus)[1] - dim(minor_3_plus)[1]
    round((dim(major_4_plus)[1] - dim(minor_3_plus)[1]) / dim(major_4_plus)[1] * 100, 2)
}

# Save minor_3_plus to an external file
data.table::fwrite(minor_3_plus[, -c(9:11)], "./Rolf/57730.csv", row.names = F)

  #                            #  
 ###                          ### 
#####       End script       #####
