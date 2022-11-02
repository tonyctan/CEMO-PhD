#exam 
#component II visualization

#install.packages('ggpubr')
library("dplyr")
library("ggplot2")
library("gridExtra")
library("ggrepel")
library("tidyverse")
library('ggpubr')
library(datasets)#predefined datasets
#library(help="datasets")#see datasets

#the dataset used is a predefined dataset here in R: 'infert'
View(infert)


infert3 <- infert[,c('parity','age','spontaneous')]#subsetting target variables
#changing the names of variables, so they appear in the graph
infert3$spontaneous <- gsub(pattern = 0, "spontaneous abortions = 0", infert3$spontaneous)
infert3$spontaneous <- gsub(pattern = 1, "spontaneous abortions = 1", infert3$spontaneous)
infert3$spontaneous <- gsub(pattern = 2, "spontaneous abortions = 2", infert3$spontaneous)


#representation
ggplot(data = infert3, aes(x = age, y = parity))+#draws the initial canvas with age as X and parity as Y axis
  facet_wrap(~spontaneous, strip.position = "top", nrow = 1) +#groups previous variables by the number of spontaneous abortions
  geom_point(colour = 'darkgray', size = 2) +#add datapoints in darkgray color 
  geom_smooth(method="lm", se=F, colour = 'black', fullrange=TRUE, size = 1)+#draws the line to express patterns
  theme_bw() +#light theme so the datapoints are easier to spot
  labs(title = "Age and parity", subtitle = "For women with different number of spontaneous abortions")+#adding title and subtitle
  theme(
    axis.title = element_text(size = 20),#title bigger to help getting main ideas
    axis.title.x = element_text(size = 10),#size of title for x axis
    axis.title.y = element_text(size = 10),#size of title for y axis
    plot.subtitle = element_text(face = 'italic'))+#adjusting the subtitle
  scale_x_continuous(name="Age (in years)", limits=c(20,45), breaks = seq(0,45, by = 5))+#label, limits and breaks for x axis
  scale_y_continuous(name="Parity", limits=c(1,6), breaks = seq(1,6, by = 1))+#label, limits and breaks for y axis
  labs(caption='Note: Parity refers to the number of times a woman has given birth to a baby of viable gestation. Disclaimer: This graph intends to be an initial visual exploration of possible patterns. Any claim about relationship between the variables \nshould be supported with solid theory and proper study design.')+
  theme(plot.caption=element_text(size=10, hjust=0, margin=margin(10,0,0,0)))

#This graphic intends to be a visual initial descriptive exploration of possible patterns, 
