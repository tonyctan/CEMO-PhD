FtoC <- function(temperature, F2C = 0) {
  out <- ((temperature - 32) * 5 / 9)^(1 - F2C) * (temperature * 9 / 5 + 32)^(F2C)
  return(out)
}
# converts from fahrenheit to celsius:
FtoC(100, 0)

# converts from celsius to fahrenheit:
FtoC(100, 1)
