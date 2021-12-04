# Frequency of different MI packages
mi_packages <- c("Amelia", "Hmisc", "jomo", "mi", "mice", "norm", "norm2", "pan")

Amelia <- dlstats::cran_stats("Amelia")
ts_Amelia <- ts(Amelia[, 3], start = c(2016, 1), end = c(2021,12), frequency=12)
# plot(ts_Amelia)

Hmisc <- dlstats::cran_stats("Hmisc")
ts_Hmisc <- ts(Hmisc[, 3], start = c(2016, 1), end = c(2021,12), frequency=12)
# plot(ts_Hmisc)

jomo <- dlstats::cran_stats("jomo")
ts_jomo <- ts(jomo[, 3], start = c(2016, 1), end = c(2021,12), frequency=12)
# plot(ts_jomo)

mi <- dlstats::cran_stats("mi")
ts_mi <- ts(mi[, 3], start = c(2016, 1), end = c(2021,12), frequency=12)
# plot(ts_mi)

mice <- dlstats::cran_stats("mice")
ts_mice <- ts(mice[, 3], start = c(2016, 1), end = c(2021,12), frequency=12)
# plot(ts_mice)

norm <- dlstats::cran_stats("norm")
ts_norm <- ts(norm[, 3], start = c(2016, 1), end = c(2021,12), frequency=12)
# plot(ts_norm)

norm2 <- dlstats::cran_stats("norm2")
ts_norm2 <- ts(norm2[, 3], start = c(2016, 1), end = c(2021,12), frequency=12)
# plot(ts_norm2)

pan <- dlstats::cran_stats("pan")
ts_pan <- ts(pan[, 3], start = c(2016, 1), end = c(2021,12), frequency=12)
# plot(ts_pan)

popularity <- cbind(ts_Amelia, ts_Hmisc, ts_jomo, ts_mi, ts_mice, ts_norm, ts_norm2, ts_pan)
names(popularity) <- mi_packages

# Remove Hmisc (#2 position) because it is a general-purpose package
ts.plot(popularity[,-2], gpars = list(col = rainbow(ncol(popularity)-1)), lwd=4)
legend("topleft", colnames(popularity)[-2], col = 1:I(ncol(popularity) - 1), lty = 1, lwd=4)


# Import data
crime <- read.table(
    #   "https://github.com/tonyctan/Applied-Multiple-Imputation/tree/master/data/crim4.dat",
    "~/data/crim4.dat",
    row.names = 1,
    col.names = c(
        "FEMALE", "RE", "GY", "HA",
        "ACRIM", "BCRIM", "CCRIM", "DCRIM"
    ),
    colClasses = c(
        "factor", "factor", "factor", "factor",
        "numeric", "numeric", "numeric", "numeric"
    )
    na.strings = -999
)
# Add variable names
names(crime) <- c("FEMALE", "RE", "GY", "HA", "ACRIM", "BCRIM", "CCRIM", "DCRIM")
# Declare some variables as binary
crime$FEMALE <- factor(crime$FEMALE)
crime$RE <- factor(crime$RE)
crime$GY <- factor(crime$GY)
crime$HA <- factor(crime$HA)
# Summarise variables
summary(crime)

# Missing pattern
mice::md.pattern(crime, plot=F)
