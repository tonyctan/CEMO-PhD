##### Housekeeping #####

# library(MASS) # For mvrnorm()
# library(rockchalk) # For lazyCor()
# library(Matrix) # For forceSymmetric()
# library(matrixcalc) # For is.positive.definite()
# library(MBESS) # For cor2cov()
# library(mirt) # For IRT
# library(scales) for rescale()

set.seed(1234)

##### GPA subject setup #####

n_subj = 6 # Number of GPA subjects I want to simulate
mat_empty <- matrix(NA, ncol = n_subj, nrow = n_subj) # Create an empty matrix

# Give GPA subjects names for concreteness
subj = c(
    "Mathematics", "Physics", "Chemistry", "Biology",
    "Norwegian", "English"
)

# Nominate average achievement for each GPA subject
mean = c(4.5, 4, 4.25, 5, 5.25, 5) # dim = n_subj

# Nominate standard deviations of the GPA subjects
sd <- c(2, 3, 2.5, 2.75, 3.5, 2.5) # dim = n_subj

# Nominate a correlation matrix
mat_empty[upper.tri(mat_empty, diag = T)] <- c(
    1,
    .8, 1,
    .75, .85, 1,
    .7, .65, .9, 1,
    .2, .1, .13, .3, 1,
    .3, .25, .2, .3, .75, 1#,
    # .3, .6, .5, .6, .7, .75, 1,
    # .6, .7, .65, .6, .5, .55, .45, 1
)
# Turn triangular matrix to full
cor <- Matrix::forceSymmetric(mat_empty, uplo = "U")
# Change property back to matrix
cor <- data.matrix(cor)
# Test whether positive definite
matrixcalc::is.positive.definite(cor)
# Turn correlation matrix to covariance matrix
cov <- MBESS::cor2cov(cor, sd)
# Turn variances to standard deviations
sigma <- sqrt(cov)

##### Ideal matrix #####

# Generate an ideal matrix Y
ideal <- MASS::mvrnorm(n = 10000, mu = mean, Sigma = sigma, empirical = F)
# Turn to data frame
ideal <- data.frame(ideal)
# Add names to variables
names(ideal) <- subj
# Inspect Y
ideal[c(1:50), ]
# Summarise Y
summary(ideal)
# Visualise distribution of Y
par(mfrow = c(2, 3))
for (i in 1:6) {
    hist(ideal[, i],
        xlim = c(-1, 12), ylim = c(0, 0.3),
        main = subj[i], xlab = "GPA", ylab = ""
        freq = F
    )
}

# Rescale to [0,5] six categories

ideal_mathematics <- scales::rescale(ideal[, 1],
    from = c(min(ideal[, 1]), max(ideal[, 1])),
        to = c(0,5)
    )

irt_ideal <- mirt::mirt(ideal[,1], 1, verbose = F, itemtype = "graded", SE = T)
summary(irt_ideal[])
