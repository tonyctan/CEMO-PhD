# f=c*9/5+32
# c=(f-32)*5/9
# c and f both represent temperatures (temp)
# if the argument convert equals 0 then it will convert the temp from Fahrenheit to Celsius
# if the argument convert equals 1 then it will convert the temp from Celsius to Fahrenheit

degrees_convert <- function(temp, convert = 0) {
  out <- ((temp - 32) * 5 / 9)^(1 - convert) * (temp * 9 / 5 + 32)^(convert)
  return(out)
}


# if the given temp is 20 degrees Fahrenheit, the output given by the function is -6.666667 degrees Celsius
degrees_convert(temp = 20)

# if the given temp is 20 degrees Celsius, the output given by the function is 68 degrees Fahrenheit
degrees_convert(temp = 20, convert = 1)
