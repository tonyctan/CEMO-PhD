# Detect path this R script is located in...
wd <- this.path::Sys.dir()
# ...and set it as the working directory
setwd(wd)

# Generate a list of all Excel input files
file_names <- list.files(paste0(wd, "/in"))

# Repeat the R script for each input data file
for (k in 1:length(file_names)) {
    # Read an Excel file into R one at a time
    original <- data.frame(readxl::read_excel(
        paste0(wd, "/in/", file_names[k]),
        col_names = FALSE, # Original dataset has no column names
        .name_repair = "minimal" # Suppress new column name warnings
    )[, -19]) # Remove empty column

    # Preserve the item name (eg, "1ab", "1ac", etc.)
    item_name <- original[1, 1]

    # Generate the 1st placeholder matrix
    # Same height, but twice as wide as the original dataset
    temp1 <- data.frame(matrix(NA,
        nrow = dim(original)[1],
        ncol = 2 * dim(original)[2] - 1 # ID column does not need doubling
    ))

    # Copy the rater ID (first column) from original to temp1
    temp1[, 1] <- original[, 1]

    # Insert an empty column every other column
    for (j in 2:ncol(original)) { # Skip Column 1 since it is rater ID
        temp1[, (j - 1) * 2] <- original[, j]
    }

    # Remove dataset "original" from memory
    rm(original)

    # Remember odd rows and even rows in temp1
    row_odd <- seq(1, nrow(temp1), by = 2)
    row_even <- seq(2, nrow(temp1), by = 2)

#//fix REALLY CANNOT REMEMBER WHY I DID THIS
    for (i in row_even) {
        temp1[i, ] <- c(temp1[i, 1:(ncol(temp1) - 1)], NA)
    }

    # Create the 2nd placeholder matrix
    # Save width and height of temp1
    temp2 <- data.frame(matrix(NA,
        nrow = nrow(temp1),
        ncol = ncol(temp1)
    ))

    # Copy-paste odd rows from temp1 to temp2
    for (i in row_odd) {
        temp2[i, ] <- temp1[i, ]
    }
    # Move even rows one cell to the right
    for (i in row_even) {
        for (j in 2:I(dim(temp1)[2] - 1)) {
            temp2[i, 1] <- temp1[i, 1] # First column simply copy-paste
            temp2[i, j + 1] <- temp1[i, j]
        }
    }

    # Remove dataset "temp1" from memory
    rm(temp1)

    # Create the 3rd placeholder matrix
    # Same width, but half the height as temp2
    temp3 <- data.frame(matrix(NA,
        nrow = nrow(temp2) / 2,
        ncol = dim(temp2)[2] - 1
    ))

    # Relocate odd rows from temp2 to temp3
    for (i in row_odd) {
        for (j in 2:I(dim(temp2)[2] - 1)) {
            temp3[(i + 1) / 2, j - 1] <- temp2[i, j]
        }
    }
    # Relocate even rows from temp2 to temp3
    for (i in row_even) {
        for (j in seq(3, 37, 2)) {
            temp3[i / 2, j - 1] <- temp2[i, j]
        }
    }

    # Remove dataset "temp2" from memory
    rm(temp2)

    # Add row names
    item <- rep(item_name, dim(temp3)[1])
    temp4 <- cbind(item, temp3)

    # Remove dataset "temp3" from memory
    rm(temp3)

    # Save data
    split <- data.table::fwrite(temp4,
        paste0(
            wd, "/out/", # Redirect to output folder
            gsub("\\..*", "", file_names[k]), # Remove old file extension .xlsx
            ".csv" # Add new file extension .csv
        ),
        row.names = FALSE, col.names = FALSE
    )

    # Remove dataset "temp4" from memory
    rm(temp4)
} # End k loop

# Merge all temporary CSV files into one
suppressWarnings(system2(
    switch(Sys.info()[["sysname"]],
        Windows = {
            command = "type"
        },
        Linux = {
            command = "cat"
        },
        Darwin = {
            command = "cat"
        }
    ),
    args = "./out/*.csv > all.csv"
))
# # Remove all temporary CSV files
# system2(
#     command = "rm",
#     args = "./out/*.csv"
# )

# Add column names to the merged CSV file

# Read the merged CSV file back into R
all <- data.frame(data.table::fread("all.csv", header = FALSE))

# Create a column header

# Name Rater A and Rater B
rater <- rep(c("A", "B"), times = I(ncol(all) - 1) / 2)
# Name Question 1, Question 2, etc.
question <- rep(1:I(I(ncol(all) - 1) / 2), each = 2)
# Create a receiving column
col_header <- matrix(NA, nrow = 1, ncol = ncol(all))
# First entry in column header is "Item"
col_header[1] <- "Item"
# From the 2nd entry, stitch Rater and Question into
# A1, A2, B1, B2, etc.
for (i in 1:length(rater)) {
    col_header[i + 1] <- paste0(rater[i], question[i])
}
# Add column header
names(all) <- unlist(noquote(col_header))

# Save final dataset
data.table::fwrite(all,
    paste0(wd, "/all.csv"),
    row.names = FALSE, col.names = TRUE
)

gc() # Clear memory
