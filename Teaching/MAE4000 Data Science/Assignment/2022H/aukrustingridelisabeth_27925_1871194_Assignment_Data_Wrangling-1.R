#install.packages("readxl")
library("readxl")
Ydata=read_excel(path="../data/Ydata.xlsx")
Ydata=as.data.frame(Ydata)


#Change names on items
names(Ydata) <- gsub(x = names(Ydata), pattern = "It_", replacement = "Item_")


#Get items in correct order
#install.packages("gtools")
library(gtools)
Ydata=Ydata[order(grepl('Item_', names(Ydata)), order(mixedorder(names(Ydata))))]


#Make ID 500 to 1
Ydata=Ydata[order(Ydata$ID, decreasing = TRUE),] 


#Reshape Ydata wide to long
Ydata_long=reshape(Ydata,direction="long",idvar=("ID"),varying=list(c(2:22)))
dim(Ydata_long)

#Change names: ID=ID, time=Item, Item_1=Y
names(Ydata_long)[2:3]=c("Item","Y")


#Make problem for RTdata_long. (Im sure there's a better way to do this, I just couldn't find it)
Ydata_long$Problem[Ydata_long$Item==1] <- "1"
Ydata_long$Problem[Ydata_long$Item==2] <- "1"
Ydata_long$Problem[Ydata_long$Item==3] <- "1"
Ydata_long$Problem[Ydata_long$Item==4] <- "1"
Ydata_long$Problem[Ydata_long$Item==5] <- "2"
Ydata_long$Problem[Ydata_long$Item==6] <- "2"
Ydata_long$Problem[Ydata_long$Item==7] <- "2"
Ydata_long$Problem[Ydata_long$Item==8] <- "2"
Ydata_long$Problem[Ydata_long$Item==9] <- "3"
Ydata_long$Problem[Ydata_long$Item==10] <- "3"
Ydata_long$Problem[Ydata_long$Item==11] <- "3"
Ydata_long$Problem[Ydata_long$Item==12] <- "3"
Ydata_long$Problem[Ydata_long$Item==13] <- "4"
Ydata_long$Problem[Ydata_long$Item==14] <- "4"
Ydata_long$Problem[Ydata_long$Item==15] <- "4"
Ydata_long$Problem[Ydata_long$Item==16] <- "4"
Ydata_long$Problem[Ydata_long$Item==17] <- "5"
Ydata_long$Problem[Ydata_long$Item==18] <- "5"
Ydata_long$Problem[Ydata_long$Item==19] <- "5"
Ydata_long$Problem[Ydata_long$Item==20] <- "5"
Ydata_long$Problem[Ydata_long$Item==21] <- "6"


#Make Ysub
Ydata$Ysub1=rowSums(Ydata[,2:5]) 
Ydata$Ysub2=rowSums(Ydata[,6:9]) 
Ydata$Ysub3=rowSums(Ydata[,10:13]) 
Ydata$Ysub4=rowSums(Ydata[,14:17]) 
Ydata$Ysub5=rowSums(Ydata[,18:21]) 
Ydata$Ysub6=Ydata[,22]


#Remove Group-column
Ysub=Ydata[,-(2:22)]


#Reshape RTdata wide to long
Ysub_long=reshape(Ysub,direction="long",idvar=("ID"),varying=list(c(2:7)))


#Change names: time=Item, Ysub1=Ysub
names(Ysub_long)[2:3]=c("Item","Ysub")


#Make Ytot
Ydata$Ytot = rowSums(Ydata[2:22],1)

#Remove Item and Ysub-column
Ytot=Ydata[,-(2:28)]



#Download RTdata
RTdata=read.table(file="../data/RTdata.csv",header=T,sep=";")

#Get time in correct order
#install.packages("gtools")
library(gtools)
RTdata=RTdata[order(grepl('Time', names(RTdata)), order(mixedorder(names(RTdata))))]


#Remove Group-column
RTdata=RTdata[,-1]


#Replace duplicated IDs
RTdata[471,1] <- (28)
RTdata[460,1] <- (39)
RTdata[171,1] <- (328)


#Create new rows of NAs where IDs are missing
RTdata[98,1] <- (401)

new_row1 <- c(471,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA) 
RTdata <- rbind(RTdata[1:29, ],new_row1,RTdata[- (1:29), ])

new_row2 <- c(470,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA) 
RTdata <- rbind(RTdata[1:30, ],new_row2,RTdata[- (1:30), ])


#Reshape RTdata wide to long
RTdata_long=reshape(RTdata,direction="long",idvar=("ID"),varying=list(c(2:22)))


#Change names: ID=ID, time=Item, Item_1=RT
names(RTdata_long)[2:3]=c("Item","RT")


#Make problem for RTdata_long (Im sure there's a better way to do this, I just couldn't find it)
RTdata_long$Problem[RTdata_long$Item==1] <- "1"
RTdata_long$Problem[RTdata_long$Item==2] <- "1"
RTdata_long$Problem[RTdata_long$Item==3] <- "1"
RTdata_long$Problem[RTdata_long$Item==4] <- "1"
RTdata_long$Problem[RTdata_long$Item==5] <- "2"
RTdata_long$Problem[RTdata_long$Item==6] <- "2"
RTdata_long$Problem[RTdata_long$Item==7] <- "2"
RTdata_long$Problem[RTdata_long$Item==8] <- "2"
RTdata_long$Problem[RTdata_long$Item==9] <- "3"
RTdata_long$Problem[RTdata_long$Item==10] <- "3"
RTdata_long$Problem[RTdata_long$Item==11] <- "3"
RTdata_long$Problem[RTdata_long$Item==12] <- "3"
RTdata_long$Problem[RTdata_long$Item==13] <- "4"
RTdata_long$Problem[RTdata_long$Item==14] <- "4"
RTdata_long$Problem[RTdata_long$Item==15] <- "4"
RTdata_long$Problem[RTdata_long$Item==16] <- "4"
RTdata_long$Problem[RTdata_long$Item==17] <- "5"
RTdata_long$Problem[RTdata_long$Item==18] <- "5"
RTdata_long$Problem[RTdata_long$Item==19] <- "5"
RTdata_long$Problem[RTdata_long$Item==20] <- "5"
RTdata_long$Problem[RTdata_long$Item==21] <- "6"


#Make RTsub
RTdata$RTsub1=rowSums(RTdata[,2:5]) 
RTdata$RTsub2=rowSums(RTdata[,6:9]) 
RTdata$RTsub3=rowSums(RTdata[,10:13]) 
RTdata$RTsub4=rowSums(RTdata[,14:17]) 
RTdata$RTsub5=rowSums(RTdata[,18:21]) 
RTdata$RTsub6=RTdata[,22]


#Remove Time columns
RTsub=RTdata[,-(2:22)]


#Reshape RTdata wide to long
RTsub_long=reshape(RTsub,direction="long",idvar=("ID"),varying=list(c(2:7)))


#Change names: time=Item, RTsub1=RTsub
names(RTsub_long)[2:3]=c("Item","RTsub")


#Make RTtot
RTdata$RTtot = rowSums(RTdata[2:22],1)


#Remove Item and RTsub-column
RTtot=RTdata[,-(2:28)]


#Create Gender and language
#Start by downloading RTdata. (This could have been done in an easier way
#with just using RTdata from above but then I had to change some stuff above,
#which I didnt have time to do)
RTdata=read.table(file="../data/RTdata.csv",header=T,sep=";")

#Replace duplicated IDs
RTdata[471,1] <- (28)
RTdata[460,1] <- (39)
RTdata[171,1] <- (328)


#Create new rows of NAs where IDs are missing
RTdata[98,1] <- (401)

new_row1 <- c(471,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA) 
RTdata <- rbind(RTdata[1:29, ],new_row1,RTdata[- (1:29), ])

new_row2 <- c(470,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA) 
RTdata <- rbind(RTdata[1:30, ],new_row2,RTdata[- (1:30), ])


#Split Gender and Language. Start with putting in a sign between gender and language.
RTdata$Group = gsub("Gender_Female", "F_",RTdata$Group)
RTdata$Group = gsub("Gender_Male", "M_",RTdata$Group)
RTdata$Group = gsub("Gender_Unknown", "U_",RTdata$Group)


#Split into two columns
#install.packages("Stringr")
library(stringr)
RTdata[c("Gender", "Language")] <- str_split_fixed(RTdata$Group, "_", 2)


#Change names on value in Language
RTdata$Language = gsub("FR_BE","FR",RTdata$Language)
RTdata$Language = gsub("NL_BE","NL",RTdata$Language)


#Change names on values in Gender
RTdata$Gender = gsub("F","Female",RTdata$Gender)
RTdata$Gender = gsub("M","Male",RTdata$Gender)
#Make Unknown "NA"
RTdata$Gender = gsub("U","Unknown",RTdata$Gender)


##Remove Time and Group-columns
gen_lang=RTdata[,-(1:22)]


#Overview over data frames
Ydata_long[1:10,]    #ID, Item, Y, Problem
Ysub_long[1:10,]     #ID, Item, Ysub
Ytot[1:10,]          #ID, Ytot
RTdata_long[1:10,]   #ID, Item, RT, Problem
RTsub_long[1:10,]    #ID, Item, RTsub
RTtot[1:10,]         #ID, RTtot
gen_lang[1:10,]      #ID, Gender, Language


#Merge Ysub_long and Ytot
Ys_t=merge(Ysub_long,Ytot,all.x=TRUE)

#Merge RTsub_long and RTtot
RTs_t=merge(RTsub_long,RTtot,all.x=TRUE)

#Merge Ys_t and RTs_t
sub_tot=merge(Ys_t,RTs_t,all.x=TRUE)

#Merge Ydata_long and RTdata_long
Prob_Y_RT=merge(Ydata_long,RTdata_long,all.x=TRUE)

#Merge Prob_Y_RT and gen_lang
Prob_Y_RT_gen_lang=merge(Prob_Y_RT,gen_lang,all.x=TRUE)

#Merge Prob_Y_RT_gen_lang and sub_tot
data.frame=merge(Prob_Y_RT_gen_lang,sub_tot,all.x=TRUE)

#Change order on cariables
data.frame=data.frame[,c(1,6,7,2,3,4,5,8,10,9,11)]

str(data.frame)


#Eksport data.frame
write.table(data.frame, file="Assignments/wrangeled_data_frame.txt", row.names=FALSE, sep="\t", dec=".")









