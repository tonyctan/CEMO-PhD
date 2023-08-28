# A function calculating the square root of a real number
sqrt_real <- function(real_number) {
    # If input is 0 or positive, no drama
    if (real_number >= 0) {
        print(sqrt(real_number))
    } else { # If input is negative, return a complex output
        print( # Same as return()
            noquote( # Suppress quotation marks
                paste0( # Glue two elements together, without space
                    round( # Real part retains 3 decimal points
                        sqrt((-1) * real_number),
                        digits = 3
                    ),
                    "i" # Imaginary unit
                )
            )
        )
    }
}

sqrt_real(-2)
