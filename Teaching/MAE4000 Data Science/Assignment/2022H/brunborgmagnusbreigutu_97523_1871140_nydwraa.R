###loading packages
library(reshape2)
library(readxl)
library(tidyr)
library(tidyverse)


#####import Ydata and RTdata
####the imported Ydata is a tibble, making it a data.frame:

RTdataG= read.table(file = "../Data/RTdata.csv",header = TRUE,sep = ";",dec = ",")
Ydata<-read_excel("../Data/Ydata.xlsx")

Ydata1=as.data.frame(Ydata)

RTdata1=RTdata[,c("ID","Time01","Time02","Time03","Time04","Time05","Time06","Time07","Time08","Time09",
                  "Time10","Time11","Time12","Time13","Time14","Time15","Time16","Time17","Time18","Time19","Time20","Time21")]

LongY=reshape(Ydata1,direction = "long",idvar = "ID","Y","Item",
              varying = list(c("Item_1","Item_2","Item_3","Item_4","Item_5","Item_6","Item_7","Item_8","Item_9",
                               "It_10","It_11","It_12","It_13","It_14","It_15","It_16","It_17","It_18","It_19","It_20","It_21")))
LongRT=reshape(RTdata2,direction = "long",idvar =  "ID","RT","Item",
               varying = list(c("Time01","Time02","Time03","Time04","Time05","Time06","Time07","Time08","Time09",
                                "Time10","Time11","Time12","Time13","Time14","Time15","Time16","Time17","Time18","Time19","Time20","Time21")))
###########check for duplicates in the RTdata and removing them.

RTdata2<-RTdata1 %>%distinct(ID,.keep_all = TRUE)

RTdataG1<-RTdataG %>% distinct(ID,.keep_all = TRUE)
####Problem variable

LongY<- LongY%>%
  mutate(Problem=case_when(Item<5~"1",
                           Item<9~"2",
                           Item<13~"3",
                           Item<17~"4",
                           Item<21~"5",
                           Item<22~"6"))
LongRT<-LongRT%>%
  mutate(Problem=case_when(Item<5~"1",
                           Item<9~"2",
                           Item<13~"3",
                           Item<17~"4",
                           Item<21~"5",
                           Item<22~"6"))


####creating subscoreset on Ydata1
Ydata1$Y.sub1<-rowSums(Ydata1[,c(8,12,19,21)])
Ydata1$Y.sub2<-rowSums(Ydata1[,c(6,10,7,18)])
Ydata1$Y.sub3<-rowSums(Ydata1[,c(4,3,13,14)])
Ydata1$Y.sub4<-rowSums(Ydata1[,c(17,16,11,5)])
Ydata1$Y.sub5<-rowSums(Ydata1[,c(2,20,15,9)])
Ydata1$Y.sub6<-rowSums(Ydata1[c(22, drop=FALSE)])

####Making a smaller dataset with ID, and the 6 subscores.
Ysub=Ydata1[,c("ID","Y.sub1","Y.sub2","Y.sub3","Y.sub4","Y.sub5","Y.sub6")]


####creating subscoreset on RTdata
RTdata2$RT.sub1<-rowSums(RTdata2[,c(2:5)])
RTdata2$RT.sub2<-rowSums(RTdata2[,c(6:9)])
RTdata2$RT.sub3<-rowSums(RTdata2[,c(10:13)])
RTdata2$RT.sub4<-rowSums(RTdata2[,c(14:17)])
RTdata2$RT.sub5<-rowSums(RTdata2[,c(18:21)])
RTdata2$RT.sub6<-rowSums(RTdata2[c(22,drop=FALSE)])

####Making dataset with RTsub
RTsub=RTdata2[,c("ID","RT.sub1","RT.sub2","RT.sub3","RT.sub4","RT.sub5","RT.sub6")]


#####Long formats with longRTsub, and longYsub:

longRTsub=reshape(RTsub,direction = "long",idvar ="ID", "RT.sub","Problem",varying = list(c("RT.sub1","RT.sub2","RT.sub3","RT.sub4","RT.sub5","RT.sub6")))
LongYsub=reshape(Ysub,direction = "long",idvar = "ID","Y.sub","Problem", varying = list(c("Y.sub1","Y.sub2","Y.sub3","Y.sub4","Y.sub5","Y.sub6")))

####Creating totalscore variable:
Ydata1$Y.tot<-rowSums(Ydata1[,c(2:22)])
RTdata2$RT.tot<-rowSums(RTdata2[,c(2:22)])

####Smaller dataset with only Y.tot and ID variable

Y.total=Ydata1[,c("ID","Y.tot")]

####Smaller dataset with only RT.tot and ID variable
RT.total=RTdata2[,c("ID","RT.tot")]

##### RTgroup, gender variable

Group1=RTdataG1[,c("ID","Group")]

#####slicing splitting Group

RTdataG69<- cbind(RTdataG69[-3],                   t(as.data.frame(strsplit(RTdataG69$Group, '_'),                                                row.names=c("Group1", "Group2","Group3"))), row.names=NULL)

TOTGRUPPE<-RTdataG69 %>% separate(Group2,into = c("Gender","Language"),sep = -2,convert = TRUE)

TOTGRUPPE1=TOTGRUPPE[,c("ID","Gender","Language")]

######New LongRT without group

LongRT1=LongRT[,c("ID","RT","Problem")]


####Merging


RTYlong=merge(LongRT,LongY)

Ysubtot=merge(Y.total,LongYsub,by="ID")


RTsubtot=merge(RT.total,longRTsub,by="ID")


SUBTOT=merge(Ysubtot,RTsubtot)

TOTAL=merge(RTYlong,SUBTOT)

DONEASSIGNMENT2=merge(TOTAL,TOTGRUPPE1)

############EXPORTING
write.table(DONEASSIGNMENT2,file = "../Data/DONEASSIGNMENT2-exported.txt",row.names = TRUE,sep = ".t",col.names = NA)

