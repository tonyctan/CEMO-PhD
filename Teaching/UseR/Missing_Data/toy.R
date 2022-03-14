# Set seed for replicability
set.seed(2022)

# Generate 500 random numbers
x0 <- rnorm(500)

# Generate another 500 random numbers
x1 <- rnorm(500)

# Generate z, which is a function of x and y
y <- 5 + 2.5 * x0 + 1.25 * x1 + rnorm(500)

# Generate z, also a function of y


# Make sure x against x and y look good enough
par(mfrow = c(1,2))
plot(y ~ x0)
plot(y ~ x1)

# Record the "true model"
m0 <- lm(y ~ x0 + x1)
summary(m0)

####################
# Produce MCAR on x1
####################

# Generate 100 NAs (causing 20% data loss)
na <- rep(NA, 100)
# Randomly mark some positions for NAs to enter
idx <- sample(500, 100)
# Replace original value with NAs
x1_MCAR <- x1
x1_MCAR[idx] <- na

# Plot x1 and x1_MCAR side-by-side
plot(density(x1),main="x1")
plot(density(x1_MCAR, na.rm=T), main = "x1_MCAR")

m_MCAR <- lm(y~x0+x1_MCAR, na.action=na.exclude)
summary(m_MCAR)

