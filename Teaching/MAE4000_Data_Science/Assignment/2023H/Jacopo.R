gradeconverter <- function(n, t) {
  if (t == "c") {
    return(n * 1.8 + 32)
  }
  if (t == "f") {
    return((n - 32) * 5 / 9)
  }
}

gradeconverter(50, "f")

gradeconverter(10, "c")
