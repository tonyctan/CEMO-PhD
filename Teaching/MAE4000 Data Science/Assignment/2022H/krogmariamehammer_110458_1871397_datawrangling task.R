#installing package to be able to open excel data
#install.packages("readxl")
library("readxl")


#importing both datasets
Ydata <- read_excel("data/Ydata.xlsx")
RTdata<-read.table("data/RTdata.csv", header=T,sep=";")


#installing package to be able to reshape data sets from wide to long format
#install.packages("reshape2")
library("reshape2")

#using the function melt to reshaping the data sets into long format with the variable desired
longY<-melt(Ydata,
            id.vars = c("ID"))
longRT<-melt(RTdata,
             id.vars = c("ID"))

#creating a smaller dataframe with gender and language
GenderLanguage<-melt(RTdata,
             id.vars = c("Group","ID"))
names(GenderLanguage)=c("ikke","Gender","ikke2","ID")
library("tidyr")
GenderLanguage2=GenderLanguage%>%
  separate(ikke,c("1","denne","3"),"_")


#splitting up the variables
library("stringr")
GenderLanguage2$hei=str_sub(GenderLanguage2$denne,-2)

#Removing the language from the variable with genders 
GenderLanguage2$denne<-gsub("FR","",as.character(GenderLanguage2$denne))
GenderLanguage2$denne<-gsub("NL","",as.character(GenderLanguage2$denne))

#changing the names 
#install.packages("dplyr")
library(tidyverse)
GenderLanguage3=rename(GenderLanguage2,feil=Gender)
GenderLanguage4=rename(GenderLanguage3,Gender=denne)
GenderLanguage5=rename(GenderLanguage4,Language=hei)

#Making the final dataset for gender, language and ID
GenderLanguageCorrect<-melt(GenderLanguage5,
            id.vars = c("ID","Gender","Language"))


#changing the names to match, so both are called items
#install.packages("dplyr")
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

#creating the subscore variable for Ydata
Ydata$P1=Ydata$Item_1+Ydata$Item_2+Ydata$Item_3+Ydata$Item_4
Ydata$P2=Ydata$Item_5+Ydata$Item_6+Ydata$Item_7+Ydata$Item_8
Ydata$P3=Ydata$Item_9+Ydata$It_10+Ydata$It_11+Ydata$It_12
Ydata$P4=Ydata$It_13+Ydata$It_14+Ydata$It_15+Ydata$It_16
Ydata$P5=Ydata$It_17+Ydata$It_18+Ydata$It_19+Ydata$It_20
Ydata$P6=Ydata$It_21

Ydata<-melt(Ydata,
id.vars = c("ID","P1","P2","P3","P4","P5","P6"))

#creating the subscore variable for RTdata
RTdata$P01=RTdata$Time01+RTdata$Time02+RTdata$Time03+RTdata$Time04
RTdata$P02=RTdata$Time05+RTdata$Time06+RTdata$Time07+RTdata$Time08
RTdata$P03=RTdata$Time09+RTdata$Time10+RTdata$Time11+RTdata$Time12
RTdata$P04=RTdata$Time13+RTdata$Time14+RTdata$Time15+RTdata$Time16
RTdata$P05=RTdata$Time17+RTdata$Time18+RTdata$Time19+RTdata$Time20
RTdata$P06=RTdata$Time21

RTdata<-melt(RTdata,id.vars = c("ID","P01","P02","P03","P04","P05","P06"))

#creating the totalscore 
longY$totalY<-rowSums((Ydata[2:6]))
longRT$totalRT<-rowSums((RTdata[2:6]))

#Merging the datasets
Merged=merge(longY,longRT,GenderLanguageCorrect,by.x =  "ID",by.y = "Item",all = TRUE)


#setting the correct order
finished=Merged[,c(1,9,10,2,6,4,7,3,8,5)]
