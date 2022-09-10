library(data.table)
library(readr)
install.packages("tidyverse")
library(tidyverse)
RTdata2<-read.csv("C:/Users/Eier/Documents/MAE4000/data/RTdata.CSV",, header = TRUE, sep = ";", quote = "\"",
                  dec = ".", fill = TRUE, comment.char = "")
view(RTdata2)
library(tidyr)
##Split and copying column 
RTdata3<-separate(RTdata2,col = Group,into = c("Other","Gender","BE"),sep = "_")
view(RTdata3)
RTdata4 <- RTdata3%>%
    mutate(Language=Gender)
    view(RTdata4)      
RTdata5<-separate(RTdata4,col = Gender,into = c("Gender1","Unn"),sep = "")
View(RTdata5)
RTdata6 <- RTdata5%>%
  mutate(Gender=Unn,Person=ID)
## Delete Column
library(dplyr)
Col_remove<-c("Other","Gender1","Unn","BE")
RTdata7<- RTdata6%>%
  select(- one_of(Col_remove))
view(RTdata7)
RTdata8<-RTdata7
## Assign values to column 
RTdata8<-RTdata8%>%mutate(Gender=replace(Gender,Gender=="M",1))
RTdata8<-RTdata8%>%mutate(Gender=replace(Gender,Gender=="F",2))
RTdata8<-RTdata8%>%mutate(Gender=replace(Gender,Gender=="U",NA))
view(RTdata8)
##wide to long(NOT WORKING THOUGH)
install.packages("reshape2")
library(reshape2)
LRTdata<-RTdata8
LRTdata=reshape(RTdata8,direction="long",idvar="ID","Language","Gender","Person",varying=list(c([,1:21])))
LRTdata=reshape(RTdata8,direction="long",varying=list(c(1:21)))
write.table(RTdata8,"C:/Users/Eier/Documents/MAE4000/data/exportedRTdata.txt",)
##Y data
library("readxl")
Ydata<-read_excel("C:/Users/Eier/Documents/MAE4000/data/Ydata.xlsx", col_names = TRUE,trim_ws = TRUE,na="")
str(Ydata)
Ydata1<-as.data.frame(Ydata)
names(Ydata1)
str(Ydata1)
library(tidyverse)
