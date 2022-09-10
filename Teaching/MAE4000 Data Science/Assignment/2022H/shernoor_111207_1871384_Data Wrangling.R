#importing Ydata
library(readxl)
Ydata <- read_excel("~/MAE4000/data/Ydata.xlsx")
View(Ydata)
#importing RTdata
RTdata <- read.csv("~/MAE4000/data/RTdata.csv", sep=";")
#Cleaning data
names(Ydata)
names(RTdata)
str(Ydata)
str(RTdata)
#Change Ydata tibble to data.frame
Ydatadf<- as.data.frame(Ydata)
str(Ydatadf)
#remove duplicates
RTdata1= RTdata[!duplicated(RTdata$ID),]
Ydata1= Ydatadf[!duplicated(Ydatadf$ID),]
#looking for string inconsistencies
unique(RTdata1$Group)
#checking data types
typeof(Ydata1$ID)
typeof(RTdata1$ID)
#substr of RTdata1$Group OR constructing Gender column
RTdata1$Gender =substr(RTdata1$Group,8,8)
#Split RTdata1$Group OR constructing Language column
RTdata1$Language= substr(RTdata1$Group,nchar(RTdata1$Group)-4,nchar(RTdata1$Group)-3)
#Reshaping from wide to long
YLong= reshape(data=Ydata1,idvar= "ID",varying=list(c("It_17","It_10","Item_9","It_15","Item_5","Item_8","Item_2","It_19","Item_6","It_16","Item_3","It_11","It_12","It_20","It_14","It_13","Item_7","Item_1","It_18","Item_4","It_21")), direction="long")
RTLong= reshape(data=RTdata1,idvar="ID", varying=list(c("Time01","Time02","Time03","Time04","Time05","Time06","Time07","Time08","Time09","Time10","Time11","Time12","Time15","Time14","Time13","Time16","Time19","Time18","Time17","Time20","Time21")), direction= "long")
#Changing variable names
names(YLong)[2:3]= c("Item","Y")
names(RTLong)[5:6]= c("Item", "RT")
#Selecting required columns from RTLong
RTLong[,c("ID","Item","RT")]
#Creating new variable "Problem" with 5 levels
YLong$Problem= cut(YLong$Item, 5,labels= c("1","2","3","4","5"))
RTLong$Problem= cut(RTLong$Item, 5,labels= c("1","2","3","4","5"))
#Creating variables "Problem 1-6" in wide RTdataset
RTdata1$Problem1= RTdata1$Time17 + RTdata1$Time10 + RTdata1$Time09 + RTdata1$Time15
RTdata1$Problem2= RTdata1$Time05 + RTdata1$Time08 + RTdata1$Time02 + RTdata1$Time19
RTdata1$Problem3= RTdata1$Time06 + RTdata1$Time16 + RTdata1$Time03 + RTdata1$Time11
RTdata1$Problem4= RTdata1$Time12 + RTdata1$Time20 + RTdata1$Time14 + RTdata1$Time13
RTdata1$Problem5= RTdata1$Time07 + RTdata1$Time01 + RTdata1$Time18 + RTdata1$Time04
RTdata1$Problem6= RTdata1$Time21

#Creating variables "Problem 1-6" in wide Ydataset
Ydatadf$Problem1= Ydatadf$It_17+Ydatadf$It_10+Ydatadf$Item_9+Ydata$It_15
Ydatadf$Problem2= Ydatadf$Item_5+Ydatadf$Item_8+Ydatadf$Item_2+Ydatadf$It_19
Ydatadf$Problem3= Ydatadf$Item_6+Ydatadf$It_16+Ydatadf$Item_3+Ydatadf$It_11
Ydatadf$Problem4= Ydatadf$It_12+Ydatadf$It_20+Ydatadf$It_14+Ydatadf$It_13
Ydatadf$Problem5= Ydatadf$Item_7+Ydatadf$Item_1+Ydatadf$It_18+Ydatadf$Item_4
Ydatadf$Problem6= Ydatadf$It_21

#Creating subscore RT dataset
RT.Subscore= RTdata1[,-c(1:22)]
RT.Subscore= RT.Subscore[,-c(2:3)] #removing columns

#Creating subscore Y dataset
Y.Subscore= Ydatadf[,-c(2:22)]

#Reshaping RT subscore dataset
RT.Sub= reshape(data=RT.Subscore,idvar="ID", varying=list(c("Problem1","Problem2","Problem3","Problem4", "Problem5","Problem6")),direction= "long")
#Changing variable names
names(RT.Sub)[2:3]= c("Problem", "RT.sub")

#Reshaping Y subscore dataset
Y.Sub= reshape(data=Y.Subscore,idvar="ID", varying=list(c("Problem1","Problem2","Problem3","Problem4", "Problem5","Problem6")),direction= "long")
names(Y.Sub)[2:3]= c("Problem", "Y.sub")

#Calculating totalscore + creating dataset Y.tot
Ydatadf2$Y.tot= Ydatadf2$Problem1+Ydatadf2$Problem2+Ydatadf2$Problem3+Ydatadf2$Problem4+Ydatadf2$Problem5+Ydatadf2$Problem6
Y.tot= Ydatadf2[,-c(2:28)]

#Calculating totalscore + creating dataset RT.tot
RTdata1$RT.tot= RTdata1$Problem1+RTdata1$Problem2+RTdata1$Problem3+RTdata1$Problem4+RTdata1$Problem5+RTdata1$Problem6
RT.tot= RTdata1[,-c(1:22,24:31)]

#Merging Y and RT datasets
Long= merge(RTLong,YLong, by= c("ID", "Item", "Problem"),all.x=TRUE, all.y=TRUE)
Subscores= merge(RT.Sub,Y.Sub, by= c("ID", "Problem"),all.x=TRUE, all.y=TRUE)
Total= merge(RT.tot,Y.tot, by= c("ID"),all.x=TRUE, all.y=TRUE)
Scores= merge(Total,Subscores, by= c("ID"),all.x=TRUE, all.y=TRUE)
#Rearranging
Final= Final[,c(1,7,2,9,8,6,5,4,3)]
Final= merge(Scores,Long, by= c("ID", "Problem"),all.x=TRUE, all.y=TRUE)