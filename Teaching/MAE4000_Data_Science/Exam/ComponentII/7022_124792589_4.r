
#visualization pacages needed
#install.packages(c("ggrepel","gridExtra","mdthemes"))
library(dplyr)
library(ggplot2)
library(tidyverse)
library("ggrepel")
library("gridExtra")
library(ggrepel)
library(gridExtra)
library(mdthemes)

#import data set
mtcars=read.table(file = "../exam/mtcars.txt", header = T, sep = ";", dec = ".")

str(mtcars)
?mtcars
names(mtcars)
#mpg	Miles/(US) gallon, cyl	Number of cylinders,wt	Weight (1000 lbs),vs	Engine (0 = V-shaped, 1 = straight)

#geom_box plot 

mtcars
z=ggplot(data = mtcars, aes(x = as.factor(am), y =wt,fill=as.factor(cyl))) +
  stat_boxplot(geom = "errorbar", width = 0.5, na.rm = T) +
  geom_boxplot(stat = "boxplot", fill="#cccccc", outlier.colour = "#ff0000", outlier.size = 1.5, outlier.shape = 8, na.rm = T)+
  facet_wrap(.~cyl, scales = "free",labeller = label_both)+
  labs(title = (""), 
       subtitle = "", 
       caption="*Dataset; mtcars*",
       names=c("Automatic","Manual"),
       x = "Mode of Transmision", 
       y = "Weight (1000 lbs)")+
  theme(
    caption = element_text(size = 8),
    axis.title = element_text(size = 8),
    axis.text = element_text(size = 8),
    axis.line = element_line(),
    legend.position = "right",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()) 

z+scale_x_discrete(labels = c('Automatic ','Manual'))+
  mdthemes::md_theme_classic() +
  labs(title = "", )


#rm(list=ls(all =TRUE))
