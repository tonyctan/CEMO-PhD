#######Loading packages
library(ggplot2)
library(reshape2)

#### after looking through the different datasets:
data()
#### Choosing the tips dataset from reshape2 package:
View(tips)
######Making the graph:
ggplot(tips,aes(day,tip,fill=smoker))+
  geom_boxplot()+
  facet_grid(~smoker)

###After making the first draft of the graph, i saw that both the days, and the facets with smokers is not in the order i want, luckily this is easy to fix.
tips$day_new<-factor(tips$day,levels = c("Thur","Fri","Sat","Sun"))
tips$smoker_new<-factor(tips$smoker,levels = c("Yes","No"))

###Making the graph again, to make sure that it is in the order i want, before I make the labels.
EXAM<-ggplot(tips,aes(day_new,tip))+
  geom_boxplot()+
  facet_grid(~smoker_new)
EXAM+stat_boxplot(geom = "errorbar",width=0.15)+
  ylab("Tips in USD")+
  xlab("Days")+
  ggtitle("Tipping in a restaurant", subtitle = "Smokers?")+
  theme(plot.subtitle =  element_text(hjust = 0.5))  ####Made the subtitle centered in the graph, so that it would be easier to see what it responds to.



  