# Assignment 1
# Function
CtoF <- function(C = -17.7777777778, F = 32) {
  out <- ((F - 32) * (5 / 9)) + (C * (9 / 5) + 32)
  return(out)
}

# Examples
# Turning Celsius to Fahrenheit
CtoF(C = 1)

CtoF(C = 0)

CtoF(C = 100)

# Turning Fahrenheit to Celsius
CtoF(F = 45)

CtoF(F = 0)

CtoF(F = 100)
