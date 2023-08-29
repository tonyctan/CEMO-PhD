# function to convert temperatures
# temp is the degree value.
# to convert celsius to fahrenheit, set c2f as 1, and f2c as 0
# to convert fahrenheit to celsius, set c2f as 0, and f2c as1
degconv <- function(temp, c2f = 1, f2c = 0) {
  out <- (c2f * (temp * 9 / 5 + 32)) + (f2c * ((temp - 32) * 5 / 9))
  return(out)
}

# call converting celsius to fahrenheit
degconv(temp = 30, c2f = 1, f2c = 0)

# call converting fahrenheit to celsius
degconv(temp = 40, c2f = 0, f2c = 1)
