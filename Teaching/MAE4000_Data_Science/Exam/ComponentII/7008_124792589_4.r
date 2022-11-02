####install required packages
library("ggplot2")

rm(list=ls(all =TRUE))
setwd("/Users/28611/Desktop/MAE4000/data")

#load the built-in dataset "Orange" in R
data("Orange")
head(Orange)
?Orange 
#the Orange data frame has 35 rows and 3 columns of records of the growth of orange trees.
#the variable Tree is ordered according to increasing maximum diameter.

#calculating the average circumference across different trees at different ages
avg_circumference = aggregate(circumference~age, data=Orange, mean)
colnames(avg_circumference) = c("age","avg_circumference")
#merge the average circumference information with the original data
data = merge(Orange, avg_circumference, by = c("age"))



#plot a line chart to show the relationship between tree's age and circumference, facet by tree
g=ggplot(data, aes(x=age)) +
  geom_point(aes(y=avg_circumference, colour = "Average circumference"), colour="grey",size=1.5) +
  geom_line(aes(y=avg_circumference,  colour = "Average"), colour="grey",size=0.75) + #lines and points of the average level
  geom_point(aes(y=circumference), size=1.5) +
  geom_line(aes(y=circumference,  colour = "The tree"), size=0.75) + #lines and points of the tree
  scale_color_manual(values = c("The tree"="black", "Average"="grey")) + #for setting legends
  ylim(0, 225) + #force the y-axis to start from 0
  coord_fixed(ratio = 400/50) + #fix the scale
  facet_wrap(~Tree, labeller = label_both) + #facet by tree
  labs(x="Tree age (days since 1968/12/31)", y = "Trunk circumference (mm)", title = "Growth of Orange Trees") +
  theme_bw(base_size=12, base_family='Times New Roman') + #themes
theme(
  plot.title = element_text(margin = margin(b = 24), face="bold", hjust = 0.5),
  axis.title = element_text(face = "bold"),
  axis.title.y = element_text(margin = margin(r = 12)),
  axis.title.x = element_text(margin = margin(t = 12)),
  axis.line = element_line(),
  legend.position = c(0.85, 0.2), #adjust the legend position
  legend.title = element_blank(), #remove the legend label
  panel.grid.major.x = element_blank(),
  panel.grid.minor.x = element_blank())

g

