###### ADMIN INFO ######
# Date: 03 May 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: IRT analysis of subject difficulties

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

# Set up some bookshelves to receive IRT results

# Difficulty thresholds
pcm_par_holder <- matrix(NA,
    nrow = 5 * (12 + 3 + 2),    # 5 parameters each, 17 subjects
    ncol = 10                   # 10 multiple imputed datasets
)
pcm_SE_holder <- matrix(NA,
    nrow = 5 * (12 + 3 + 2), # 5 parameters each, 17 subjects
    ncol = 10 # 10 multiple imputed datasets
)

# Model fit statistics
pcm_outfit_holder <- matrix(NA, nrow = 17, ncol = 10)
pcm_zoutfit_holder <- matrix(NA, nrow = 17, ncol = 10)
pcm_infit_holder <- matrix(NA, nrow = 17, ncol = 10)
pcm_zinfit_holder <- matrix(NA, nrow = 17, ncol = 10)

# Expected item value
pcm_expected_holder <- matrix(NA, nrow = 17, ncol = 10)

# Iterate PCM over 10 multiple imputed datasets
for (k in 1:10) {
    # Read in one MI dataset at a time
    gpa <- data.table::fread(paste0(
        "./05_mi/05_mi__IMPDATA",
        k,
        ".dat"
    ))
    # Run partial credit model (PCM)
    pcm <- mirt::mirt(gpa[, c(9:25)],
        itemtype = "Rasch", SE = TRUE
    )

    # Extract PCM coefficients
    pcm_coef <- mirt::coef(pcm,
        printSE = TRUE, IRTpars = TRUE, as.data.frame = TRUE
    )
    # Remove GroupPars (the last 2 rows)
    pcm_coef <- pcm_coef[-c(nrow(pcm_coef), nrow(pcm_coef) - 1), ]
    # Remove IRT discrimination parameter because they all equal to 1
    pcm_coef <- pcm_coef[-c(seq(1, 97, 6)), ]
    # Save par and SE
    pcm_par_holder[, k] <- pcm_coef[, 1]
    pcm_SE_holder[, k] <- pcm_coef[, 2]

    # Extract model fit statistics
    pcm_fit <- mirt::itemfit(pcm, fit_stats = "infit")
    pcm_outfit_holder[, k] <- pcm_fit[, 2]
    pcm_zoutfit_holder[, k] <- pcm_fit[, 3]
    pcm_infit_holder[, k] <- pcm_fit[, 4]
    pcm_zinfit_holder[, k] <- pcm_fit[, 5]

    # Extract expected item value for an average student (theta = 0)
    for (i in 1:17) {
        pcm_expected_holder[i, k] <- mirt::expected.item(
            mirt::extract.item(pcm, i),
            Theta = 0 # The average student
        )
    }
}

# Save bookshelves to CSV
data.table::fwrite(
    data.table(pcm_par_holder),
    "./data/11_pcm_par_holder.csv"
)
data.table::fwrite(
    data.table(pcm_SE_holder),
    "./data/11_pcm_SE_holder.csv"
)
data.table::fwrite(
    data.table(pcm_outfit_holder),
    "./data/11_pcm_outfit_holder.csv"
)
data.table::fwrite(
    data.table(pcm_zoutfit_holder),
    "./data/11_pcm_zoutfit_holder.csv"
)
data.table::fwrite(
    data.table(pcm_infit_holder),
    "./data/11_pcm_infit_holder.csv"
)
data.table::fwrite(
    data.table(pcm_zinfit_holder),
    "./data/11_pcm_zinfit_holder.csv"
)
data.table::fwrite(
    data.table(pcm_expected_holder),
    "./data/11_pcm_expected.csv"
)

# Transform IRT result matrix to list form
pcm_par_holder <- lapply(
    seq_len(ncol(pcm_par_holder)),
    function(i) pcm_par_holder[, i]
)
pcm_SE_holder <- lapply(
    seq_len(ncol(pcm_SE_holder)),
    function(i) pcm_SE_holder[, i]
)
# Pull 10 MI results together using Rubin's Rule
pcm_mi <- mirt::averageMI(pcm_par_holder, pcm_SE_holder)

data.table::fwrite(data.table(
    matrix(pcm_mi[, 1],
        nrow = 12 + 3 + 2,
        ncol = 5,
        byrow = TRUE
    )),
    "./data/11_pcm_mi_par.csv",
    row.names=F, col.names = FALSE
)
data.table::fwrite(data.table(
    matrix(pcm_mi[, 2],
        nrow = 12 + 3 + 2,
        ncol = 5,
        byrow = TRUE
    )),
    "./data/11_pcm_mi_SE.csv",
    row.names=F, col.names = FALSE
)

  #                            #  
 ###                          ### 
#####       End script       #####
