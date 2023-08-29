# Assignment

# Function that converts degrees Celsius to Fahrenheit
# and vice versa with given equations.

# will use 'x' argument for number of degrees
# 'unit' for temperature scale, Celsius or Fahrenheit

convertDegrees <- function(x, unit) {
  if (unit == "F") {
    out <- (x - 32) * 5 / 9 # Fahrenheit to Celsius
    converted_into <- "C"
  } else if (unit == "C") {
    out <- x * 9 / 5 + 32 # Celsius to Fahrenheit
    converted_into <- "F"
  } else {
    stop("Unit not available. Use 'C' for Celsius or 'F' for Fahrenheit.")
  }

  return(paste(x, unit, "equals", out, converted_into))
}

# Examples of usage

convertDegrees(x = 50, "F") # Fahrenheit to Celsius
convertDegrees(x = 10, "C") # Celsius to  Fahrenheit
