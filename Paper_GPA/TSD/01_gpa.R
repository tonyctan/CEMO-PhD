###### ADMIN INFO ######
# Date: 24 April 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract additional education record (mainly GPA, GRUNNSKOLEPOENG, from File seq = 4) based on Student ID list (that was derived from File seq = 157)

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
###                          ###
#                            #



# Step 1: Extract 2019 education record (File seq = 4)

# Point working directory to registry data folder, depending on OS
if (Sys.info()["sysname"] == "Linux") {
    setwd("/tsd/p1708/data/durable/data/registers")
} else {
    setwd("N:/durable/data/registers")
}

# Read in W21_4952_F_UTD_KURS.csv
gpa <- data.table::fread("W21_4952_F_UTD_KURS.csv")

# Immediately change working directory to personal space
if (Sys.info()["sysname"] == "Linux") {
    setwd("/tsd/p1708/home/p1708-tctan/Documents/Paper_GPA")
} else {
    setwd("M:/p1708-tctan/Documents/Paper_GPA")
}

# Only keep 2019 June data
gpa2019 <- gpa[which(gpa$AVGDATO == 201906), c(1:4, 32, 8)]
# Column 1: w21_4952_lopenr_person
# Column 2: lopenr_orgnr
# Column 3: lopenr_orgnrbed
# Column 4: w21_4952_inr_inr
# Column 32: GRUNNSKOLEPOENG (GPA)
# Column 8: AVGDATO (record date)

# Inspect GRUNNSKOLEPOENG
table(unlist(gpa2019$GRUNNSKOLEPOENG))
# GPA = 0 signals invalid GPA [n = 6295]. Recode 0 to NA
gpa2019$GRUNNSKOLEPOENG <- car::recode(gpa2019$GRUNNSKOLEPOENG, "
    0 = NA
")

# Visualise the distribution of GRUNNSKOLEPOENG
pdf("./figures/GPA_2019.pdf")
    hist(gpa2019$GRUNNSKOLEPOENG,
        freq = FALSE,
        xlim = c(0, 70), xlab = "GPA",
        ylim = c(0, 0.05), ylab = "Relative Frequency",
        main = "Distribution of 2019 GPA",
    )
    lines(
        density(gpa2019$GRUNNSKOLEPOENG, na.rm = TRUE),
        col = "blue", lwd = 2
    )
dev.off()



# Step 2: Extract GPA based on Student ID list (made form File seq = 157)

student_id <- data.table::fread(
    "./data/00_student_id.csv",
    header = TRUE
)

student_id <- unlist(student_id) # Otherwise length(...) = 1, which is wrong

# Create a placeholder matrix
temp <- data.frame(
    matrix(NA, nrow = length(student_id), ncol = dim(gpa2019)[2])
)
colnames(temp) <- c(names(gpa2019))

# Set up a progress bar
library(progress)
n_iter <- length(student_id) # Set the progress bar's end point
pb <- progress_bar$new( # Refresh progress bar's internal definition
    format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = n_iter,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = FALSE,
    width = 100
)

# Fill this placeholder matrix with matching results
for (i in 1:n_iter) { # Go through the Student ID list:
    # Insert progress bar here
    pb$tick()

    # Test if there is any match
    test <- gpa2019$w21_4952_lopenr_person == student_id[i]
    test <- test + 0 # Turn FALSE/TRUE into 0/1
    test_result <- sum(test) # If a match is found, sum > 0

    # If no match is found, record student ID in Column 1 of "temp",
    # leave the rest of the columns untouched, and move to the next student
    if (test_result == 0) {
        temp[i, 1] <- student_id[i]
    } else {
        # If a match is found
        temp[i, ] <- data.frame(
            gpa2019[which(gpa2019$w21_4952_lopenr_person == student_id[i]), ]
        )
    }
}

data.table::fwrite(temp, "./data/01_gpa.csv", row.names = FALSE)
# File size 3053 KB

  #                            #  
 ###                          ### 
#####       End script       #####
