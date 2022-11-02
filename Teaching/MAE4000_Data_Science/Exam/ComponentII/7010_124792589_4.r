library(ggrepel)
library(gridExtra)
library(plyr)
library(ggplot2)
library(tidyverse)


data <- read.table (file = "C:/Users/PAB/Desktop/MAE/SEM 1/MAE 4000/data/mtcars.txt", sep=';', header=TRUE)

#Change binary values to factors
data$am<-as.character(data$am)
data$am[which(data$am=="0")] <- "Automatic"
data$am[which(data$am=="1")] <- "Manual"
data$am<-as.factor(data$am)

# Plot axes and variables
Plot <- ggplot(data = data, aes(x = mpg, y = wt))+ 
  #size of points
  geom_point(size = 2)+
  
  #plot regression line and CI, fill color and size of line
  geom_smooth(method='lm', formula= y~x, level = 0.95, fill='lightblue', size= 0.3,aes(color = "Reg.line*"))+
  scale_color_manual(name = "Regression*",values = c("Reg.line*" = "darkgreen"))+
  
  # Create facets for transmission variable
  facet_wrap(.~am, scales = "free", ncol=1)+
 
   #add Chart labels 
  labs(title = '',
       x = "Weight of the car",
       subtitle = "Heatmap by number of cylinders",
       y = "Miles Per Gallon")+
  
  #Remove background panel
  #Make axis line stronger
  theme(panel.background = element_blank())+
  theme(axis.line = element_line(colour = "black"))+
theme(strip.background = element_rect(color="black",  size=1, linetype="solid"))+
  
  #Change axis text size
theme(axis.title = element_text(size = 10),
  axis.text = element_text(size = 10))
  


Plot

