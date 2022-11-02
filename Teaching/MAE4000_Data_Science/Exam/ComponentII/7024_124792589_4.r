#Graph

library(ggplot2)

co2 <- CO2
#First Assigning the graph to an object called "graph".
#Then choosing data frame - co2
#Further, setting the conc variable as the x-axis and uptake variable as the y-axis.
#Then setting the colors of the dots to be separated based on the treatment variable.
graph <- ggplot(data = co2, aes(x = conc, y=uptake, color=Treatment))+
#Changing the background and grid to black and white.
  theme_bw()+
#Choosing scatter plot.
  geom_point()+ 
#Dividing the data into two facet based on the variable Type - indicating origin of the plants.
  facet_grid(cols = vars(Type))+ 
#Starting both axes on 0.
  expand_limits(x = 0, y = 0)+
#Changing the labels of the axes.
  labs(x = "Concentration of CO2", y = "CO2 Uptake")+
#Making the font size of the axes-titles 12 and choosing the font.
  theme(
    axis.title.x = element_text(size = 12, family = "serif"),
    axis.title.y = element_text(size = 12, family = "serif")
  )

#Printing the graph.
graph
