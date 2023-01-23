        ##############################
        # Step 1: Simulate a dataset #
        ##############################

# Generate 1000 mixed data:
#   t of them from Exp(0.8)
#   1000-t from N(15,2^2)
t <- 50
set.seed(2023)
data <- c(
    rexp(t, rate = 0.8),
    rnorm(1000 - t, mean = 15, sd = 2)
)
# Sort data in ascending order
data <- data[order(data)]

# Create a placeholder table
n <- length(data)
temp <- data.frame(matrix(NA, nrow = n - 2, ncol = 2))
names(temp) <- c("k", "l")

        #####################################
        # Step 2: Grid search for optimal k #
        #####################################

# Compute log-likelihood for each k
for (k in 1:(n - 2)) {
    # Partition the data into two parts
    data_exp <- data[1:k]           # Exponential part
    data_norm <- data[(k + 1):n]    # Normal part
    # Compute the log-likelihood
    temp[k, 1] <- k
    temp[k, 2] <- - k * log(mean(data_exp)) - k - (n - k) / 2 * log(2 * pi * var(data_norm)) - (n - k) / 2      # Equation (7)
}

# Locate which row the maximal log-likelihood appears
maxloglik <- max(temp[, 2])
line_maxloglik <- temp[which(temp == maxloglik, arr.ind = TRUE)[1], ]
print(line_maxloglik)
k_hat <- line_maxloglik[[1]]

# Compute cutoff
cutoff <- (data[k_hat] + data[k_hat + 1]) / 2
print(cutoff)

# Visualisation
#   Left panel: Data distribution
par(mfrow = c(1, 2))
hist(data,
    col = "white", border = "black",
    xlim=c(min(data), max(data)),
    xlab="Data", ylab="Frequency", main="Distribution and Cutoff"
)
par(new = TRUE)
plot(density(data),
    col = "black", lwd = 2,
    xlim=c(min(data), max(data)),
    xaxt = "n", yaxt = "n", ann = FALSE
)
abline(
    v = cutoff,
    col = "blue", lwd = 1, lty = 3
)
text(cutoff, 0, round(cutoff, 3),   # Round to 3 decimal places
    cex = 1, pos = 1,col = "blue")  # character expansion = 100%; pos = below

#   Right panel: Log-likelihood as a function of k
plot(temp[, 2] ~ temp[, 1],
    type = "l", col = "red", lwd = 2,
    xlim = c(0, n), ylim = c(min(temp[, 2]), max(temp[, 2])),
    xlab = "k", ylab = "log-likelihood", main = "Grid Search"
)
abline(
    v = k_hat,
    col = "blue", lwd = 1, lty = 3
)
text(k_hat, maxloglik, k_hat,
    cex = 1, pos = 3, col = "blue")
par(mfrow = c(1, 1))

        ####################################################
        # Step 3: Compute MLEs for distribution parameters #
        ####################################################

# Re-partition the data using the optimal k
data_exp <- data[1:k_hat]         # Exponential data
data_norm <- data[(k_hat + 1):n]  # Normal data

# Compute MLEs
lambda_hat <- round(1/mean(data_exp), 3)
mu_hat <- round(mean(data_norm), 3)
sigma_sq_hat <- round(var(data_norm), 3)
print(c(lambda_hat, mu_hat, sigma_sq_hat))

        ##############################
        # Step 4: Interval estimates #
        ##############################
