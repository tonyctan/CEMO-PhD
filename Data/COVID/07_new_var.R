###### ADMIN INFO ######
# Date: 12 August 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract teacher-assigned grades

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to the COVID folder depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("N:/no-backup/COVID/")
} else {
    setwd("/tsd/p1708/data/no-backup/COVID/")
}
if (interactive()) {
    getwd()
} else {
    cat(paste0(
        "Working directory is now set to ", getwd(), "\n"
    ))
}

# Read in grades data. Show header names if interactive.
if (!interactive()) {
    print("Start data loading...")
}
math2 <- data.table::fread("06_math2.csv")
read2 <- data.table::fread("06_read2.csv")
if (interactive()) {
    names(math2)
} else {
    print("Data loading complete.")
}
names(read2)

# Create new variables

# Age
# Turn birth and cohort into yyyy-mm-dd format
birth_date <- paste0(format(math2$birth / 100, decimal.mark = "-"), "-01")
    # Thanks go to Tim for this brilliant idea!
cohort_date <- paste0(math2$cohort, "-10-01")
# Calculate period between two dates
age_math <- round(as.numeric(lubridate::as.period(lubridate::interval(
    as.Date(birth_date), as.Date(cohort_date)
)), "years"), digits = 2)

birth_date <- paste0(format(read2$birth / 100, decimal.mark = "-"), "-01")
cohort_date <- paste0(read2$cohort, "-10-01")
age_read <- round(as.numeric(lubridate::as.period(lubridate::interval(
    as.Date(birth_date), as.Date(cohort_date)
)), "years"), digits = 2)

# Turn "sex" to "girl" (male = 0; female = 1)

girl_math <- math2$sex - 1
girl_read <- read2$sex - 1

# Previous achievement (low vs high achievers)

# The authors decided to use 1 SD below mean as the cut-off for low achievers.
# We select the theoretical definition of $\mu=50$, $\sigma^2=10^2$ rather than
# the empirical mean(), sd() for our measure such that when distribution curves
# change shape, eg left tails retract, less students are classified as low ach.
ach_lo_math <- (math2$np_math8 < 40) + 0
ach_hi_math <- (math2$np_math8 > 60) + 0
ach_lo_read <- (read2$np_read8 < 40) + 0
ach_hi_read <- (read2$np_read8 > 60) + 0

# Income

# Turn blanks into NA for mother and father IDs
math2$idmo[math2$idmo == ""] <- NA
math2$idfa[math2$idfa == ""] <- NA
read2$idmo[read2$idmo == ""] <- NA
read2$idfa[read2$idfa == ""] <- NA

# Turn NA income to 0 if absent parent
# Reason: if either parent is missing, we recode their income as 0
# so that no MI is needed for this entry later.
# Conversely, if parent is present (parent ID available) but income is missing,
# we mark their income as NA so that MI can be applied later.
math2$atipcu_mo <- ifelse(is.na(math2$idmo),
    car::recode(math2$atipcu_mo, "NA = 0"),
    math2$atipcu_mo
)
math2$atipcu_fa <- ifelse(is.na(math2$idfa),
    car::recode(math2$atipcu_fa, "NA = 0"),
    math2$atipcu_fa
)
read2$atipcu_mo <- ifelse(is.na(read2$idmo),
    car::recode(read2$atipcu_mo, "NA = 0"),
    read2$atipcu_mo
)
read2$atipcu_fa <- ifelse(is.na(read2$idfa),
    car::recode(read2$atipcu_fa, "NA = 0"),
    read2$atipcu_fa
)

# Sum mother's and father's income
atipcu_math <- ifelse(is.na(math2$atipcu_mo) & is.na(math2$atipcu_fa),
    NA,
    rowSums(cbind(math2$atipcu_mo, math2$atipcu_fa), na.rm = TRUE)
)
atipcu_read <- ifelse(is.na(read2$atipcu_mo) & is.na(read2$atipcu_fa),
    NA,
    rowSums(cbind(read2$atipcu_mo, read2$atipcu_fa), na.rm = TRUE)
)

# Transform income data

# 1. Invalidate negative incomes as NA
atipcu_math_pos <- ifelse(atipcu_math <= 0, NA, atipcu_math)
atipcu_read_pos <- ifelse(atipcu_read <= 0, NA, atipcu_read)
# 2. Log-transform income
atipcu_math_log <- log(atipcu_math_pos)
atipcu_read_log <- log(atipcu_read_pos)
# 3. z-standardisation
atipcu_math_scale <- scale(atipcu_math_log)
atipcu_read_scale <- scale(atipcu_read_log)

# Compute learning growths
delta_np_math <- math3$np_math9 - math3$np_math8
delta_np_read <- read3$np_read9 - read3$np_read8

### MATH ###

# Stitch new variables onto existing spreadsheet
math3 <- cbind(math2,
    age_math, girl_math,
    ach_lo_math, ach_hi_math,
    atipcu_math_pos, atipcu_math_log, atipcu_math_scale,
    delta_np_math
)
names(math3)[25] <- "atipcu_math_scale"

# Re-arrange the columns
math3 <- math3[, c(
    "idper",
    "cohort", "condition1",
    "sex", "age_math",
    "ach_lo_math", "ach_hi_math",
    "atipcu_math_pos", "atipcu_math_log", "atipcu_math_scale",
    "idmo", "idfa",
    "idsc8", "idsc9",
    "scmu8", "scmu9",
    "types8", "types9",
    "partst8", "partst9",
    "np_math8", "np_math9"
)]

# Re-name the columns
names(math3) <- c(
    "idper",
    "cohort", "condition1",
    "sex", "age",
    "ach_lo", "ach_hi",
    "atipcu_pos", "atipcu_log", "atipcu_scale",
    "idmo", "idfa",
    "idsc8", "idsc9",
    "scmu8", "scmu9",
    "types8", "types9",
    "partst8", "partst9",
    "np_math8", "np_math9"
)

### READ ###

# Stitch new variables onto existing spreadsheet
read3 <- cbind(read2,
    age_read,
    ach_lo_read, ach_hi_read,
    atipcu_read_pos, atipcu_read_log, atipcu_read_scale
)
names(read3)[25] <- "atipcu_read_scale"

# Re-arrange the columns
read3 <- read3[, c(
    "idper",
    "cohort", "condition1",
    "sex", "age_read",
    "ach_lo_read", "ach_hi_read",
    "atipcu_read_pos", "atipcu_read_log", "atipcu_read_scale",
    "idmo", "idfa",
    "idsc8", "idsc9",
    "scmu8", "scmu9",
    "types8", "types9",
    "partst8", "partst9",
    "np_read8", "np_read9"
)]

# Re-name the columns
names(read3) <- c(
    "idper",
    "cohort", "condition1",
    "sex", "age",
    "ach_lo", "ach_hi",
    "atipcu_pos", "atipcu_log", "atipcu_scale",
    "idmo", "idfa",
    "idsc8", "idsc9",
    "scmu8", "scmu9",
    "types8", "types9",
    "partst8", "partst9",
    "np_read8", "np_read9"
)

# Save math3 and read3 to M Drive
data.table::fwrite(math3, "07_math3.csv")
data.table::fwrite(read3, "07_read3.csv")

  #                            #  
 ###                          ### 
#####       End script       #####
