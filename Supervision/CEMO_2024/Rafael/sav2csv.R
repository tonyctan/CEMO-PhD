# Convert all SPSS (*.sav) files in a folder to CSV files
spss2csv <- function(datawd) {
    # Look for all the SPSS files in the data folder
    file_list <- list.files(datawd, pattern = "*.sav")
    # Count the total number of SPSS files
    n_files <- length(file_list)
    # Loop: Transform an SPSS file to a CSV file, one at a time
    for (i in 1:n_files) {
        # Read in one SPSS file
        spss_file <- haven::read_sav(
            paste0(datawd, "/", file_list[i])
        )
        # Convert tibble to data.frame
        csv_file <- data.frame(spss_file)
        # Remove tibble
        rm(spss_file)
        # Write CSV file back to data folder
        data.table::fwrite(
            csv_file,
            paste0(datawd, "/", tools::file_path_sans_ext(file_list[i]), ".csv")
        )
        # Remove CSV file, ready for next loop
        rm(csv_file)
    }
    # Remove counter i, file list, and file count from memory
    rm(i)
    rm(file_list)
    rm(n_files)
}
