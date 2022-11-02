# ASSIGNMENT 2

#Loading data
rm(list=ls()) 
library(readxl)
library(stringi)
Ydata <- read_excel(path="./data/Ydata.xlsx", sheet="Sheet1", col_names =T)
str(Ydata)
RTdata <- read.table(file="./data/RTdata.csv", header=T, sep=";")
str(RTdata)

#STEP1


#Restructure the dataset in a long format with the following variables: Person Gender Language Item Problem Y RT Y.sub RT.sub Y.tot RT.tot.
#Restructuring Ydata first



longY<- reshape(data=Ydata, idvar="ID",
                    varying = c("Item_1", "Item_2","Item_3","Item_4","Item_5","Item_6","Item_7","Item_8","Item_9","It_10","It_12", "It_11","It_13","It_14","It_15","It_16","It_17","It_18","It_19","It_20","It_21"),
                    v.name=c("Y"),
                    times=c("Item_1", "Item_2","Item_3","Item_4","Item_5","Item_6","Item_7","Item_8","Item_9","It_10","It_11", "It_12", "It_13","It_14","It_15","It_16","It_17","It_18","It_19","It_20","It_21"),
                    new.row.names = 1:10600,
                    direction="long")
colnames(longY) = c("ID","Item", "Y")



longRT<- reshape(data=RTdata, idvar="ID",
                     varying = c("Time01", "Time02","Time03","Time04","Time05","Time06","Time07","Time08","Time09","Time10","Time11","Time12","Time13","Time14","Time15","Time16","Time17","Time18","Time19","Time20","Time21"),
                     v.name=c("RT"),
                     times=c("Time01", "Time02","Time03","Time04","Time05","Time06","Time07","Time08","Time09","Time10","Time11","Time12","Time13","Time14","Time15","Time16","Time17","Time18","Time19","Time20","Time21"),
                     new.row.names = 1:10600,
                     direction="long")
longRT$Group <- NULL
colnames(longRT) = c("ID","Item", "RT")

#Restructuring to long-format completed

#Reformatting so that Item variables are consistent

#Reformatting longY
longY$Itemz <- stri_sub(longY$Item,-2,-1 )
longY$Item <- NULL
longY <- longY[c("ID", "Itemz", "Y")]
colnames(longY) = c("ID","Item","Y")
longY$Item <- gsub("_","0", as.character(longY$Item))

#Reformatting longRT
longRT$Itemz <- stri_sub(longRT$Item,-2,-1 )
longRT$Item <- NULL
longRT <- longRT[c("ID", "Itemz", "RT")]
colnames(longRT) = c("ID","Item","RT")


#Adding a problem variable to both datasets
#First: turning the items numeric
longY$Item <- as.numeric(longY$Item)
longRT$Item <- as.numeric(longRT$Item)

longY$Problem <- ceiling(longY$Item/4)
longRT$Problem <- ceiling(longRT$Item/4)

#STEP2
#Computing subscores
#Starting with Y.sub

Ydata$Problem1=Ydata$Item_1+Ydata$Item_2+Ydata$Item_3+Ydata$Item_4 
Ydata$Problem2=Ydata$Item_5+Ydata$Item_6+Ydata$Item_7+Ydata$Item_8 
Ydata$Problem3=Ydata$Item_9+Ydata$It_10+Ydata$It_11+Ydata$It_12 
Ydata$Problem4=Ydata$It_13+Ydata$It_14+Ydata$It_15+Ydata$It_16 
Ydata$Problem5=Ydata$It_17+Ydata$It_18+Ydata$It_19+Ydata$It_20 
Ydata$Problem6=Ydata$It_21 

longYprob<- reshape(data=Ydata, idvar="ID",
                varying = c("Problem1", "Problem2","Problem3","Problem4","Problem5","Problem6"),
                v.name=c("subY"),
                times=c("Problem1", "Problem2","Problem3","Problem4","Problem5","Problem6"),
                new.row.names = 1:3000,
                direction="long")
longYprob <- longYprob[c("ID", "time", "subY")]
colnames(longYprob) = c("ID","Problem", "subY")
longYprob$Problem <- stri_sub(longYprob$Problem,-1,-1 )
longYprob$Problem <- as.numeric(longYprob$Problem)

RTdata$Problem1=RTdata$Time01+RTdata$Time02+RTdata$Time03+RTdata$Time04 
RTdata$Problem2=RTdata$Time05+RTdata$Time06+RTdata$Time07+RTdata$Time08 
RTdata$Problem3=RTdata$Time09+RTdata$Time10+RTdata$Time11+RTdata$Time12 
RTdata$Problem4=RTdata$Time13+RTdata$Time14+RTdata$Time15+RTdata$Time16 
RTdata$Problem5=RTdata$Time17+RTdata$Time18+RTdata$Time19+RTdata$Time20 
RTdata$Problem6=RTdata$Time21 

longRTprob<- reshape(data=RTdata, idvar="ID",
                    varying = c("Problem1", "Problem2","Problem3","Problem4","Problem5","Problem6"),
                    v.name=c("subRT"),
                    times=c("Problem1", "Problem2","Problem3","Problem4","Problem5","Problem6"),
                    new.row.names = 1:10000,
                    direction="long")
longRTprob <- longRTprob[c("ID", "time", "subRT")]
colnames(longRTprob) = c("ID","Problem", "subRT")
longRTprob$Problem <- stri_sub(longRTprob$Problem,-1,-1 )
longRTprob$Problem <- as.numeric(longRTprob$Problem)

#Creating totalscore dataset

#Creating  Y.tot first
Ydata$Y.tot=Ydata$Problem1+Ydata$Problem2+Ydata$Problem3+Ydata$Problem4+Ydata$Problem5+Ydata$Problem6  

longYtot<- reshape(data=Ydata, idvar="ID",
                    varying = c("Y.tot"),
                    v.name=c("Y.tot"),
                    times=c("Y.tot"),
                    new.row.names = 1:3000,
                    direction="long")
longYtot <- longYtot[c("ID","Y.tot")]


#Creating RT.tot
RTdata$RT.tot <- RTdata$Problem1+RTdata$Problem2+RTdata$Problem3+RTdata$Problem4+RTdata$Problem5+RTdata$Problem6
  
longRTtot<- reshape(data=RTdata, idvar="ID",
                   varying = c("RT.tot"),
                   v.name=c("RT.tot"),
                   times=c("RT.tot"),
                   new.row.names = 1:3000,
                   direction="long")
longRTtot <- longRTtot[c("ID","RT.tot")]

#Merging datasets

CombinedDataY <- merge(longYprob, longYtot , by="ID")
CombinedDataRT <- merge(longRTprob, longRTtot, by="ID")

CombinedDataSubTot <- merge(CombinedDataY, CombinedDataRT, by=c("ID" ,"Problem"))

CombineDataYRT <- merge(longY, longRT, by=c("ID" ,"Item", "Problem"))

CombineDataTotal <- merge(CombineDataYRT, CombinedDataSubTot, by=c("ID" , "Problem" ))


#OLA: Ser fra end result at gender og language skal v??re factors, husk dette
#str(RTdata) #Can see that information on gender and language can be found under the "group" collumn in RTdata. This will need to be splitt. 

RTdata$Gen <- RTdata$Group
RTdata$Gen <- stri_sub(RTdata$Group,1,11 )
RTdata$Gender <- ifelse(RTdata$Gen=="Gender_Male", "Male", 
                          ifelse(RTdata$Gen=="Gender_Fema", "Female",
                                 ifelse(RTdata$Gen=="Gender_Unkn","Unknown",NA))) 

RTdata$Lang <- RTdata$Group
RTdata$Lang <- stri_sub(RTdata$Group,-5,-1 )
RTdata$Language <- ifelse(RTdata$Lang=="FR_BE", "FR", 
                        ifelse(RTdata$Lang=="NL_BE", "NL",NA)) 

Characteristics<- reshape(data=RTdata, idvar="ID",
                    varying = c("Language","Gender"),
                    v.name=c("RT.tot"),
                    times=c("Language","Gender"),
                    new.row.names = 1:12000,
                    direction="long")
Characteristics<- reshape(data=RTdata, idvar="ID",
                          varying = c("Group"),
                          v.name=c("Group"),
                          times=c("Group"),
                          new.row.names = 1:12000,
                          direction="long")
Characteristics <- Characteristics[c("ID","Gender","Language")]

Final <- merge(CombineDataTotal, Characteristics, by=c("ID"))

Final <- Final[c("ID","Gender", "Language", "Item", "Problem","Y", "RT", "subY", "subRT", "Y.tot", "RT.tot")]

head(Final)

#Auditing

#Identifies, by visual investigation, several observations where RT=0 and Y=1. This makes no sense as one should expect at least some time have to be used in order to answer. 
#I set the RT and Y value for items of zero reaction time to NA, which indicates they are missing.
Final$RT <- ifelse(Final$RT==0, "NA", Final$RT) 
Final$Y <- ifelse(Final$RT=="NA", "NA", Final$Y) 

#Looking for total scores outside the range 1-21 
boxplot(Final$Y.tot)
Final[Final$Y.tot>21 | Final$Y.tot<0,]
# OK

#Looking for total reactiontime outside the range 0 - 20*60=1200 seconds 
boxplot(Final$Y.tot)
Final[Final$RT.tot>1200 | Final$RT.tot<0,]
# Identifies several tests lasting longer than 1200 seconds, although no longer that 1204 seconds



#Checking for duplicates in ID entrys
Ydata$ID[duplicated(Ydata$ID)]
#OK
RTdata$ID[duplicated(RTdata$ID)]
#Identified 3 duplicats in RTdata, 327, 40 and 27
summary(RTdata$ID)
#Can see that there is an ID=501, this is suspicious. This can be a typo. We can try to identify the missing ID.
#Checking for missing ID by visual assesment
sort(RTdata$ID, decreasing = TRUE) 
# We can see that the values ID=470, ID=471 and ID=401 are missing. I guess that ID=501 in reality is a typo for student 401. 
#Removing all duplicates
Final<-subset(Final, ID!=40 & ID!=27 & ID!=327)

#To sum up: The final dataset "Final" is missing values from 2*(ID(27,40,327))+470+471+401 this equals 9 rows missing. With 21 items per row we will miss 21*9=189 observations, leaving us with 10500-189=10311 observations. This checks out with the observations in the dataset "Final" :)

write.table(Final, file = "Final.txt", sep = " ", dec = ".",
            row.names = F, col.names = T)

