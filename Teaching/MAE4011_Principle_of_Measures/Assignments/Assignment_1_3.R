# Set working directory from PhD folder
setwd(
    paste0(
        noquote(getwd()), # PhD folder
        "/Teaching/MAE4011_Principle_of_Measures/Assignments" # Extension
    )
)

# Load data (object name = QT1)
load("MAE4011H22A1.RData")
# Substitute dots in the column names to space
names(QT1) <- gsub("\\.", " ", names(QT1))
# Save data to csv
data.table::fwrite(QT1, "QT1.csv", sep = "\t")

View(QT1)
