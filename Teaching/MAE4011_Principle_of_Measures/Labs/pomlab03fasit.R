
# Install and load lavaan and semPlot.
install.packages("lavaan")
library(lavaan)
install.packages("semPlot")
library(semPlot)


# Define the covariance matrix.
covSWLS <- matrix(c(2.566, 1.560, 1.487, 1.195, 1.425, 
                    1.560, 2.493, 1.283, 0.845, 1.313, 
                    1.487, 1.283, 2.462, 1.127, 1.313, 
                    1.195, 0.845, 1.127, 2.769, 1.323, 
                    1.425, 1.313, 1.313, 1.323, 3.356), 
                  nrow = 5, ncol = 5)

# Add labels to the matrix rows and columns.
rownames(covSWLS) <- colnames(covSWLS) <- c("X1", "X2", "X3", "X4", "X5")

# Inspect the covariance matrix.
covSWLS

# Make correlation matrix from the covariance matrix.
corSWLS <- cov2cor(covSWLS)

# Inspect the correlation matrix.
round(corSWLS, 2)

# Install and load lavaan and semPlot.
install.packages("lavaan")
library(lavaan)
install.packages("semPlot")
library(semPlot)


### Task 1.
## Subtask 1.
# Specify unidimensional factor model.
mdl.1D <- "SWLS =~ X1 + X2 + X3 + X4 + X5"

# Fit the model specified above to the covariance and correlation matrices.
mdl.1D.cov <- cfa(mdl.1D, sample.cov = covSWLS, sample.nobs = 125, std.lv = TRUE)
mdl.1D.cor <- cfa(mdl.1D, sample.cov = corSWLS, sample.nobs = 125, std.lv = TRUE)

# Examine fit.
fitMeasures(mdl.1D.cov, c("chisq", "df", "pvalue", "srmr", "rmsea", "cfi", "tli", "aic", "bic"))
fitMeasures(mdl.1D.cor, c("chisq", "df", "pvalue", "srmr", "rmsea", "cfi", "tli", "aic", "bic"))
residuals(mdl.1D.cov)
residuals(mdl.1D.cor)
coef(mdl.1D.cov)
coef(mdl.1D.cor)
summary(mdl.1D.cor)
summary(mdl.1D.cov)

# Standardized factor loadings can be used to compute the model-implied covariance matrix.
fitted(mdl.1D.cor)

#### BONUS!! Residual matrix:
## Fitted covariance matrix can be subtracted from the observed covariance matrix to compute
## the residual covariance matrix. Using correlation matrix:
manual.residuals <- corSWLS[lower.tri(corSWLS)] * .992 - fitted(mdl.1D.cor)$cov[lower.tri(fitted(mdl.1D.cor)$cov)]
manual.matrix <- diag(.992, 5, 5)
manual.matrix[lower.tri(manual.matrix)] <- manual.residuals
manual.matrix[upper.tri(manual.matrix)] <- manual.residuals

lavaan.residuals <- residuals(mdl.1D.cor)$cov[lower.tri(residuals(mdl.1D.cor)$cov)]
lavaan.matrix <- diag(.992, 5, 5)
lavaan.matrix[lower.tri(lavaan.matrix)] <- lavaan.residuals
lavaan.matrix[upper.tri(lavaan.matrix)] <- lavaan.residuals

manual.matrix == lavaan.matrix
all(manual.matrix == lavaan.matrix)

# Plot models.
semPaths(mdl.1D.cor, what = "paths", esize = 1, edge.label.cex = 1.5)
semPaths(mdl.1D.cor, what = "par", esize = 1, edge.label.cex = 1.5)

# Subtask 2.
# Specify the two-dimensional model
mdl.2D <- "F1 =~ X1 + X2 + X3
           F2 =~ X4 + X5"

# Fit the model specified above to the covariance and correlation matrices.
mdl.2D.cov <- cfa(mdl.2D, sample.cov = covSWLS, sample.nobs = 125, std.lv = TRUE)
mdl.2D.cor <- cfa(mdl.2D, sample.cov = corSWLS, sample.nobs = 125, std.lv = TRUE)

# Examine the fit of the models.
fitMeasures(mdl.2D.cov, c("chisq", "df", "pvalue", "srmr", "rmsea", "cfi", "tli", "aic", "bic"))
fitMeasures(mdl.2D.cor, c("chisq", "df", "pvalue", "srmr", "rmsea", "cfi", "tli", "aic", "bic"))

residuals(mdl.2D.cov)$cov
residuals(mdl.2D.cor)$cov

coef(mdl.2D.cov)
coef(mdl.2D.cor)

#Plot models.
semPaths(mdl.2D.cor, what = "paths", esize = 1, edge.label.cex = 1.5)
semPaths(mdl.2D.cor, what = "par", esize = 1, edge.label.cex = 1.5)

# Compare the fit of the 1D and 2D models.
anova(mdl.1D.cor, mdl.2D.cor)



### Task 2.
# Load Thurstone data.
load('Thurstone.RData')

# Inspect data.
Thurstone

# Specify the uni- and three-dimensional factor models.
mdl.1D.Th <- "F1 =~ Sentences + Vocabulary + Sent.Completion + First.Letters + Four.Letter.Words + Suffixes + Letter.Series + Pedigrees + Letter.Group"
mdl.3D.Th <- "F1 =~ Sentences + Vocabulary + Sent.Completion
              F2 =~ First.Letters + Four.Letter.Words + Suffixes
              F3 =~ Letter.Series + Pedigrees + Letter.Group"

# Fit model to data.
mdl.1D.Th.fit <- cfa(mdl.1D.Th, sample.cov = Thurstone, sample.nobs = 213, std.lv = TRUE)
mdl.3D.Th.fit <- cfa(mdl.3D.Th, sample.cov = Thurstone, sample.nobs = 213, std.lv = TRUE)
fitMeasures(mdl.1D.Th.fit, "rmsea")
fitMeasures(mdl.3D.Th.fit, "rmsea")
anova(mdl.1D.Th.fit, mdl.3D.Th.fit)

# Bonus: Bifactor model.
# Model specification.
mdl.bifac.Th <- "
  G =~ Sentences + Vocabulary + Sent.Completion + First.Letters + Four.Letter.Words + Suffixes + Letter.Series + Pedigrees + Letter.Group
  F1 =~ Sentences + Vocabulary + Sent.Completion
  F2 =~ First.Letters + Four.Letter.Words + Suffixes
  F3 =~ Letter.Series + Pedigrees + Letter.Group
  G ~~ 0 * F1
  G ~~ 0 * F2
  G ~~ 0 * F3
  F1 ~~ 0 * F2
  F1 ~~ 0 * F3
  F2 ~~ 0 * F3"

# Fit model to data.
mdl.bifac.Th.fit <- cfa(mdl.bifac.Th, sample.cov = Thurstone, sample.nobs = 213, std.lv = TRUE)

# Compare fit with three-dimensional model
anova(mdl.3D.Th.fit, mdl.bifac.Th.fit)
residuals(mdl.3D.Th.fit)$cov
residuals(mdl.bifac.Th.fit)$cov

# Plotting of model.
semPaths(mdl.bifac.Th.fit, layout = "tree3")
semPaths(mdl.bifac.Th.fit, bifactor = "G", layout = "tree2", what = "par", esize = 1, edge.label.cex = 1.5)
