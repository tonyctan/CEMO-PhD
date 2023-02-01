setwd("/Users/tctan/uio/pc/Dokumenter/PhD/Teaching/MAE4011_Principle_of_Measures/Labs/")
load("pomlab04.RData")

library(lavaan)

mymodel <- "
F1 =~ X1 + X2 + X3 + X4 + X5 + X6
"

# Estimate the model with maximum likelihood ("ML")
mycfa <- cfa(mymodel, data = dataG4G6[, 1:6], std.lv = TRUE, estimator = "ML")

# Evaluate the model fit
summary(mycfa, fit.measures = TRUE, std = TRUE)

# Residuals based on the observed and
# model-implied correlation matrices
residuals(mycfa, "cor")
mean(residuals(mycfa, "cor")$cov)

# Coefficient omega
sum(coef(mycfa)[1])^2 / var((dataG4G6[, 1]))
sum(coef(mycfa)[2])^2 / var((dataG4G6[, 2]))
sum(coef(mycfa)[3])^2 / var((dataG4G6[, 3]))
sum(coef(mycfa)[4])^2 / var((dataG4G6[, 4]))
sum(coef(mycfa)[5])^2 / var((dataG4G6[, 5]))
sum(coef(mycfa)[6])^2 / var((dataG4G6[, 6]))
sum(coef(mycfa)[1:6])^2 / var(rowSums(dataG4G6[, 1:6]))

### TASK: Estimate a single factor model for grade 4 and grade 6 individually. ###
###       Evaluate the models.                                                 ###





##################################################################################







###################################################################################

### Evaluating bias
## Group performance on an item
t.test(G4$X6, G6$X6)
h1 <- hist(G4$X6)
h2 <- hist(G6$X6)

# first histogram
plot(h1,
     col = rgb(0, 0, 1, 1 / 4),
     xlim = c(2, 14),
     ylim = c(0, 200)
)
# second histogram
plot(h2,
     col = rgb(1, 0, 0, 1 / 4),
     xlim = c(2, 15),
     ylim = c(0, 200),
     add = T
) # Adds the plots together

## Conditioning
# Remainder scores based on scales 1 to 5
G4_X1_5 <- rowSums(G4[1:5])
G6_X1_5 <- rowSums(G6[1:5])

# Test equality of item 6 mean scores
# conditional on a range of remainder scores
t.test(
     G4$X6[G4_X1_5 > 55 & G4_X1_5 < 61],
     G6$X6[G6_X1_5 > 55 & G6_X1_5 < 61]
)

# Obtain distribution of mean item 6 scores
# conditional on particular remainder scores
G4_X6_dist <- numeric(20)
G6_X6_dist <- numeric(20)
for (i in seq(41, 60, by = 1)) {
     G4_X6_dist[i - 40] <- mean(G4$X6[G4_X1_5 == i])
     G6_X6_dist[i - 40] <- mean(G6$X6[G6_X1_5 == i])
}

# Plot distributions
plot.new()
plot(seq(41, 60, by = 1),
     G4_X6_dist,
     xlab = "Remainder score",
     ylab = "Item score",
     ylim = c(0, 12),
     pch = 1
)
par(new = TRUE)
plot(seq(41, 60, by = 1),
     G6_X6_dist,
     xlab = "",
     ylab = "",
     ylim = c(0, 12),
     pch = 2
)
legend("topleft",
     bty = "n",
     legend = c(
          "Grade 4",
          "Grade 6"
     ),
     pch = c(1, 2)
)

### Task: Choose a different item and check for item bias ###
