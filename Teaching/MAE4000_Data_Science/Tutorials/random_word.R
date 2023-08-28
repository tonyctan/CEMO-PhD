# Save each step to an intermediate variable
random_word <- function(n_letters) {
    letters <- sample(letters, n_letters)
    paste(letters, collapse = "")
}

# Use indentation
random_word <- function(n_letters) {
    paste(
        sample(letters, n_letters),
        collapse = ""
    )
}
