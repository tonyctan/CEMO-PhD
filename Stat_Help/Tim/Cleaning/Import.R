# Set working directory
setwd("~/uio/pc/Dokumenter/PhD/Stat_Help/Tim/Cleaning")

# Specify end-of-line for the A versions
# Use the correct end-of-line marker depending on the operating system
switch(Sys.info()[["sysname"]],
    Linux = {EOL2 = "\r\n\r\n"},
    Windows = {EOL2 = "\n\n"}
)

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

# Inspect top-left corner of the data set
raw[c(1:10), c(1:10)]

# Redirect all output to the S1 sub-folder
setwd("~/uio/pc/Dokumenter/PhD/Stat_Help/Tim/Cleaning/Output/S1_Sentence")

#################################
##### The green zone (P1 and P2)
#################################
for (j in 11:12) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                raw[i, j],
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 3], names(raw)[j], "S1",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

#################################
##### The red zones (P3 and P4)
#################################

# A version

for (j in 13:14) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 2], raw[i, j + 4],
                    sep = EOL2
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S1", "A",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

# B version

for (j in 13:14) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 2], raw[i, j + 4],
                    sep = " "
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S1", "B",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

#################################
##### The blue zone (P5 and P6)
#################################

# A version

for (j in 19:20) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 2], raw[i, j + 4],
                    sep = EOL2
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S1", "A",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

# B version

for (j in 19:20) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 2], raw[i, j + 4],
                    sep = " "
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S1", "B",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

#################################
##### The yellow zone (P7 and P8)
#################################

# A version

for (j in 25:28) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 4], raw[i, j + 8],
                    sep = EOL2
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S1", "A",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

# B version

for (j in 25:28) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 4], raw[i, j + 8],
                    sep = " "
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S1", "B",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

# Redirect all output to the S2 sub-folder
setwd("~/uio/pc/Dokumenter/PhD/Stat_Help/Tim/Cleaning/Output/S2_Theme")

#################################
##### The green zone (P1 and P2)
#################################
for (j in 11:12) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                raw[i, j],
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 3], names(raw)[j], "S2",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

#################################
##### The red zones (P3 and P4)
#################################

# A version

for (j in 13:14) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 2], raw[i, j + 4],
                    sep = EOL2
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S2", "A",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

# B version

for (j in 13:14) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 2], raw[i, j + 4],
                    sep = " "
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S2", "B",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

#################################
##### The blue zone (P5 and P6)
#################################

# A version

for (j in 19:20) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 2], raw[i, j + 4],
                    sep = EOL2
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S2", "A",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

# B version

for (j in 19:20) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 2], raw[i, j + 4],
                    sep = " "
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S2", "B",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

#################################
##### The yellow zone (P7 and P8)
#################################

# A version

for (j in 25:28) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 4], raw[i, j + 8],
                    sep = EOL2
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S2", "A",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}

# B version

for (j in 25:28) {
    for (i in 1:200) {
        if (is.na(raw[i, j]) == F) {
            write.table(
                paste(
                    raw[i, j], raw[i, j + 4], raw[i, j + 8],
                    sep = " "
                ),
                file = paste0(
                    paste(
                        raw[i, 1], raw[i, 4], names(raw)[j], "S2", "B",
                        sep = "_"
                    ),
                    ".txt",
                    sep = ""
                ),
                row.names = F, col.names = F, quote = F
            )
        }
    }
}
