#Installing/loading required packages
library(ggplot2)
install.packages("car")
library(car)
data("Salaries")

#creating variable to use as label later on
salary_labels= c("0K","50K", "100K", "150K","200K","250K")

#R script for graphic design
ggplot(data=Salaries, aes(x=rank, y=salary, fill=rank))+
stat_boxplot(geom="errorbar",width=0.5)+
geom_boxplot(stat="boxplot", outlier.colour="#ff0000",outlier.size=1.5,outlier.shape=8,na.rm=T)+
facet_wrap(.~ sex)+
theme_bw()+
labs(x="Teaching Rank", y="Salary($)", title="Academic Salaries (2008-09)",subtitle="Classified by Rank and Gender")+
scale_fill_discrete(name="Teaching Rank",labels=c("Assistant Professor", "Associate Professor", "Professor"))+
scale_y_continuous(breaks=seq(0,250000,50000), labels=salary_labels)+
theme(axis.text.x=element_text(angle=30, vjust=1,hjust=1))