# Install some packages
#install.packages(c("mice","VIM"),dependencies = T)

# Set working directory
setwd("~/uio/pc/Dokumenter/PhD/Teaching/UseR/Missing_Data/")

# Load the mice package
library(mice)

# Use the example dataset nhanes (came with the package)
nhanes

# observations = 25, variables = 4
# Variable names
#    age     age group               ordered categorical
#    bmi     body mass index         numerical
#    hyp     hypertension status     binary
#    chl     cholesterol level       numerical



# Inspect missing pattern (Method 1)
md.pattern(nhanes)

# Colour convention
#   blue    observed
#   red     missing
# Interpretation
#   13 rows are complete
#   3 row that chl is missing
#   1 row that bmi is missing
#   1 row that both hyp and bmi are missing
#   7 rows that only age is observed
#   Total number of missing values = 3x1 + 1x1 + 1x2 + 7x3 = 27
#   Most missing values (10) occur in chl

# Inspection by variable pairs (Method 2)
md.pairs(nhanes)

# Symbol convention (left, top)
#   r   observed (remain?)
#   m   missing

# Interpretation (focus on (bmi, chl) pair)
#   13 completely observed paris
#   3 pairs: bmi is observed but chl is missing
#   2 pairs: bmi is missing but chl is observed
#   7 pairs: both bmi and chl are missing

# Margin plot
par(mar = c(7, 7, 3, 3)) # In order to show the axes labels
# Inspect data range
c(min(nhanes$chl, na.rm = T), max(nhanes$chl, na.rm = T))
c(min(nhanes$bmi, na.rm = T), max(nhanes$bmi, na.rm = T))
# Generate margin plot
VIM::marginplot(nhanes[, c("chl", "bmi")],
    xlim = c(110, 290), ylim=c(20, 36),
    col = mdc(1:2), pch = 19,
    cex = 1.2, cex.lab = 1.2, cex.numbers = 1.3
)

# Interpretation
#   red 9   variable bmi contains 9 missings
#   red 10  variable chl contains 10 missings
#   red 7   The variable pair (bmi, chl) contains 7 missings
#   three red dots on the left: bmi values are known but chl missing
#   two red dots on the bottom: chl values are known but bmi missing
#   red dot cross between bmi and chl actually represents 7 dots
#   Total # dots = 13 (blue) + 3 (red left) + 2 (red bottom) + 7 (red cross)
#   Box plots: marginal distributions (blue = obs, red = mis)
#   If MCAR => red and blue box plots are expected to be identical



# Impute missing data
imp <- mice(nhanes, printFlag = F, seed = 23109)
# The multiply imputed dataset, imp, is of class mids (MI data set)
print(imp)



# Diagnostic checking
# Recall that bmi contains 9 missings
# The MI procedure produced five guesses for each missing:
imp$imp$bmi
# The 1st complete dataset combines the observed and imputed values:
complete(imp)
# We can print out the 2nd set of the complete dataset
complete(imp, 2)
# If complete to start with => identical in all five sets
# If missing to start with => differ in each set
# Degree of difference reflects degree of uncertainty

# Visual inspection (big picture)
stripplot(imp, pch = 20, cex = 1.2)
# Colour convention
#   blue    observed
#   red     imputed
# Each x-axis marker is one version of MI. 0 = original set
# Red points follow the blue points reasonably well, including the gaps in the distribution.

# Visual inspection (fine details)
xyplot(imp, bmi ~ chl | .imp, pch = 20, cex = 1.4)
# Red points have more or less the same shape as blue data => imputed data could have been plausible measurements if they had not been missing
# Differences between the red points represents uncertainty about the true, but unkown, values



# Analysing imputed datasets
# Original regression: lm(chl ~ age + bmi)
# Repeat this analysis to each version of MI
fit <- with(data = imp, exp = lm(chl ~ age + bmi))
# Pool the multiple versions of the analyses together
summary(pool(fit))
# Both age and bmi are significant at .05 level

# If we increase m, the number of imputations, significant levels may change
summary(pool(with(
    mice(nhanes, m = 10, printFlag = F, seed = 23109), # order 10 sets of MI
    lm(chl ~ age + bmi)
))) # More significant



# Imputation methods
# Default imputation method = pmm (predictive mean matching)
# Default number of multiple imputations (often denoted by m) = 5
# If not happy, feel free to change the defaults
imp <- mice(nhanes,
    method = c("", "norm", "pmm", "mean"), m = 50,
    printFlag = F, seed = 23109
)

# In order to show case different imputation methods, use nhanes2 dataset
str(nhanes2)

# Impute
imp <- mice(nhanes2,
    me = c("polyreg", "pmm", "logreg", "norm"), # me = method
    printFlag = F, seed = 23109
)
print(imp)
