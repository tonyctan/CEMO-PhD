# Housekeeping
setwd("~/uio/pc/Dokumenter/PhD/Teaching/MAE/fig")
set.seed(2022)

# Generate 100 random numbers
x <- rnorm(100)

# Generate a histogram in EPS format
setEPS()
postscript("hist.eps")
    hist(x,main="")
dev.off()
