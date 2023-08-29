# FIRST ASSIGNMENT
# Task: Design a single function that can convert degrees Celsius to degrees
# Fahrenheit and vice versa.

# Formula
# Degrees F to degrees C:
# C=(F−32)×5/9
# Degrees C to degrees F:
# F=C×9/5+32


# Using the function switch() To get multiple functions inside the function
?switch # Looking how to use it

convertTemperature <- function(x, unit) {
  converted <- switch(unit, # Switch choose one of the following arguments
    Celsius = (9 / 5) * x + 32, # Formula for fahrenheit to celsius
    Fahrenheit = (x - 32) * (5 / 9)
  ) # formula for celsius to fahrenheit
  return(converted) # return converted
}

# Testing celsius to fahrenheit
convertTemperature(37, "Celsius")

## Testing fahrenheit to celsius
convertTemperature(100, "Fahrenheit")
