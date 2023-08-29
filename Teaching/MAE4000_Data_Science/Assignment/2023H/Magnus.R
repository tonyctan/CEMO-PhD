conversion <- function(t, unit) {
  if (unit == "C") {
    return((t * 9 / 5) + 32)
  } else if (unit == "F") {
    return((t - 32) * 5 / 9)
  } else {
    return(NA)
  }
}

conversion(5, "C")
conversion(5, "F")

conversion(0, "C")
conversion(0, "F")

conversion(5, "t")
