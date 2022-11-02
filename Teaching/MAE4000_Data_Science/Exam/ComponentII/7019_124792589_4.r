# [Portfolio] Component II: Data Visualization_Graphic Design 


# Loading all packages, the data frame Cars93 is built in MASS package. 
library(ggplot2)
library(ggrepel)
library(MASS)


# Create a separate data.frame with outliers found using the level of 1.5*IQR
out <- aggregate(MPG.city~DriveTrain,data=Cars93,FUN=function(x){
  c(IQR(x),Q1=quantile(x,.25),Q3=quantile(x,.75))})
out <- do.call(data.frame,out)
names(out)[-1] <- c("IQR","Q1","Q3")
Cars_93 <- merge(Cars93,out,all.x=TRUE)
Cars_93$Flag <- (Cars_93$MPG.city < (Cars_93$Q1-1.5*Cars_93$IQR))|(Cars_93$MPG.city > (Cars_93$Q3+1.5*Cars_93$IQR))
out <- Cars_93[which(Cars_93$Flag),]


# using ggplot2 to construct boxplots 
ggplot(data = Cars_93, aes(x=factor(DriveTrain), y=MPG.city,fill=DriveTrain))+
  stat_boxplot(geom = "errorbar", width = 0.3) +
  geom_boxplot(outlier.colour = "red",
               outlier.size = 1.5, outlier.shape = 9)+
  geom_jitter(width = 0.06, height = 0.04, size = 0.5, alpha = 0.3)+
  facet_wrap(~factor(Origin))+
  labs(title = "Comparison of MPG.city of Different Drivetrain Types",
       x="Drivetrain Type", y="City MPG (miles per US gallon by EPA rating)")+
  geom_text_repel(data = out, label = out$Make, hjust = -0.25,vjust=0.55, size=2.8)+
  scale_fill_grey(start = 0.6, end = 1)+
  theme(axis.title = element_text(size = 10),axis.text = element_text(size = 9),
        legend.position = "none")




