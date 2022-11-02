#importing Ydata
library(readxl)
Ydata <- read_excel("data/Ydata.xlsx")
View(Ydata)

#importing RTdata
RTdata <- read.csv("data/RTdata.csv", sep=";")
View(RTdata)

#Cleaning data
names(Ydata)
names(RTdata)
str(Ydata)
str(RTdata)

#Change Ydata tibble to data.frame
Ydatadf<- as.data.frame(Ydata)
str(Ydatadf)

#remove duplicates
RT.data= RTdata[!duplicated(RTdata$ID),]
Y.data= Ydatadf[!duplicated(Ydatadf$ID),]

#looking for string inconsistencies
unique(RT.data$Group)

#checking data types
typeof(Y.data$ID)
typeof(RT.data$ID)

#substr of RTdata1$Group OR constructing Gender column
RT.data$Gender =substr(RT.data$Group,8,8)

#Split RTdata1$Group OR constructing Language column
RT.data$Language= substr(RT.data$Group,nchar(RT.data$Group)-4,nchar(RT.data$Group)-3)

#Reshaping from wide to long
YLong= reshape(data=Y.data,idvar= "ID",varying=list(c("It_17","It_10","Item_9","It_15","Item_5","Item_8","Item_2","It_19","Item_6","It_16","Item_3","It_11","It_12","It_20","It_14","It_13","Item_7","Item_1","It_18","Item_4","It_21")), direction="long")
RTLong= reshape(data=RT.data,idvar="ID", varying=list(c("Time01","Time02","Time03","Time04","Time05","Time06","Time07","Time08","Time09","Time10","Time11","Time12","Time15","Time14","Time13","Time16","Time19","Time18","Time17","Time20","Time21")), direction= "long")

#Changing variable names
names(YLong)[2:3]= c("Item","Y")
names(RTLong)[5:6]= c("Item", "RT")

#Selecting required columns from RTLong
RTLong1= RTLong[,c("ID","Item","RT")]

#Add Problem var to YLong dataset
YLong$Problem= ceiling(YLong$Item/4)

#Add Problem var to RTLong1 dataset
RTLong1$Problem= ceiling(RTLong1$Item/4)

#Creating variables "Problem 1-6" in wide RTdataset
RT.data$Problem1= RT.data$Time17 + RT.data$Time10 + RT.data$Time09 + RT.data$Time15
RT.data$Problem2= RT.data$Time05 + RT.data$Time08 + RT.data$Time02 + RT.data$Time19
RT.data$Problem3= RT.data$Time06 + RT.data$Time16 + RT.data$Time03 + RT.data$Time11
RT.data$Problem4= RT.data$Time12 + RT.data$Time20 + RT.data$Time14 + RT.data$Time13
RT.data$Problem5= RT.data$Time07 + RT.data$Time01 + RT.data$Time18 + RT.data$Time04
RT.data$Problem6= RT.data$Time21

#Creating subscore RT dataset
RT.Subscore= RT.data[,-c(1:22)]
RT.Subscore= RT.Subscore[,-c(2:3)] #removing columns

#Creating variables "Problem 1-6" in wide Ydataset
Ydatadf$Problem1= Ydatadf$It_17+Ydatadf$It_10+Ydatadf$Item_9+Ydata$It_15
Ydatadf$Problem2= Ydatadf$Item_5+Ydatadf$Item_8+Ydatadf$Item_2+Ydatadf$It_19
Ydatadf$Problem3= Ydatadf$Item_6+Ydatadf$It_16+Ydatadf$Item_3+Ydatadf$It_11
Ydatadf$Problem4= Ydatadf$It_12+Ydatadf$It_20+Ydatadf$It_14+Ydatadf$It_13
Ydatadf$Problem5= Ydatadf$Item_7+Ydatadf$Item_1+Ydatadf$It_18+Ydatadf$Item_4
Ydatadf$Problem6= Ydatadf$It_21

#Creating subscore Y dataset
Y.Subscore= Ydatadf[,-c(2:22)]

#Reshaping RT subscore dataset
RT.Sub= reshape(data=RT.Subscore,idvar="ID", varying=list(c("Problem1","Problem2","Problem3","Problem4", "Problem5","Problem6")),direction= "long")
#Changing variable names
names(RT.Sub)[2:3]= c("Problem", "RT.sub")

#Reshaping Y subscore dataset
Y.Sub= reshape(data=Y.Subscore,idvar="ID", varying=list(c("Problem1","Problem2","Problem3","Problem4", "Problem5","Problem6")),direction= "long")
#Changing variable names
names(Y.Sub)[2:3]= c("Problem", "Y.sub")

#Calculating totalscore + creating dataset Y.Tot
Ydatadf2=Ydatadf
Ydatadf2$Y.Tot= Ydatadf2$Problem1+Ydatadf2$Problem2+Ydatadf2$Problem3+Ydatadf2$Problem4+Ydatadf2$Problem5+Ydatadf2$Problem6
Y.Tot= Ydatadf2[,-c(2:28)]

#Calculating totalscore + creating dataset RT.Tot
RT.data$RT.Tot= RT.data$Problem1+RT.data$Problem2+RT.data$Problem3+RT.data$Problem4+RT.data$Problem5+RT.data$Problem6
RT.Tot= RT.data[,-c(1:22,24:31)]

#Merging Y and RT datasets
Long= merge(RTLong1,YLong, by= c("ID", "Item","Problem"),all.x=TRUE, all.y=TRUE)
Subscores= merge(RT.Sub,Y.Sub, by= c("ID", "Problem"),all.x=TRUE, all.y=TRUE)
Total= merge(RT.Tot,Y.Tot, by= c("ID"),all.x=TRUE, all.y=TRUE)
Scores= merge(Total,Subscores, by= c("ID"),all.x=TRUE, all.y=TRUE)
final= merge(Scores,Long, by= c("ID","Problem"),all.x=TRUE, all.y=TRUE)

#Adding Gender,Language & Item variables by creating new dataset then merging
GLI= RTLong[,2:6]
Final= merge(final,GLI, by=c("ID","Item", "RT"), all.x=TRUE, all.y=TRUE)

#Rearranging
Final= Final[,c(1,10,11,2,4,9,3,8,7,6,5)]
names(Final)[1]= "Person"

#Changing types of data
Final$Language=as.factor(Final$Language)
Final$Gender=as.factor(Final$Gender)
Final$Item=as.numeric(Final$Item)
Final$Problem=as.numeric(Final$Problem)

#Reordering & sorting variables
Final=Final[order(Final$Person, decreasing=TRUE),]

#Checking structure of the dataset
str(Final)

#Exporting file
write.table(Final, file="data/DataWrangling.txt", row.names=FALSE, sep="\t", dec=".")
