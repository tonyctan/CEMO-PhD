FahrCels <- function(Fahr = 32, Cels = -17.7777778) {
  out <- (Cels * 9 / 5 + 32) + ((Fahr - 32) * 5 / 9)

  if (Fahr == 32) {
    print(paste(round(out), "degrees in Fahrenheit"))
  }
  if (Cels == (-17.7777778)) {
    print(paste(round(out), "degrees in Celsius"))
  }
  return(round(out, 1))
}

# from Celsius to Fahrenheit

FahrCels(Cels = 100)
FahrCels(Cels = -15)
FahrCels(Cels = 0)

# from Fahrenheit to Celsius
FahrCels(Fahr = 100)
FahrCels(Fahr = -15)
FahrCels(Fahr = 0)
