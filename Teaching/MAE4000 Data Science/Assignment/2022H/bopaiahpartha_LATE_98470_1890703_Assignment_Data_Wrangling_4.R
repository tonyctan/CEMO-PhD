#install.packages('stringr')
#install.packages('tidyverse')
#install.packages('dplyr')
#install.packages('tidyr')
#install.packages(c('tibble','readr'))
library(stringr)
library(readxl)
library(readr)
library(tidyverse)
library('dplyr')
library('tidyr')

Itemlist <- paste("Item_", 1:21, sep = "")
#View(Itemlist)

Ydata <- read_excel("data/Ydata.xlsx")

View(Ydata)
str(Ydata)
colnames(Ydata)

names (Ydata)[names(Ydata)=='It_17']<-"Item_17"
names (Ydata)[names(Ydata)=='It_10']<-"Item_10"
names (Ydata)[names(Ydata)=='It_15']<-"Item_15"
names (Ydata)[names(Ydata)=='It_19']<-"Item_19"
names (Ydata)[names(Ydata)=='It_16']<-"Item_16"
names (Ydata)[names(Ydata)=='It_11']<-"Item_11"
names (Ydata)[names(Ydata)=='It_12']<-"Item_12"
names (Ydata)[names(Ydata)=='It_20']<-"Item_20"
names (Ydata)[names(Ydata)=='It_14']<-"Item_14"
names (Ydata)[names(Ydata)=='It_13']<-"Item_13"
names (Ydata)[names(Ydata)=='It_18']<-"Item_18"
names (Ydata)[names(Ydata)=='It_21']<-"Item_21"

Ydata$Prob1= rowSums(Ydata[,c('Item_1', 'Item_2', 'Item_3', 'Item_4')])
Ydata$Prob2= rowSums(Ydata[,c('Item_5', 'Item_6', 'Item_7', 'Item_8')])
Ydata$Prob3= rowSums(Ydata[,c('Item_9', 'Item_10', 'Item_11', 'Item_12')])
Ydata$Prob4= rowSums(Ydata[,c('Item_13', 'Item_14', 'Item_15', 'Item_16')])
Ydata$Prob5= rowSums(Ydata[,c('Item_17', 'Item_18', 'Item_19', 'Item_20')])
Ydata$Prob6= rowSums(Ydata[,c('Item_21')])

Ydata_long <- gather(Ydata, Items, Responses, Item_17:Item_21, factor_key=TRUE)
view(Ydata_long)
str(Ydata_long)
colnames(Ydata_long)

Ydata_long_Re=Ydata_long [,c("ID", "Items", "Responses", "Prob1", "Prob2", "Prob3", "Prob4", "Prob5", "Prob6")]
names (Ydata_long_Re)[names(Ydata_long_Re)=='Prob1']<-"Y.sub1"
names (Ydata_long_Re)[names(Ydata_long_Re)=='Prob2']<-"Y.sub2"
names (Ydata_long_Re)[names(Ydata_long_Re)=='Prob3']<-"Y.sub3"
names (Ydata_long_Re)[names(Ydata_long_Re)=='Prob4']<-"Y.sub4"
names (Ydata_long_Re)[names(Ydata_long_Re)=='Prob5']<-"Y.sub5"
names (Ydata_long_Re)[names(Ydata_long_Re)=='Prob6']<-"Y.sub6"

View(Ydata_long_Re)
str(Ydata_long_Re)
colnames(Ydata_long_Re)
summary(Ydata_long_Re)

names (Ydata_long_Re)[names(Ydata_long_Re)=='ID']<-"Person"
names (Ydata_long_Re)[names(Ydata_long_Re)=='Responses']<-"Y"
Ydata_long_Re$Item <- gsub("[^0-9]","",Ydata_long_Re$Items)

Ydata_long_Re$Item <- as.numeric(as.character(Ydata_long_Re$Item))
Ydata_long_Re$Problem <- (Ydata_long_Re$Item/4)
Ydata_long_Re$Problem <- ceiling (Ydata_long_Re$Problem)

Ydata_long_Re1=Ydata_long_Re [,c("Person" , "Item", "Problem", "Y","Y.sub1" , "Y.sub2" , "Y.sub3" , "Y.sub4" , "Y.sub5", "Y.sub6","Items")]
Ydata_long_Re1$Y.tot<- rowSums(Ydata_long_Re1[,c("Y.sub1", "Y.sub2","Y.sub3","Y.sub4","Y.sub5","Y.sub6")])
Ydata_long_Re1=Ydata_long_Re1 [,c("Person" , "Item", "Problem", "Y", "Y.tot","Y.sub1" , "Y.sub2" , "Y.sub3" , "Y.sub4" , "Y.sub5", "Y.sub6","Items")]

View(Ydata_long_Re1)
str(Ydata_long_Re1)
colnames(Ydata_long_Re1)

write.table(Ydata_long_Re1, file="data/Ydata_long_2022_09_12.dat", row.names=FALSE, sep="\t ", dec=".")
#---------------------------------------------------------------------------------------------------------------------------------------------------------

RTdata <- read.csv("data/RTdata.csv", sep = ";", header = TRUE)

View(RTdata)
str(RTdata)

grep('Gender',RTdata$Group, value =TRUE,invert =TRUE)
#Gender is part of all the entries in the column group

RTdata$Language=str_sub(RTdata$Group, -5,-4)
RTdata$Gender=str_sub(RTdata$Group, 8,-6)

names (RTdata)[names(RTdata)=='ID']<-"Person_RT"

RTdata$RT.Sub1= rowSums(RTdata[,c('Time01', 'Time02', 'Time03', 'Time04')])
RTdata$RT.Sub2= rowSums(RTdata[,c('Time05', 'Time06', 'Time07', 'Time08')])
RTdata$RT.Sub3= rowSums(RTdata[,c('Time09', 'Time10', 'Time11', 'Time12')])
RTdata$RT.Sub4= rowSums(RTdata[,c('Time13', 'Time14', 'Time15', 'Time16')])
RTdata$RT.Sub5= rowSums(RTdata[,c('Time17', 'Time18', 'Time19', 'Time20')])
RTdata$RT.Sub6= RTdata[,'Time21']

RTdata_long$Gender[RTdata$Gender=='Unknown'] <- 'NA'

RTdata_long <- gather(RTdata, Items, RT, Time01:Time21, factor_key=TRUE)
RTdata_long$Item_RT<-as.numeric(gsub(".*?([0-9]+).*", "\\1", RTdata_long$Items)) 
RTdata_long$Problem_RT <- (RTdata_long$Item_RT/4)
RTdata_long$Problem_RT <- ceiling (RTdata_long$Problem_RT)


RTdata_long$Y.tot<- rowSums(RTdata_long[,c("RT.Sub1", "RT.Sub2","RT.Sub3","RT.Sub4","RT.Sub5","RT.Sub6")])

View(RTdata_long)
str(RTdata_long)
summary(RTdata_long)


write.table(RTdata, file="C:/Users/PAB/Desktop/MAE/SEM 1/MAE 4000/data/RTdata_2022_09_12.csv", row.names=FALSE, sep="\t ", dec=".")
