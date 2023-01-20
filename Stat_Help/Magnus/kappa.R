# Read in the total dataset
all <- read.table("/media/tony/Samsung_T5/Magnus/all.csv",
    sep = ",", header = TRUE
)

# Data audit
all[c(96, 195, 353, 354, 360, 365), ]
# Data correction
all[96, 33] <- 0
all[195, 30] <- 1
all[353, 26] <- 2
all[354, 26] <- 1.5
all[360, 26] <- 2
# Whole row of Row 365 needs to be re-typed
all[365, ] <- c("2ac",2,3,2,3,1,1,1.5,1,0,0,0.5,1,0.5,1,5,4,3.5,3.5,3,3,3.5,2,0,0,1,1,0,0,3,2,0.5,1,0,0,17,17)

# Replace NA with 0
all[is.na(all)] <- 0


# Sublet datasets
item_label <- unique(all[, 1])
n_item <- length(item_label)

# Create column identifiers
col_odd <- seq(2,36,2)

kappa_unweighted <- data.frame(matrix(NA, nrow = n_item, ncol = 18))
kappa_weighted <- data.frame(matrix(NA, nrow = n_item, ncol = 18))

for (i in 1:n_item) {
    all_sub <- all[which(all$Item==item_label[i]), ]
    for (j in col_odd) {
        kappa_unweighted[i, j/2] <- psych::cohen.kappa(
            cbind(noquote(all_sub[, j]), noquote(all_sub[, j + 1]))
        )[1]
        kappa_weighted[i, j/2] <- psych::cohen.kappa(
            cbind(noquote(all_sub[, j]), noquote(all_sub[, j + 1]))
        )[2]
    }
}
kappa_unweighted <- kappa_unweighted
kappa_weighted <- kappa_weighted

mean_kappa_uw <- round(colSums(kappa_unweighted) / nrow(kappa_unweighted), 3)
mean_kappa_w <- round(colSums(kappa_weighted) / nrow(kappa_weighted), 3)


par(mfrow = c(2, 1))
barplot(mean_kappa_w, main = "Weighted Mean Kappa", ylim = c(0, 1))
barplot(mean_kappa_w[order(mean_kappa_w)],
    main = "", ylim = c(0, 1)
)
abline(h=0.65, lty=1)
par(mfrow = c(2, 1))
barplot(mean_kappa_w, main = "Weighted Mean Kappa", ylim = c(0, 1))
barplot(mean_kappa_w[order(mean_kappa_w)],
    main = "", ylim = c(0, 1)
)
abline(h=0.8, col="blue")
abline(h=0.65, col="red")

