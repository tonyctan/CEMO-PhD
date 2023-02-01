# Either, set working directory from default folder (PhD folder)
setwd(
    paste0(
        noquote(getwd()), # PhD folder
        "/Teaching/MAE4011_Principle_of_Measures/Labs" # Extension
    )
)

# Or, set working directory by typing the full path
setwd("~/uio/pc/Dokumenter/PhD/Teaching/MAE4011_Principle_of_Measures/Labs")

# Install lavaan and psych package if not done so
# install.packages(c("lavaan", "psych"), dependencies = TRUE)

# Read in datasets and conduct an audit

likert <- readRDS("likert_data.rds")
# Inspect data: Apply unique() function to likert dataset by column
apply(likert, 2, unique)
# Recode 9999 to NA
likert[likert == 9999] <- NA
# Inspect data again
apply(likert, 2, unique)

dich <- readRDS("dich_data.rds")
# Inspect data
apply(dich, 2, unique)
# No action needed





# Task 1: Correlation

# Correlation between two variables (teaching_1 and teaching_2)
cor(
    likert[, 1], likert[, 2],
    use = "pairwise.complete.obs"
)

# Save correlation matrix
write.csv(
    cor(likert, use = "pairwise.complete.obs"),
    "cor_likert.csv"
)





# Task 2: Test reliability

sum_score_1 <- apply(dich[, 3:22], 1, sum)
sum_score_2 <- apply(dich[, 23:42], 1, sum)

# Correlation between Test 1 and Test 2
cor(sum_score_1, sum_score_2)

# Internal reliability: Coefficient alpha

# Dichotomous items
# Calculate alpha using the first 20 items
psych::alpha(dich[, 3:22])[1]
# Calculate alpha using the last 20 items
psych::alpha(dich[, 23:42])[1]
# Calculate alpha using all the items
psych::alpha(dich[, 3:42])[1]

# Likert scale items
# Calculate alpha
psych::alpha(likert[, 1:10])[1]





# Task 3: Single factor model

# Model specification
lat_var_teach <- "
    f =~ teaching_1 + teaching_2 + teaching_3 + teaching_4 + teaching_5 +
    teaching_6 + teaching_7 + teaching_8 + teaching_9 + teaching_10
"

# Model estimation
cfa_teach <- lavaan::cfa(lat_var_teach, data = likert)

# Model summary
lavaan::summary(cfa_teach)

# Model coefficients
par_teach <- c(lavaan::coef(cfa_teach))

# Coefficient omega: Manual calculation
lambda_teach <- c(1, par_teach[1:9])
psi2_teach <- par_teach[10:19]
omega_teach <- sum(lambda_teach)^2 / (sum(lambda_teach)^2 + sum(psi2_teach))
omega_teach





# Task 4: Standardised model

# Estimate a standardised model
cfa_teach_std <- lavaan::cfa(lat_var_teach, likert, std.lv = TRUE)

# Model summary
lavaan::summary(cfa_teach_std)

# Model coefficients
par_teach_std <- c(lavaan::coef(cfa_teach_std))

# Vector: factor loadings
lambda_teach_std <- par_teach_std[1:10]
# Vector: unique variance
psi2_teach_std <- par_teach_std[11:20]

# Calculate the omega coefficient
omega_std <- sum(lambda_teach_std)^2 /
    (sum(lambda_teach_std)^2 + sum(psi2_teach_std))
omega_std

# Compare alpha and omega
psych::alpha(likert[, 1:10])[1]
omega_std
