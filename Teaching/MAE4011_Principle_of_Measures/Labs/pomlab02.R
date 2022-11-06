install.packages("corrplot")
library(corrplot)
load("Lab2.RData")

### PART 1:
# Call mtmm matrix to console to inspect.
mtmm
# corrplot package and function provide useful took to eyeball size of correlations.
corrplot(mtmm)

# TASK 1: Examine the MTMM matrix. Summarize the evidence for each trait on each method.
# a) Examine the evidence for convergence and discrimination within the first method (top-left matrix).
mtmm[1:4, 1:4]

# b) Examine the evidence for the second method (bottom-right matrix).
mtmm[5:8, 5:8]

# c) Examine the evidence for convergence and discrimination across methods (bottom-left sub-matrix).
mtmm[5:8, 1:4]

### PART 2: Disattenuate and re-assess.

## Implementing the equation for attenuation.
# Correlation between variables divided by the square of the product of the reliabilities.
cor.xy / (sqrt(rel.x * rel.y))

# Demonstrate on convergence-correlation for Courtesy trait across the two methods.
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

# TASK 2: Pick one of the traits (e.g., "Poise").
# a) Examine Convergence between the two methods after attenuation.
disattenuate(cor.xy = .13, rel.x = .82, rel.y = .28)

# b) Examine Discrimination  within methods following disattenuation.
disattenuate(cor.xy = .74, rel.x = .82, rel.y = .8)
disattenuate(.63, .82, .74)
disattenuate(.76, .82, .89)

disattenuate(cor.xy = .27, rel.x = .28, rel.y = .38)
disattenuate(.19, .28, .42)
disattenuate(.27, .28, .36)

# c) Examine    ---||---    across methods following disattenuation.
disattenuate(cor.xy = .06, rel.x = .82, rel.y = .38)
disattenuate(.01, .82, .42)
disattenuate(.12, .82, .36)

# Make function for disattenuating entire matrix.
disattmat <- function(x) {
  output <- matrix(ncol = ncol(x), nrow = nrow(x))
  colnames(output) <- rownames(output) <- colnames(x)
  for (i in 1:ncol(x)) {
    for (j in 1:nrow(x)) {
      output[i, j] <- disattenuate(x[i, j], x[i, i], x[j, j])
    }
  }
  output
}

mtmm
corrplot(mtmm)
round(disattmat(mtmm), 2)
corrplot(disattmat(mtmm))
round(disattmat(mtmm), 2) - mtmm
corrplot(disattmat(mtmm) - mtmm)


