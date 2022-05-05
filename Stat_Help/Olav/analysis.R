# Set working directory depending on the operating system
library(Orcs)
setwdOS(lin = "~/uio/", win = "M:/", ext = "pc/Dokumenter/PhD/Stat_Help/Olav/")

# Load MplusAutomation package
library(MplusAutomation)
# This essentially turns Mplus into a very powerful R addon.

# Run Mplus models
runModels("m1.inp", showOutput = T)
runModels("m2.inp", showOutput = T)
runModels("m3.inp", showOutput = T)
runModels("m4.inp", showOutput = T)

# Read Mplus output files into R
m1 <- readModels("m1.out")
m2 <- readModels("m2.out")
m3 <- readModels("m3.out")
m4 <- readModels("m4.out")

# Model summaries

# Summary statistics
m1$summaries
# Model parameters
m1$parameters

m2$summaries; m2$parameters
m3$summaries; m3$parameters
m4$summaries; m4$parameters
