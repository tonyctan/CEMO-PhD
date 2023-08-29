# In this code you have to use "" around the text
# to make sure that R knows it is text :)
convert_temp <- function(temp, unit) {
  if (unit == "f") {
    print(9 * temp / 5 + 32)
  } else {
    print(5 * (temp - 32) / 9)
  }
}
# Here are two example calls
convert_temp(37, "c")
convert_temp(55, "f")
