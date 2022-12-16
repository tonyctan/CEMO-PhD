###### ADMIN INFO ######
# Date: 19 Feb 2023
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Missing data treatment using multiple imputation

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
###                          ###
#                            #


# Point working directory to the GPA paper folder depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("M:/p1708-tctan/Documents/Paper_GPA/")
} else {
    setwd("/tsd/p1708/home/p1708-tctan/Documents/Paper_GPA")
}

if (interactive()) {
    getwd()
} else {
    cat(paste0(
        "Working directory is now set to ", getwd(), "\n"
    ))
}

# Read in clean GPA data
if (!interactive()) {
    print("Start data loading...")
}
gpa <- data.table::fread("./data/04_gpa_out.csv")
if (interactive()) {
    names(gpa)
} else {
    print("Data loading complete.")
}
if (interactive()) {
    dim(gpa)
}

# Save subjects' codes and names
subj_code <- names(gpa)[-c(1:8)]
subj_name <- c(
    "Written Norwegian",
    "Oral Norwegian",
    "Written English",
    "Oral English",
    "Mathematics",
    "Natural Sciences",
    "Social Sciences",
    "Religion",
    "Music",
    "Arts and Handcraft",
    "Physical Education",
    "Food and Health",
    "Mathematics (written exam)",
    "English (written exam)",
    "Norwegian (written exam)",
    "English (oral exam)",
    "Norwegian (oral exam)"
)

# For some reason, only missing values in numeric columns are correctly
# shown as NA; missing info in text column are shown as blanks. This
# inconsistent coding will confuse mice. Solution: Manually recode blank
# cells in the text columns as NA to hold the place:
gpa[, c("w21_4952_lopenr_orgnr", "lopenr_orgnr", "lopenr_orgnrbed")] <- noquote(
    data.frame(apply(
        gpa[, c("w21_4952_lopenr_orgnr", "lopenr_orgnr", "lopenr_orgnrbed")],
        2, # 1 = by row; 2 = by column
        function(x) gsub("^$|^ $", "NA", x) # substitute empty space with NA
    ))
)

# Generate the predictor matrix
pred_gpa <- matrix(
    c(
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    ),
    nrow=ncol(gpa), ncol=ncol(gpa)
)

# Give predictor matrix row- and column-names
dimnames(pred_gpa) <- list(
    names(gpa),
    names(gpa)
)

# Apply MI to GPA data
mi_gpa <- mice::mice(
    seed = 2023,
    data = gpa,
    m = 10,
    method = c(
        "", "", "", "", "", "", "", "", # Admin variables
        "pmm", "pmm", "pmm", "pmm", "pmm", # 17 subjects
        "pmm", "pmm", "pmm", "pmm", "pmm",
        "pmm", "pmm", "pmm", "pmm", "pmm",
        "pmm", "pmm"
    ),
    predictorMatrix = pred_gpa,
    remove.collinear = FALSE, # Otherwise mice will drop oral English
    print = FALSE
)

# Save the 10 copies of MI result
miceadds::write.mice.imputation(
    mi.res = mi_gpa,
    name = "05_mi",
    include.varnames = TRUE,
    long = FALSE,
    mids2spss = FALSE
)
