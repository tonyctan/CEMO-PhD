        ###################################
        # Read in financial literacy data #
        ###################################

# Read in financial literacy data
setwd("~/uio/pc/Dokumenter/PhD/Coursework/UV9121 Process data/")
flt <- data.frame(data.table::fread("./Analysis/flt.csv",
    sep = "\t", header = TRUE, nThread = data.table::getDTthreads(),
    na.strings = c("Valid Skip", "Not Applicable", "Invalid", "No Response")
))
n0 <- nrow(flt)

# Recode student responses fromt text to numeric
option <- c(
    "Never heard of it",
    "Heard of it, but I don't recall the meaning",
    "Learnt about it, and I know what it means"
)
for (k in 1:3) {
    for (j in 4:21) {
        flt[, j] <- ifelse(
            flt[, j] == option[k],
            k,
            flt[, j]
        )
    }
}
flt[, c(4:21)] <- as.numeric(unlist(flt[, c(4:21)]))
# Out of the 18 items, how many were answeered?
flt$FL164_ans <- 18 - apply(flt[, c(4:21)], 1, function(x) {
    sum(is.na(x))
})


# Turn reation time from milliseconds to seconds
flt$FL164_TT <- flt$FL164_TT / 1000

# Remove candidates without reacion time
flt <- flt[which(!is.na(flt$FL164_TT)), ]
n1 <- nrow(flt)
# Sort dataset by reaction time
flt <- flt[order(flt$FL164_TT), ]
# Inspect the head and tail of reaction time
head(flt$FL164_TT, 500)
tail(flt$FL164_TT, 500)
# Decision: remove candidates with reaction time > 180 seconds (3 minutes)
flt <- flt[which(flt$FL164_TT < 180), ]
n2 <- nrow(flt)
# How many candidates were affected by this 3-minute cutoff?
n1 - n2 # Answer: 353 candidates
# Calculate data loss rate
(n0 - n2) / n0 * 100 # Answer: 3.28%

        ###################################
        # Study candidates' reaction time #
        ###################################

# Extract reaction time
data <- flt$FL164_TT
# Inspect frequency distribution of reaction time (no need to save this graph)
plot(density(data),
    xlab = "Reaction Time (seconds)",
    ylab = "Density",
    main = "Distribution of reaction time"
)

# Create a placeholder table
n <- length(data)
temp <- data.frame(matrix(NA, nrow = n - 2, ncol = 2))
names(temp) <- c("k", "l")

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
    xlab="Reaction Time (second)", ylab="Frequency",
    main="Data Distribution"
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
    xlab = "k (now number)", ylab = "Log-likelihood",
    main = "Maximum Likelihood"
)
abline(
    v = k_hat,
    col = "blue", lwd = 1, lty = 3
)
text(k_hat, maxloglik, k_hat,
    cex = 1, pos = 3, col = "blue")
# # Split data, k_hat
# data_exp <- data[which(data < cutoff)]
# data_norm <- data[which(data > cutoff)]
# plot(density(data_exp),
#     xlab = "Reaction Time (seconds)", ylab = "Density",
#     main = "Exponential Part"
# )
# abline(v = min(data), lwd = 1, lty = 3, col = "black")
# abline(v = cutoff, lwd = 1, lty = 3, col = "blue")
# plot(density(data_norm),
#     xlab = "Reaction Time (seconds)", ylab = "Density",
#     main = "Normal Part"
# )
# abline(v = cutoff, lwd = 1, lty = 3, col = "blue")
# abline(v = 180, lwd = 1, lty = 3, col = "black")
# Reset canvas
par(mfrow = c(1, 1))


# Generate FL164 sum scores
flt$FL164_contr_sum <- rowSums(flt[, 4:19]) # First 16 (control) items
flt$FL164_decoy_sum <- rowSums(flt[, 20:21]) # Last 2 (decoy) items
flt$FL164_sum <- flt$FL164_contr_sum + flt$FL164_decoy_sum

# Inspect frequency distribution of FL164 sum scores
hist(flt$FL164_sum,
    xlab = "Sum Score",
    ylab = "Frequency",
    main = "FL164 Sum Scores"
)

# Generate standard deviation of FL164
flt$FL164_sd <- apply(flt[, 4:21], 1, sd, na.rm = TRUE)
# Inspect response patterns
pdf("sum.pdf", paper = "a4")
    plot(flt$FL164_ans, flt$FL164_sd,
        xlab = "Items Answered",
        ylab = "Standard Deviation",
        main = "Response Patterns"
    )
    abline(h = 0.35, col = "red")
dev.off()


# Pull out those students whose SD are too small (try different cutoffs).
# These students' responses are too consistent--"same column responses"
pdf("subj_obj.pdf", paper = "a4r")
for (i in seq(0.1, 0.5, 0.05)) {
    flt_consistent <- flt[which(flt$FL164_sd < i), ]
    plot(flt_consistent$PV1FLIT ~ flt_consistent$FL164_sum,
        xlab = "FL164 Sum Score",
        ylab = "Financial Literacy (PV1FLIT)",
        main = paste0(
            "Subjective vs Objective Financial Literacy (SD < ", i, ")"
        )
    )
}
dev.off()
# After visual inspection, I decided to use SD = 0.35 as the threshold.
flt_consistent <- flt[which(flt$FL164_sd < 0.35), ]
# Kick out too-consistent students from the main dataset
flt_variable <- flt[which(!flt$CNTSTUID %in% flt_consistent$CNTSTUID), ]

# Compare the reaction time of flt_consistent and flt_variable students
head(table(unlist(flt_consistent$FL164_TT))) # Shortest RT = 1.288 seconds
tail(table(unlist(flt_consistent$FL164_TT))) # Longest RT = 4951.761 seconds
pdf("rt_density.pdf", paper = "a4")
    # Plot too-consistent students' reaction time
    plot(density(flt_consistent$FL164_TT, na.rm = TRUE),
        xlim = c(0, 120),
        axes = FALSE,
        xlab = "",
        ylab = "",
        main = "",
        col = "red"
    )
    abline(v = 25.3, col = "red")
    par(new = TRUE)
    # Plot other students' reaction time
    plot(density(flt_variable$FL164_TT, na.rm = TRUE),
        xlim = c(0, 120),
        xlab = "Reaction Time (seconds)",
        ylab = "Kernel Density",
        main = "Density Plots of Reaction Time",
        col = "blue"
    )
    abline(v = 45, col = "blue")
    legend("topright",
        legend = c("Consistent students", "Variable students"),
        col = c("red", "blue"), lty = 1, cex = 0.8
    )
dev.off()

pdf("hist_decomp.pdf", paper = "a4r")
    hist(flt$FL164_sum,
        xlim = c(18, 54), ylim = c(0, 10000),
        xlab = "FL164 Sum Score", ylab = "Frequency",
        main = "Frequency Distribution of FL164 Sum Scores (All Students)"
    )
    hist(flt_consistent$FL164_sum,
        xlim = c(18, 54), ylim = c(0, 10000),
        xlab = "FL164 Sum Score", ylab = "Frequency",
        main = "Consistent Students",
        col = rgb(1, 0, 0, 0.25)
    )
    hist(flt_variable$FL164_sum,
        xlim = c(18, 54), ylim = c(0, 10000),
        xlab = "FL164 Sum Score", ylab = "Frequency",
        main = "Variable Students",
        col = rgb(0, 0, 1, 0.25)
    )
dev.off()

# Recode reaction time into 7 groups
rt <- flt_consistent$FL164_TT
flt_consistent$FL164_TT_group <- dplyr::case_when(
    rt < 30 ~ 0, # Rapid responders
    30 <= rt & rt < 60 ~ 1,
    60 <= rt & rt < 90 ~ 2,
    90 <= rt & rt < 120 ~ 3,
    120 <= rt & rt < 150 ~ 4,
    150 <= rt & rt < 180 ~ 5,
    rt >= 180 ~ 6 # Forever responders
)
rm(rt)
rt <- flt_variable$FL164_TT
flt_variable$FL164_TT_group <- dplyr::case_when(
    rt < 30 ~ 0, # Rapid responders
    30 <= rt & rt < 60 ~ 1,
    60 <= rt & rt < 90 ~ 2,
    90 <= rt & rt < 120 ~ 3,
    120 <= rt & rt < 150 ~ 4,
    150 <= rt & rt < 180 ~ 5,
    rt >= 180 ~ 6 # Forever responders
)
rm(rt)

# Are FL164 sum scores correlated with reaction time?
pdf("self-claimed_vs_measured.pdf", paper = "a4")
    boxplot(flt_variable$FL164_sum ~ factor(flt_variable$FL164_TT_group),
        xlab = "Reaction Time (group)", ylab = "Sum Score of FL4",
        main = "Self-claimed Financial Literacy"
    )
    boxplot(
        flt_variable$PV1FLIT ~ factor(flt_variable$FL164_TT_group),
        xlab = "Reaction Time (group)", ylab = "Plausible Value of FLIT",
        main = "PISA-measured Financial Literacy"
    )
dev.off()

# List number of students in each group
nrow(flt)               # 107,174
nrow(flt_consistent)    #  17,177
nrow(flt_variable)      #  89,997

# Percentage of "consistent students"
nrow(flt_consistent) / nrow(flt) * 100  # 16.03%
