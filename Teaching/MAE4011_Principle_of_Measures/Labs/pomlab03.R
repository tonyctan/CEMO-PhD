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
corSWLS

# Install and load lavaan and semPlot.
install.packages("lavaan")
library(lavaan)
install.packages("semPlot")
library(semPlot)


### Task 1.
## Subtask 1.
# Specify unidimensional factor model.

# Fit the model specified above to the covariance and correlation matrices.

# Examine fit.

# Plot models.

# Subtask 2.
# Specify the two-dimensional model

# Fit the model specified above to the covariance and correlation matrices.

# Examine the fit of the models.

#Plot models.

# Compare the fit of the 1D and 2D models.



### Task 2.
# Load Thurstone data.

# Specify the uni- and three-dimensional factor models.

# Fit model to data.

# Bonus: Bifactor model.
# Model specification.

# Fit model to data.

# Compare fit with three-dimensional model

# Plotting of model.
