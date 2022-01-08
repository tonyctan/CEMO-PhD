################################
##### Slide 1 Data Import ######
################################

setwd("~/uio/pc/Dokumenter/PhD/Teaching/UseR/Missing Data/")

# Import German youth delinquency data
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
# Draw 20 sub-samples
sub_crime <- crime[sample(row.names(crime), size = 20, replace = F), ]
# Display sub-sample sorted by ID
sub_crime[order(as.numeric(row.names(sub_crime))), ]

# Source:
# This demo is adapted from Chapter 5 of
# Kleinke, K., Reinecke, J., Salfran, D., & Spiess, M. (2020). Applied multiple imputation: Advantages, pitfalls, new developments and application in R. Springer. pp. 133--217.

# Data set:
# The main dataset crim4.dat is further adapted from the "Crime in the modern city" (CrimoC) study, reported in detail by Boers, Reinecke, Sedding, & Mariotti (2010), and by Reinecke & Weins (2013).
# The CrimoC study examined the emergence and development of juvenile delinquency over time in adolescence.
# Data were collected from schools in the German city of Munster (with 275,000 inhabitants), starting in 2000 (Wave A), with a sample of about 3,400 seventh-graders, interviewed annually, until they reach Grade 10.
# The average age of participants at Wave 1 was 13 years. Detailed descrition of this data set can be found in Reinecke & Weins (2013).
# For demo purposes: N = 2,064, T = 4 (three or more missings were excluded)

# The variables:
#   id          the participant identifier
#   FEMALE      the gender indicator
#   GY          school type indicator "Gymnasium" (Grade 12 / 13, -> university)
#   RE          school type indicator "Realschule" (Grade 10, intermediate)
#   HA          school type indicator "Hauptschule" (-> vocational education)
#   ACRIM       delinquency score at Wave A (Grade 7, age 13, year 2000)
#   BCRIM       delinquency score at Wave B (Grade 8, age 14, 2001)
#   CCRIM       delinquency score at Wave C (Grade 9, age 15, 2002)
#   DCRIM       delinquency score at Wave D (Grade 10, age 16, 2003)

# Delinquency scores:
# Data were collected via self-administered classroom interviews.
# Delinquency was measured with 16 questions to get the prevalences of various offences like burglary or assault with or without a weapon (see Table 8, Reinecke & Weins (2013) for details).
# Students indicated for each offence: if they had committed this delinquent behaviour in the 12 months prior to the interview (1 = yes; 0 = no).
# Variable ACRIM--DCRIM can range between 0 and 16, with higher values indicating a more versatile criminal activity.

# Research questions:
# Age-crime-curve: a curviliniear development of delinquency over time.
# More specifically, the means of each wave were expected to increase until around the age of 15, and to decrease thereafter (Moffitt, 1993).
# Interested in both the curves, but also the effects of gender and school type on the age-crime relationship.

# Findings:
# Both gender and school type predicted individual differences in the development of delinquent behaviours over time.
# Higher prevalence of delinquent behaviour: boys and HA attendees





####################################
##### Slide 2 Data Inspection ######
####################################

# Distribution of delinquency scores
par(mfrow = c(2, 2)) # Fit four histograms on one page
for (i in 5:8) {
    hist(crime[, i],
        freq = F,
        xlab = "Delinquency Score", ylab = "Relative Frequency",
        xlim = c(0, 16), ylim = c(0, 0.9),
        main = names(crime)[i]
    )
}
par(mfrow = c(1, 1)) # Restore canvas
# Distribution of delinquency scores appeared to be heavily skewed in all four waves with large percentages of zero counts.
# The non-normal distributions of delinquency scores conditional on predictor variables need to be taken into account when choosing a suitable imputation and data analysis model.

# Inspect number of missings
mis_ind <- is.na(crime) # Create a missing indicator
(mis_count <- colSums(mis_ind)) # Absolute count
round(mis_count / dim(crime)[1] * 100, 2) # Percentage count
# Complete cases (%)
round(sum(complete.cases(crime)) / dim(crime)[1] * 100, digits = 2)
# Gender and school type indicators are completely observed.
# Only 39.39% of all the cases were fully observed.
# Complete-case analyses: hugely wasteful and likely biased if not MCAR (which, the authors argued missings unlikely to be MCAR: missing data are overproportionally male, attending HA)

# Inspect missing patterns
mis_pat <- mice::md.pattern(crime[, -c(1:4)], plot = F)
# Sort columns from A to D and rows by number of missings
mis_pat <- mis_pat[order(mis_pat[, 5]), c(4, 2, 1, 3, 5)]
# Count number of cases with only 1 or 2 missings:
sum(as.numeric(row.names(mis_pat)[2:11])) # 1 full obs; #12 NA placeholder
# There are 1251 respondents with only one or two panel waves missing.
# Since these repeated measurements were not independent, it is plausible that missing information at one or two panel waves can be predicted by the observed delinquency at other time points.
# Cases with three or more missing waves are excluded from this data set.

# Calculate "useable cases"
mice::md.pairs(crime)$mr # Absolute count (mr = 1st missing; 2nd remain)
round(
    mice::md.pairs(crime[, c(5:8)])$mr / colSums(is.na(crime[, c(5:8)])),
    digits = 2
) # Percentage count

# Margin plot
pdf("margin_plot.pdf", width = 20, height = 20)
par(mfrow = c(4, 4))
for (j in 5:8) {
    for (i in 5:8) {
        VIM::marginplot(crime[, c(j, i)],
            xlim = c(0, 16), ylim = c(0, 16),
            col = c("blue", "red"), # observed = blue; missing = red
            cex = 1.2, cex.lab = 1.2, cex.numbers = 1.3, pch = 19
        )
    }
}
par(mfrow = c(1, 1))
dev.off()


########################################
##### Slide 3 Growth Curve Models ######
########################################

# Based on criminology theory and prior research, a growth curve model is appropriate for this youth delinquency study.
# Since the data are counts, it is more plausible to assume a Poisson or negative binomial distribution of the delinquency scores rather than a normal model.
# As the distribution of the scores is highly skewed, a zero-inflated Poisson (ZIP) growth curve model is used to model the age-crime curve.




# Identify auxiliary variables
# Generate a correlation table
aux_cor <- cor(data.matrix(crime), use = "pairwise.complete.obs")
round(aux_cor, digits = 2)
# Visualise correlations
corrplot::corrplot.mixed(
    aux_cor,
    lower = "number", upper = "ellipse",
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
# Drop HA since it is the reference group label. Rearrange the columns.
crime_mi <- crime[, c("ACRIM", "BCRIM", "CCRIM", "DCRIM", "FEMALE", "RE", "GY")]
# Do an initial run (maxit := do not run any iterations of Gibbs sampler)
mi_init <- mice::mice(crime_mi, maxit = 0)
# Extract method and predictor matrix
mi_init$method # I am happy with the result, so I save it:
mi_meth <- mi_init$method
mi_init$predictorMatrix
# I am not happy with the bottom 3 rows. They should be 0 because no missings.
mi_init$predictorMatrix[c(5:7), ] <- matrix(0, nrow = 3, ncol = 7)
(mi_pred_mat <- mi_init$predictorMatrix) # Now I am happy.

mi_test <- mice::mice(
    crime_mi,
    m = 5, # Default = 5
    method = mi_meth,
    predictorMatrix = mi_pred_mat,
    maxit = 20, # Default = 5
    seed = 1234
)

# Check chain convergence
pdf("spaghetti_test.pdf", width = 20, height = 20)
plot(mi_test, layout = c(2, 4)) # Layout: c(column, row)
dev.off()

# Check plausibility of imputed data
pdf("strip_test.pdf", width = 20, height = 20)
mice::stripplot(mi_test,
    ylim = c(0, 16),
    pch = 20, cex = 1.2
)
dev.off()
# Horizontal: 0 = reference (obs only); 1--5 imputation number
# Blue = observed; red = imputed

pdf("xyplot_test.pdf", width = 20, height = 20)
lattice::xyplot(mi_test, ACRIM ~ BCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)
lattice::xyplot(mi_test, ACRIM ~ CCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)
lattice::xyplot(mi_test, ACRIM ~ DCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)

lattice::xyplot(mi_test, BCRIM ~ ACRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)
lattice::xyplot(mi_test, BCRIM ~ CCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4)
lattice::xyplot(mi_test, BCRIM ~ DCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)

lattice::xyplot(mi_test, CCRIM ~ ACRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)
lattice::xyplot(mi_test, CCRIM ~ BCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)
lattice::xyplot(mi_test, CCRIM ~ DCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)

lattice::xyplot(mi_test, DCRIM ~ ACRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)
lattice::xyplot(mi_test, DCRIM ~ BCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)
lattice::xyplot(mi_test, DCRIM ~ CCRIM | .imp,
    xlim=c(-1, 17), ylim=c(-1, 17),
    pch = 20, cex = 1.4
)
dev.off()

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
    donors = 5, # Default = 5
    print = F,
    seed = 1234
)
mi_pmm20 <- mice(
    crime_mi,
    m = 100,
    predictorMatrix = mi_pred_mat,
    maxit = 20,
    donors = 20,
    print = F,
    seed = 1234
)

plot(mi_pmm1, layout = c(2, 4))
plot(mi_pmm5, layout = c(2, 4))
plot(mi_pmm20, layout = c(2, 4))