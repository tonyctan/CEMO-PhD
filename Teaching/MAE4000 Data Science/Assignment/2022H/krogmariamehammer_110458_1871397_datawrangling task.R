#installing package to be able to open excel data

install.packages("readxl")
library("readxl")

#importing both datasets
Ydata <- read_excel("data/Ydata.xlsx")
RTdata<-read_excel("data/RTdata.xlsx")

#installing package to be able to reshape data sets from wide to long format
install.packages("reshape2")
library("reshape2")

#using the function melt to reshaping the data sets into long format with the variable desired
longY<-melt(Ydata,
            id.vars = c("ID"))
longRT<-melt(RTdata,
             id.vars = c("ID"))



#changing the names to match, so both are called items
install.packages("dplyr")
library(tidyverse)
rename(longY,item=variable)
rename(longRT,item=variable)

#Changing the values from literal to numeric
library(dplyr)
longRT <- longRT %>%
  mutate(variable = recode(variable, Time01 = '01', Time02 = '02', Time03 =  '03' ,Time04 = '04', Time05 = '05', Time06 =  '06' ,Time07 = '07', Time08 = '08', Time09 =  '09' ,Time10 = '10', Time11 = '11', Time12 =  '12' ,Time13 = '13', Time14 = '14', Time15 =  '15' ,Time16 = '16', Time17 = '17', Time18 =  '18' ,Time19 = '19', Time20 = '20', Time21 =  '21' ))

longY <- longY %>%
  mutate(variable = recode(variable, It_17 = '17', It_10 = '10', Item_9 =  '09' ,It_15 = '15', Item_5 = '05', Item_8 =  '08' ,Item_2 = '02', It_19 = '19', Item_6 =  '06' ,It_16 = '16', Item_3 = '03', It_11 =  '11' ,It_12 = '12', It_20 = '20', It_14 =  '14' ,It_13 = '13', Item_7 = '07', Item_1 =  '01' ,It_18 = '18', Item_4 = '04', It_21 =  '21' ))

#Renaming the variables 
names(longY)=c("ID","Item","Y")
names(longRT)=c("ID","Item","RT")

#Adding a new,problem, column in both datasets and 
longY$problem<-"value"
longRT$problem<-"value"

Ydata$P1=Ydata$Item_1+Ydata$Item_2+Ydata$Item_3+Ydata$Item_4
Ydata$P2=Ydata$Item_5+Ydata$Item_6+Ydata$Item_7+Ydata$Item_8
Ydata$P3=Ydata$Item_9+Ydata$It_10+Ydata$It_11+Ydata$It_12
Ydata$P4=Ydata$It_13+Ydata$It_14+Ydata$It_15+Ydata$It_16
Ydata$P5=Ydata$It_17+Ydata$It_18+Ydata$It_19+Ydata$It_20
Ydata$P6=Ydata$It_21

Ydata<-melt(Ydata,
            id.vars = c("ID","P1","P2","P3","P4","P5","P6"))
Ydata=Ydata[,c(1:7)]


#creating the totalscore 

Ydata$totalY<-rowSums((Ydata[2:6]))
longRT$totalRT<-colSums((longRT[3:3]))

                    
#merging the two datasets
merged=merge(Ydata,longRT)

merged=merged[,c(1:9)]


