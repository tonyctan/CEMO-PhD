# Either, set working directory from default folder (PhD folder)
setwd(
	paste0(
		noquote(getwd()), # PhD folder
		"/Teaching/MAE4011_Principle_of_Measures/Labs" # Extension
	)
)

# Or, set working directory by typing the full path
setwd("~/uio/pc/Dokumenter/PhD/Teaching/MAE4011_Principle_of_Measures/Labs")

# install.packages("corrplot")
# library(corrplot)

# Read in dataset
load("pomlab02.RData") # object name: mtmm





### PART 1:

# Inspect mtmm matrix
mtmm

# Use "corrplot" package to visualise correlations.
corrplot::corrplot(mtmm)


# TASK 1: Examine the MTMM matrix. Summarize the evidence for each trait on each method.

# a) Examine convergent and discriminant validities for the first method (top-left matrix).
mtmm[1:4, 1:4]

# b) EExamine convergent and discriminant validities for the the second method (bottom-right matrix).
mtmm[5:8, 5:8]

# c) Examine convergent and discriminant validities across methods (bottom-left sub-matrix).
mtmm[5:8, 1:4]





### PART 2: Disattenuate and re-assess.

## Implementing the equation for attenuation.
# Correlation between variables divided by the square root of the product of the reliabilities.
# cor.xy / (sqrt(rel.x * rel.y))

# Demonstrate convergent correlation for the trait "Courtesy" across the two methods.
mtmm
# Correlation found in intersection between the two methods:
mtmm[5, 1]
# Reliabilities found in intersection of a variable with itself.
mtmm[1, 1]
mtmm[5, 5]

# Disattenuating correlation between the two methods for assessing Courtesy:
.13 / (sqrt(.82 * .28))

# Generalize expression by making it a function:
disattenuate <- function(cor.xy, rel.x, rel.y) {
	cor.xy / (sqrt(rel.x * rel.y))
}

# Apply function:
disattenuate(cor.xy = .13, rel.x = .82, rel.y = .28)

# TASK 2: Pick one of the traits (e.g., "Poise")

# a) Examine convergence between the two methods after attenuation.
disattenuate(cor.xy = .13, rel.x = .82, rel.y = .28)

# b) Examine discrimination within methods after disattenuation.
disattenuate(cor.xy = .74, rel.x = .82, rel.y = .8)
disattenuate(.63, .82, .74)
disattenuate(.76, .82, .89)

disattenuate(cor.xy = .27, rel.x = .28, rel.y = .38)
disattenuate(.19, .28, .42)
disattenuate(.27, .28, .36)

# c) Examine discrimination across methods after disattenuation.
disattenuate(cor.xy = .06, rel.x = .82, rel.y = .38)
disattenuate(.01, .82, .42)
disattenuate(.12, .82, .36)

# Make a function to disattenuate the entire matrix.
disattmat <- function(x) {
	output <- matrix(ncol = ncol(x), nrow = nrow(x))
	colnames(output) <- rownames(output) <- colnames(x)
		for (i in 1 : ncol(x)) {
			for (j in 1 : nrow(x)) {
				output[i, j] <- disattenuate(x[i, j], x[i, i], x[j, j])
			}
		}
	output
}

# Original
mtmm
corrplot::corrplot(mtmm)
# Disattenuated
round(disattmat(mtmm), 2)
corrplot::corrplot(disattmat(mtmm))
# Differences
round(disattmat(mtmm), 2) - mtmm
corrplot::corrplot(disattmat(mtmm) - mtmm)
