# Set working directory
setwd("~/uio/pc/Dokumenter/PhD/Teaching/UseR/Missing Data/")

# Load the mice package
library(mice)

# Use the example dataset nhanes (came with the package)
nhanes

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
