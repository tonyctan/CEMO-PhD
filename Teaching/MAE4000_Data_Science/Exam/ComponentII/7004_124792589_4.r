# Portfolio Exam C2 

library(ggplot2) # Standard plotting package
library(gridExtra) # Extra package to help with multiple panels 
library(grid) # Adding titles to "gridExtra"
library(dplyr) # Dplyr for mean calculations 

#Panel 1, Fuel consumption by weight
Plot1 <- ggplot(data=mtcars, mapping = aes(x = wt, y = mpg)) + # mtcars
  geom_point(aes(color = mpg),size = 4) + # Adds dots, color and rearranges size of dots 
  theme_bw() + # adds background grids 
  scale_y_reverse() + # Reverses the y-axis so that it matches panel 3
  ggtitle("Fuel consumption by weight") + # title
  xlab("Weight in pounds (thousands)") + #x-axis label
  ylab("Miles per gallon") + #y-axis label
  xlim(NA,6) # Changes the x-axis to get more data points on the axis

#Panel 2, Fuel consumption by horsepower
Plot2 <- ggplot(data=mtcars, mapping = aes(x = hp, y = mpg)) + #mtcars
  geom_point(aes(color = mpg),size = 4) + # Adds dots, color and rearranges size of dots 
  theme_bw() + # adds background grids 
  scale_y_reverse() + # Reverses the y-axis so that it matches panel 3
  ggtitle("Fuel consumption by horsepower") + # title
  xlab("Horsepower") + #x-axis label
  ylab("Miles per gallon") + #y-axis label
  xlim(NA,350) # Changes the y-axis by "zooming" in a bit 

#Panel 3, Fuel consumption by weight and horsepower
Plot3 <- ggplot(data=mtcars, mapping = aes(x = hp, y = wt)) + #mtcars
  geom_point(aes(color = mpg),size = 4) + # Adds dots, color and rearranges size of dots 
  theme_bw() +# adds background grids 
  ggtitle("Fuel consumption by weight and horsepower") + # title
  ylab("Weight in pounds (thousands)") + #y-axis label
  xlab("Horsepower") + #x-axis label
  ylim(NA,6) + # Matches the length ofo the variable from panel 1
  xlim(NA,350) # Matches the length ofo the variable from panel 2

grid.arrange(Plot1, Plot2, Plot3, nrow = 2, # Arranges the stated plots into a single graphic
             top = textGrob("Fuel consumption, possible indicators of very fuel efficient cars", #Title
               gp=gpar(fontsize=12,font=3))) #Adjusts titles font and font-size 
             

