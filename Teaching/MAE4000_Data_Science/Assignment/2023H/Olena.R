temp_converter <- function(f = NULL, c = NULL) {
  if (!is.null(f) && !is.null(c)) {
    out <- "You cannot define both Fahrenheit and Celsius values"
  } else if (!is.null(f)) {
    out <- (f - 32) * 5 / 9
  } else if (!is.null(c)) {
    out <- c * 9 / 5 + 32
  } else {
    out <- "Please provide either Fahrenheit or Celsius value"
  }
  return(out)
}

# Example 1:
temp_converter(c = 0)
# [1] 32

# Example 2:
temp_converter(f = 32)
# [1] 0

# Example 3:
temp_converter()
# [1] "Please provide either Fahrenheit or Celsius value"

# Example 4:
temp_converter(c = 100, f = 100)
# [1] "You cannot define both Fahrenheit and Celsius values"
