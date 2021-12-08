# Frequency of different MI packages
mi_packages <- c("Amelia", "Hmisc", "jomo", "mi", "mice", "norm", "norm2", "pan")

Amelia <- dlstats::cran_stats("Amelia")
ts_Amelia <- ts(Amelia[, 3], start = c(2016, 1), end = c(2021, 12), frequency = 12)
# plot(ts_Amelia)

Hmisc <- dlstats::cran_stats("Hmisc")
ts_Hmisc <- ts(Hmisc[, 3], start = c(2016, 1), end = c(2021, 12), frequency = 12)
# plot(ts_Hmisc)

jomo <- dlstats::cran_stats("jomo")
ts_jomo <- ts(jomo[, 3], start = c(2016, 1), end = c(2021, 12), frequency = 12)
# plot(ts_jomo)

mi <- dlstats::cran_stats("mi")
ts_mi <- ts(mi[, 3], start = c(2016, 1), end = c(2021, 12), frequency = 12)
# plot(ts_mi)

mice <- dlstats::cran_stats("mice")
ts_mice <- ts(mice[, 3], start = c(2016, 1), end = c(2021, 12), frequency = 12)
# plot(ts_mice)

norm <- dlstats::cran_stats("norm")
ts_norm <- ts(norm[, 3], start = c(2016, 1), end = c(2021, 12), frequency = 12)
# plot(ts_norm)

norm2 <- dlstats::cran_stats("norm2")
ts_norm2 <- ts(norm2[, 3], start = c(2016, 1), end = c(2021, 12), frequency = 12)
# plot(ts_norm2)

pan <- dlstats::cran_stats("pan")
ts_pan <- ts(pan[, 3], start = c(2016, 1), end = c(2021, 12), frequency = 12)
# plot(ts_pan)

popularity <- cbind(ts_Amelia, ts_Hmisc, ts_jomo, ts_mi, ts_mice, ts_norm, ts_norm2, ts_pan)
names(popularity) <- mi_packages

# Remove Hmisc (#2 position) because it is a general-purpose package
ts.plot(popularity[, -2], gpars = list(col = rainbow(ncol(popularity) - 1)), lwd = 4)
legend("topleft", colnames(popularity)[-2], col = 1:I(ncol(popularity) - 1), lty = 1, lwd = 4)


# Import data
crime <- read.table(
    "https://raw.githubusercontent.com/tonyctan/Applied-Multiple-Imputation/master/data/crim4.dat",
    #    "~/data/crim4.dat",
    row.names = 1,
    col.names = c(
        "id", "FEMALE", "RE", "GY", "HA",
        "ACRIM", "BCRIM", "CCRIM", "DCRIM"
    ),
    colClasses = c(
        "numeric", "factor", "factor", "factor", "factor",
        "numeric", "numeric", "numeric", "numeric"
    ),
    na.strings = -999
)

# Count the missings
mis_ind <- is.na(crime)
mis_count <- colSums(mis_ind) # Absolute count
round(mis_count / dim(crime)[1] * 100, 2) # Percentage count

# Missing pattern
mis_pat <- mice::md.pattern(crime[, -c(1:4)], plot = F)
# Sort columns from A to D and rows by number of missings
mis_pat[order(mis_pat[, 5]), c(4, 2, 1, 3, 5)]

# Useable cases
mice::md.pairs(crime)$mr # Absolute count
round(
    mice::md.pairs(crime[, c(5:8)])$mr / colSums(is.na(crime[, c(5:8)])),
    digits = 2
) # Percentage count

# Identify auxiliary variables
# Generate a correlation table
aux_cor <- cor(data.matrix(crime), use = "pairwise.complete.obs")
round(aux_cor, digits = 2)
# Visualise correlations
corrplot::corrplot.mixed(
    aux_cor,
    lower="number", upper="ellipse",
    order = "original"
)

# Give missing indicator matrix a header
colnames(mis_ind) <- paste("R.", colnames(crime), sep = "")
# Stitch missing indicators and original data set
crime_aug <- data.frame(mis_ind, crime)
# Correlate missing indicators with repeated-measure delinquency scores
round(
    cor(
        crime_aug[, 5:8], data.matrix(crime_aug[, 9:16]),
        use = "pairwise.complete.obs"
    ),
    digits = 2
)
# Observations: FEMALE slightly less likely missing, so are GY
# Non-zero correlations imply deviation from MCAR.
# Missing delinquency +~ with observe delinquency in other period
# Failing to take this into consideration could shift towards MNAR.

# Multiple imputation using MICE
library(mice)
# Drop HA since it is the reference group label. Rearrange the columns.
crime_mi <- crime[, c("ACRIM", "BCRIM", "CCRIM", "DCRIM", "FEMALE", "RE", "GY")]
# Do an initial run (maxit := do not run any iterations of Gibbs sampler)
mi_init <- mice(crime_mi, maxit = 0)
# Extract method and predictor matrix
mi_init$method # I am happy with the result, so I save it:
mi_meth <- mi_init$method
mi_init$predictorMatrix
# I am not happy with the bottom 3 rows. They should be 0 because no missings.
mi_init$predictorMatrix[c(5:7),] <- matrix(0,nrow=3,ncol=7)
(mi_pred_mat <- mi_init$predictorMatrix) # Now I am happy.

mi_test <- mice(
    crime_mi,
    m = 5, # Default = 5
    method = mi_meth,
    predictorMatrix = mi_pred_mat,
    maxit = 20, # Default = 5
    seed = 1234
)
plot(mi_test, layout = c(2, 4)) # Layout: c(column, row)

mi_pmm1 <- mice(
    crime_mi,
    m = 100,
    predictorMatrix = mi_pred_mat,
    maxit = 20,
    donors = 1,
    print = F,
    seed = 1234
)
mi_pmm5 <- mice(
    crime_mi,
    m = 100,
    predictorMatrix = mi_pred_mat,
    maxit = 20,
    donors=5, # Default = 5
    print = F,
    seed = 1234
)
mi_pmm20 <- mice(
    crime_mi,
    m=100,
    predictorMatrix = mi_pred_mat,
    maxit=20,
    donors=20,
    print=F,
    seed=1234
)

plot(mi_pmm1, layout = c(2,4))
plot(mi_pmm5, layout = c(2,4))
plot(mi_pmm20, layout = c(2,4))
