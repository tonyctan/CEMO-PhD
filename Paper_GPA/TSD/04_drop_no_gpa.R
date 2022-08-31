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

# Read in gpa.xlsx:
if (!interactive()) {print("Start data loading...")}
#   Sheet 1 "STP" (teacher-assigned grades)
teacher <- readxl::read_excel("gpa.xlsx", sheet = "STP")
#   Sheet 2 "SKR" (written exam grades)
written <- readxl::read_excel("gpa.xlsx", sheet = "SKR")
#   Sheet 3 "MUN" (oral exam grades)
oral <- readxl::read_excel("gpa.xlsx", sheet = "MUN")
if (interactive()) {names(teacher)} else {print("Data loading complete.")}
# Full data set: N = 64,918

# Remove students without valid GPAs
teacher_gpa <- teacher[!is.na(teacher$GRUNNSKOLEPOENG), ]
written_gpa <- written[!is.na(written$GRUNNSKOLEPOENG), ]
oral_gpa <- oral[!is.na(oral$GRUNNSKOLEPOENG), ]
if (interactive()) {rbind(dim(teacher_gpa), dim(written_gpa), dim(oral_gpa))}
# All three spreadsheets should have 60,618 students remain

# Compute data loss rate (n = 4,300, % = 6.62)
if (interactive()) {
    dim(teacher)[1] - dim(teacher_gpa)[1]
    round((dim(teacher)[1] - dim(teacher_gpa)[1]) / dim(teacher)[1] * 100, 2)
}

# Save "the 12 subjects" including both Norwegian and Sami as instruction lang
stp <- teacher_gpa[, c(
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

# Merge Norwegian- and Sami-instructed marks

# Create a placeholder matrix
subj <- data.frame(matrix(NA, nrow= dim(stp)[1], ncol = 12))
names(subj) <- c(
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
subj[, 1] <- stp[, 1] # ENGW: English (written)
subj[, 2] <- stp[, 2] # ENGO: English (oral)
subj[, 4] <- stp[, 5] # PHED: Physical education
subj[, 5] <- stp[, 6] # MATH: Mathematics

# Set up a progress bar
library(progress)
n_iter <- dim(stp)[1] # Set the progress bar's end point
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
    subj[i, 3] <- max(stp[i, 3], stp[i, 4], na.rm = T)
}
cat("\n") # Start a new line once progress bar is full
# 18 minutes to run this loop

# Reset progress bar
n_iter <- dim(stp)[1] # Set the progress bar's end point
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
for (i in 1:n_iter) {pb$tick()
    subj[i, 6] <- max(stp[i, 7], stp[i, 8], na.rm = T)
}
cat("\n")

# Reset progress bar
n_iter <- dim(stp)[1] # Set the progress bar's end point
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
for (i in 1:n_iter) {pb$tick()
    subj[i, 7] <- max(stp[i, 9], stp[i, 10], na.rm = T)
}
cat("\n")

# Reset progress bar
n_iter <- dim(stp)[1] # Set the progress bar's end point
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
for (i in 1:n_iter) {pb$tick()
    subj[i, 8] <- max(stp[i, 11], stp[i, 12], na.rm = T)
}
cat("\n")

# Reset progress bar
n_iter <- dim(stp)[1] # Set the progress bar's end point
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
for (i in 1:n_iter) {pb$tick()
    subj[i, 9] <- max(stp[i, 13], stp[i, 14], na.rm = T)
}
cat("\n")

# Reset progress bar
n_iter <- dim(stp)[1] # Set the progress bar's end point
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
for (i in 1:n_iter) {pb$tick()
    subj[i, 10] <- max(stp[i, 15], stp[i, 16], na.rm = T)
}
cat("\n")

# Reset progress bar
n_iter <- dim(stp)[1] # Set the progress bar's end point
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
for (i in 1:n_iter) {pb$tick()
    subj[i, 11] <- max(stp[i, 17], stp[i, 18], na.rm = T)
}
cat("\n")

# Reset progress bar
n_iter <- dim(stp)[1] # Set the progress bar's end point
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
for (i in 1:n_iter) {pb$tick()
    subj[i, 12] <- max(stp[i, 19], stp[i, 20], na.rm = T)
}
cat("\n")

# Turn -Inf to NA column-by-column

# Create a placeholder matrix
subj_clean <- matrix(NA, nrow = dim(subj)[1], ncol = dim(subj)[2])

# Reset progress bar
n_iter <- dim(subj_clean)[2] # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = F,
    width = 100
)

for (j in 1:n_iter) {pb$tick()
    subj_clean[, j] <- car::recode(subj[, j], "
        '-Inf' = NA
    ")
}

subj_clean <- data.frame(subj_clean)
names(subj_clean) <- names(subj)

# Re-arrange subjects
subj_clean <- subj_clean[, c(9,10,1,2,5,8,12,11,7,3,4,6)]
# New order:
#   NORW: Written Norwegian
#   NORO: Oral Norwegian
#   ENGW: Written English
#   ENGO: Oral English
#   MATH: Mathematics
#   NATS: Natural Sciences
#   SOCS: Social Sciences
#   RELI: Religion
#   MUSI: Music
#   HAND: Arts and Handcraft
#   PHED: Physical Education
#   FOOD: Food and Health

# Stitch admin, teacher-assigned and exam grades together
gpa_final <- cbind(
    teacher_gpa[, c(1:8)],      # Admin variables
    subj_clean,                 # Teacher-assigned grades: 12 subjects
    written_gpa[, c(9,10,12)],  # Written exams: Mathematics, English, Norwegian
    oral_gpa[, c(11, 13)]       # Oral exams: English, Norwegian
)

# Save teacher_final
data.table::fwrite(gpa_final, "./Rolf/60618.csv", row.names = F)

  #                            #  
 ###                          ### 
#####       End script       #####
