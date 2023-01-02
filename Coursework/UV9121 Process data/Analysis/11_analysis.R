# Read in financial literacy data
setwd("~/uio/pc/Dokumenter/PhD/Coursework/UV9121 Process data/")
flt <- data.frame(data.table::fread("./Analysis/flt.csv",
    sep = "\t", header = TRUE, nThread = data.table::getDTthreads(),
    na.strings = c("Valid Skip", "Not Applicable", "Invalid", "No Response")
))

# Turn reation time from milliseconds to seconds
flt$FL164_TT <- flt$FL164_TT / 1000

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

# Generate sum scores of FL164
flt$FL164_ok_sum <- rowSums(flt[, 4:19]) # First 16 (reasonable) items
flt$FL164_bs_sum <- rowSums(flt[, 20:21]) # Last 2 ("Are you sure?") items
flt$FL164_sum <- flt$FL164_ok_sum + flt$FL164_bs_sum

# Inspect frequency distribution of FL164 sum scores
hist(flt$FL164_sum,
    xlab = "Sum score of FL164 (PISA 2018 Financial Literacy)",
    ylab = "Frequency",
    main = "frequency Distribution of FL164 Sum Scores"
)

# Generate standard deviation of FL164
flt$FL164_sd <- apply(flt[, 4:21], 1, sd)
# Are the sum/mean and standard deviation correlated?
pdf("sum.pdf", paper = "a4")
    plot(flt$FL164_sum, flt$FL164_sd,
        xlab = "Sum Score ",
        ylab = "Standard Deviation",
        main = "FL164's Sum Score vs Standard Deviations"
    )
    abline(h = 0.35, col = "red")
dev.off()


# Pull out those students whose SD are too small (try different cutoffs).
# These students' responses are too consistent--"same column responses"
pdf("subj_obj.pdf", paper = "a4r")
for (i in seq(0.1, 0.5, 0.05)) {
    flt_consistent <- flt[which(flt$FL164_sd < i), ]
    plot(flt_consistent$PV1FLIT ~ flt_consistent$FL164_sum,
        xlab = "Self-claimed Financial Literacy (FL164 Sum Score)",
        ylab = "Objectively-measured Financial Literacy (PV1FLIT)",
        main = paste0(
            "Subjective vs Objective Financial Literacy (SD = ", i, ")"
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
