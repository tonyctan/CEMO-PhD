library(readxl)
##Datasets import
Ydata <- read_excel("../data/Ydata.xlsx")

View(Ydata)
str(Ydata)
class(Ydata)
# Structure of Ydata seems to be a tibble that we need to covert to a dataframe 
Ydata<- as.data.frame(Ydata)


##Checking the data
dim(Ydata)
# 500 22 means actually 500 entries/IDs exist in Ydata.
length(unique(Ydata$ID))

(Ydata$ID[duplicated(Ydata$ID)])
# all 500 obs are unique- so there is no duplicates.
Ydata[Ydata$ID > 500,]
Ydata[Ydata$ID <1,]
table(Ydata$ID%in%c(1:500))
#no Id more than 500 or less than 1
Ydata[(-c(1:500)%in%Ydata$ID),]
# confirms there is no missing value

summary(Ydata)
table(apply(Ydata, 2, function(x) is.na(x)))
# confirms Ydata doesn't contain any missing value

##Reshaping to long format
names(Ydata)
Ylong = reshape(
  Ydata,direction="long",
  idvar="ID",
  varying=list(2:22)
  )
str(Ylong)
#'data.frame':	10500 obs. of  3 variables
head(Ylong)
# we just need to rename the variables
names(Ylong)<- c("ID","item","Y")


# Importing RTdata
library(readr)
RTdata<- read.csv(file = "../data/RTdata.csv", sep = ";", header = TRUE)
str(RTdata)
head(RTdata)
class(RTdata)

##  the data checkup
dim(RTdata)
# is has 498 obs (500 was expected, lets see whats going on)
# checking for duplicates
RTdata$ID[duplicated(RTdata$ID)]
#  327  40  27 are duplicated
length(unique(RTdata$ID))
# 495 unique IDs
# also need to check for any missing values
table(RTdata$ID %in% c(1:500))
sample(RTdata$ID %in% c(1:500))
sample(c(1:500)%in% RTdata$ID)
#FALSE 1  TRUE 497 means 1 Id went beyong 1:500 range, what is that?
RTdata[RTdata$ID>500|RTdata$ID<1,"ID"]
# its 501 that was mistyped for 401
(c(1:500)%in%RTdata$ID)
(RTdata$ID%in%c(1:500))
# position 28, 39, 328, 401, 470, 471 are missing
# 28, 39, 328 & 401 are mistyped by respectively 27, 40, 327 and 501 and 470 & 471 have no value

## Data cleaning
# we can amend ID 28, 39, 328 & 401.
RTdata$ID= as.integer(gsub(501, 401, RTdata$ID))
# ID 501 is replaced by 401
# ID 28, 39, 328 should be replaced at serial 471, 460 & 171 respectively
RTdata[471, "ID"]= 28
RTdata[460, "ID"]= 39
RTdata[171, "ID"]= 328
# now we see there is no duplicates and all 498 obs are unique.

# However, we could have ignored data cleaning but only removed the duplicates 
# RTdata= RTdata[!duplicated(RTdata$ID),]

##Data Reshaping- now we need to reshape it into long dataset
names(RTdata)
RTlong<- reshape(RTdata,direction="long",idvar="ID",varying=list(c(1:21)))
head(RTlong)
str(RTlong)
names(RTlong)= c("Group", "ID", "item","RT")

# we need to split texts in Group and extract gender and languauge
Group<- data.frame(do.call(rbind, strsplit(RTdata$Group, split = "_")))

RTlong$Language<- substr(Group$X2, nchar(Group$X2)-1, nchar(Group$X2))
head(RTlong)
RTlong$Gender<- substr(Group$X2, 0, nchar(Group$X2)-2)
str(RTlong)
# keeping only intended columns and rearranging in order
RTlong= RTlong[,c(2:6)]
RTlong= RTlong[,c(1, 5, 4, 2, 3)]
# we need to convert Gender and Language variable into factor
RTlong$Gender <- as.factor(RTlong$Gender)
RTlong$Language <- as.factor(RTlong$Language)

tail(Ylong)
tail(RTlong)

## Adding Problem variale in both long datasets
Ylong$Problem<- ceiling(Ylong$item/4)
RTlong$Problem<- ceiling(RTlong$item/4)

## Merging both datasets into one by all three common variables "ID", "item" and "Problem" variables
Ylong_RTlong<- merge(Ylong, RTlong, by= c("ID", "item", "Problem"), all= TRUE)
str(Ylong_RTlong)
head(Ylong_RTlong)
# rearranging columns
Ylong_RTlong<- Ylong_RTlong[c(1,5,6,2,3,4,7)]

## subscoring from wide Ydata and RTdata
# we can create 6 subscore variables P(1-6) from item 1-21

Ydata1<- Ydata
# created new dataset to avoid original data change.
str(Ydata1)
names(Ydata1)
# 6 new subscore variables can be created
Ydata1$P1= Ydata1$Item_1+Ydata1$Item_2+Ydata1$Item_3+Ydata1$Item_4
Ydata1$P2= Ydata1$Item_5+Ydata1$Item_6+Ydata1$Item_7+Ydata1$Item_8
Ydata1$P3= Ydata1$Item_9+Ydata1$It_10+Ydata1$It_11+Ydata1$It_12
Ydata1$P4= Ydata1$It_13+Ydata1$It_14+Ydata1$It_15+Ydata1$It_16
Ydata1$P5= Ydata1$It_17+Ydata1$It_18+Ydata1$It_19+Ydata1$It_20
Ydata1$P6= Ydata1$It_21 
# new variables created
head(Ydata1)
# extracting necessary variables
Ydata1<- Ydata1[,-c(2:22)]
# transforming into long format
Ylongsub<- reshape(
  Ydata1, direction = "long", idvar = "ID", varying = list(c(2:7))
  )
str(Ylongsub)
head(Ylongsub)
names(Ylongsub)<- c("ID", "Problem", "Y.sub")

# similarly subscoring for RTdata
RTdata1<- RTdata
str(RTdata1)
names(RTdata1)
RTdata1$P1= RTdata1$Time01+ RTdata1$Time02+ RTdata1$Time03+ RTdata1$Time04
RTdata1$P2= RTdata1$Time05+ RTdata1$Time06+ RTdata1$Time07+ RTdata1$Time08
RTdata1$P3= RTdata1$Time09+ RTdata1$Time10+ RTdata1$Time11+ RTdata1$Time12
RTdata1$P4= RTdata1$Time13+ RTdata1$Time14+ RTdata1$Time15+ RTdata1$Time16
RTdata1$P5= RTdata1$Time19+ RTdata1$Time18+ RTdata1$Time19+ RTdata1$Time20
RTdata1$P6= RTdata1$Time21

# new variables created
head(RTdata1)
# extracting necessary variables
RTdata1<- RTdata1[,-c(1:21)]
# transforming into long format
head(RTdata1)
RTlongsub<- reshape(
  RTdata1, direction = "long", idvar = "ID", varying = list(c(3:8))
)
head(RTlongsub)
str(RTlongsub)
names(RTlongsub)= c("Group", "ID", "Problem", "RT.sub")

# we need to split texts in Group and extract gender and languauge

RTlongsub$Language<- substr(Group$X2, nchar(Group$X2)-1, nchar(Group$X2))
tail(RTlongsub)
RTlongsub$Gender<- substr(Group$X2, 0, nchar(Group$X2)-2)
str(RTlongsub)
# keeping only intended columns and rearranging in order
RTlongsub<- RTlongsub[,c(2:6)]
RTlongsub= RTlongsub[,c(1, 5, 4, 2, 3)]
# we need to convert Gender and Language variable into factor
RTlongsub$Gender <- as.factor(RTlongsub$Gender)
RTlongsub$Language <- as.factor(RTlongsub$Language)

## merging Ylongsub and RTlongsub
head(Ylongsub)
Ylongsub[Ylongsub$ID>500|Ylongsub$ID<1,"ID"]
RTlongsub[RTlongsub$ID>500|RTlongsub$ID<1,"ID"]

head(RTlongsub)
Ysub_RTsub<- merge(Ylongsub, RTlongsub, by= c("ID", "Problem"), all= TRUE) 
tail(Ysub_RTsub)
str(Ysub_RTsub)


## Create totalscore dataset
#compute totalscore based on initial wide dataset(B)
#only keep the ID variable and this Y.tot (or RT.tot) totalscore variable
#dimensions: approximately 500 rows by 2 variables
## subscoring from wide Ydata and RTdata
# we can create 6 subscore variables P 1-6 from item 1-21

Ytot<- Ydata
str(Ytot)

# created new dataset since we do not want to change original datasets
names(Ytot)
Ytot$Problem= rowSums(Ytot[,c(2:22)])
# new variables created
head(Ytot)
str(Ytot)
# extracting necessary variables
Ytot<- Ytot[,-c(2:22)]
# transforming into long format
str(Ytot)
head(Ytot)
names(Ytot)<- c("ID", "Y.tot")

# similar for RTdata
RTtot<- RTdata
str(RTtot)
names(RTtot)
RTtot$Problem= rowSums(RTtot[,c(1:21)])

# new variables created
head(RTtot)
# extracting necessary variables
RTtot<- RTtot[,-c(1:21)]

# we need to split texts in Group and extract gender and languauge

RTtot$Language<- substr(Group$X2, nchar(Group$X2)-1, nchar(Group$X2))
tail(RTtot)
RTtot$Gender<- substr(Group$X2, 0, nchar(Group$X2)-2)
str(RTtot)
# keeping only intended columns and rearranging in order
RTtot<- RTtot[,c(2:5)]
RTtot= RTtot[,c(1, 4, 3, 2)]
# we need to convert Gender and Language variable into factor
RTtot$Gender <- as.factor(RTtot$Gender)
RTtot$Language <- as.factor(RTtot$Language)
names(RTtot)<- c("ID", "Gender", "Language", "RT.tot")

## merging Ylongsub and RTlongsub
head(Ytot)
head(RTtot)
Ytot[Ytot$ID>500|Ytot$ID<1,"ID"]
RTtot[RTtot$ID>500|RTtot$ID<1,"ID"]
str(Ytot)
str(RTtot)
Ytot_RTtot<- merge(Ytot, RTtot, by= "ID", all= TRUE) 
tail(Ytot_RTtot)
head(Ysub_RTsub)
str(Ytot_RTtot)
str(Ysub_RTsub)

##Merging
subtot<- merge(Ysub_RTsub, Ytot_RTtot, by= c("ID", "Gender", "Language"), all= TRUE)
head(subtot)
str(subtot)

## final merging whole data set
str(Ylong_RTlong)
Final<- merge(Ylong_RTlong,subtot, by= c("ID", "Gender", "Language", "Problem"), all= TRUE)

str(Final)
head(Final)

## file export
#ASCII text format
write.table(Final, file="../data/Final-exported.dat", row.names=FALSE, sep="\t ", dec=".")


## How to read exported/saved files
data<- read.table(file= "../data/Final-exported.dat", header= TRUE, sep = "\t ", dec = ".")
head(data)
str(data)


