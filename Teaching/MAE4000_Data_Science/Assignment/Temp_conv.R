# Task: Convert temperature between Celsius and Fahrenheit
temp_conv <- function(temp = 0, unit = "F") { # Default values
    # If user enters a temperature below absolute zero, return an error message
    if (temp < -273.15 && unit %in% c("C", "c")) { # Use set notation
        return(noquote("Temperature entered is below absolute zero."))
    } else if (temp < -459.67 && unit %in% c("F", "f")) {
        return(noquote("Temperature entered is below absolute zero."))
    # Convert celsius to fahrenheit
    } else if (unit %in% c("C", "c")) {
        return(noquote(paste(
            temp, "\u00B0C \u27F9 ", # Unicode for degree symbol: \u00B0
            round(temp * 9 / 5 + 32, 1), "\u00B0F",
            sep = ""
        )))
    # Convert fahrenheit to celsius
    } else if (unit %in% c("F", "f")) {
        return(noquote(paste(
            temp, "\u00B0F \u27F9 ", # Unicode for \Longrightarrow: \u27F9
            round((temp - 32) * 5 / 9, 1), "\u00B0C",
            sep = ""
        )))
    # All other cases, display an error message
    } else {
        return(noquote("Conversion requested is not supported by this function."))
    }
}

temp_conv()
temp_conv(100)
temp_conv(temp = 100)
temp_conv(unit = "C")
temp_conv(temp = -273.16, unit = "C")
temp_conv(temp = 100, unit = "F")
temp_conv(temp = 37, unit = "C")
temp_conv(temp = 273.15, unit = "K")
