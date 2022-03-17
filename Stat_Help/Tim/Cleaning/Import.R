# Set working directory
setwd("~/uio/pc/Dokumenter/PhD/Stat_Help/Tim/Cleaning")

# # Import Excel file into R
# raw <- xlsx::read.xlsx("raw.xlsx", sheetName = "6_Text", encoding="UTF-8",as.data.frame = T)
# names(raw)
# dim(raw)
# head(raw)
# write.csv(raw, "raw.csv", row.names = F)
# # Remove \u0098 etc by hand

# Import CSV data file
raw <- read.csv("raw.csv", header = T, sep = ",")
names(raw)
dim(raw)
head(raw)

raw[c(1:10), c(1:10)]

write.table(
    raw[1, 11],
    file = paste0(
        paste(
            raw[1, 1], raw[1, 3], names(raw)[11], sep = "_"
        ),
        ".txt", sep = ""
        ),
    row.names = F, col.names = F, quote = F
)
