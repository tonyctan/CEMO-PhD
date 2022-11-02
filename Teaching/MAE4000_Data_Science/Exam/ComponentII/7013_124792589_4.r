library(tidyverse)
library(ggrepel)
data_starwars <- starwars
table(data_starwars$mass)
table(data_starwars$species)
data_starwars <-data_starwars[!is.na(data_starwars$mass) & !is.na(data_starwars$height) & !is.na(data_starwars$species), ]
#recording some of the species to aliens. 
data_starwars$group_species <- "Aliens"
data_starwars$group_species <- ifelse(data_starwars$species=="Human","Human",data_starwars$group_species)
data_starwars$group_species <- ifelse(data_starwars$species=="Droid","Droid",data_starwars$group_species)
table(data_starwars$group_species)
data_starwars$BMI <- round(data_starwars$mass/(data_starwars$height/100)**2,1)
Jabba <- data_starwars[data_starwars$name=="Jabba Desilijic Tiure",]

#To name the outliers.
out = aggregate(BMI~group_species,data=data_starwars[data_starwars$BMI<100,],FUN=function(x){c(IQR(x,na.rm=TRUE),Q1=quantile(x,.25,na.rm=TRUE),Q3=quantile(x,.75,na.rm=TRUE))})
out = do.call(data.frame,out)
names(out)[-1]=c("IQR","Q1","Q3")
data_starwars=merge(data_starwars[data_starwars$BMI<100,],out,all.x=TRUE)
data_starwars$Flag = (data_starwars$BMI < (data_starwars$Q1-1.5*data_starwars$IQR))|(data_starwars$BMI > (data_starwars$Q3+1.5*data_starwars$IQR))
out = data_starwars[which(data_starwars$Flag),]






ggplot(data_starwars[data_starwars$BMI<100,], aes(x=group_species, y=BMI)) + 
  stat_boxplot(geom = "errorbar", width = 0.5, na.rm = T, color="black") +
  geom_rect(aes(xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=18.5), alpha=0.1,  fill="#F2D7D5")+
  geom_rect(aes(xmin=-Inf, xmax=Inf, ymin=18.5, ymax=25), alpha=0.1,  fill="#E6B0AA")+
  geom_rect(aes(xmin=-Inf, xmax=Inf, ymin=25, ymax=30), alpha=0.1,  fill="#CD6155")+
  geom_rect(aes(xmin=-Inf, xmax=Inf, ymin=30, ymax=35), alpha=0.1,  fill="#A93226")+
  geom_rect(aes(xmin=-Inf, xmax=Inf, ymin=35, ymax=Inf), alpha=0.1,  fill="#7B241C")+
  geom_boxplot(stat = "boxplot", outlier.colour = "yellow", outlier.size = 1.5, outlier.shape = 8, na.rm = T,fill = "white") +
  labs(x = "Group of species", y = "BMI=Body Mass Index") +
  ggtitle("Obesity among Starwars characters")+ #The title was not included in the figure, because the writing program makes another title, and it is better with just one title in total.
  geom_text_repel(data = out, label = out$name, hjust = -0.35, color="green")+
  scale_y_continuous(breaks=seq(15,50,5))+
  theme(
    panel.background = element_rect(fill = "white",
                                    colour = "white",
                                    size = 0.5, linetype = "solid"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12),
    axis.line = element_line(),
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()) 

