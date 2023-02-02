# Set working directory to Tutorial folder
Orcs::setwdOS(
    lin = "~/uio/", win = "M:/",
    ext = "pc/Dokumenter/PhD/Teaching/MAE4000 Data Science/Tutorials/"
)

# Read in the datasets
mtcars <- read.table(file = "../data/mtcars.txt", sep = ";", header = T)
flights <- read.table(file = "../data/flights.txt", sep = ";", header = T)
teamshalf <- read.table(file = "../data/TeamsHalf.txt", sep = ";", header = T)

# Inspect variable names
names(teamshalf)
# Generate a frequency table
table(unlist(teamshalf$teamID))
teamshalf[order(teamshalf$teamID),]
