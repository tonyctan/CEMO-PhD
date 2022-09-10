
### ASSIGNMENT 2 READY ### ----------------------------------------------- ####

#### Packages used 
library(readxl)
library(tidyverse)
library(stringr)

#### 
Ydata <- read_excel("data/Ydata.xlsx")
RTdata = read.table(file="data/RTdata.csv", header=TRUE,sep=";",dec=",")

#### Remove duplicates from RTdata, this makes it so that we can 
#### reformat it to a long format # Removes 3 values
RTdata <- RTdata[!duplicated(RTdata$ID),]

#### Ydata is a tibble, this needs to be a data.frame to be able to get renamed
Ydata = as.data.frame(Ydata)
Ydata  <- rename(Ydata, Item_17 = It_17, Item_10 = It_10, Item_19 = It_19, Item_15 = It_15, Item_16 = It_16, Item_11 = It_11, Item_12 = It_12, Item_20 = It_20, Item_14 = It_14, Item_13 = It_13, Item_18 = It_18, Item_21 = It_21)

#### Reorder coloms for calculations
RTdata <- RTdata[, c(1,2,3,4,5,6,7,8,9,10,11,12,15,14,13,16,19,18,17,20,21,22,23)]
Ydata <- Ydata[, c(19,8,12,21,6,10,18,7,4,3,13,14,17,16,5,11,2,20,9,15,22,1)]

#### Creating long formates for RT -and Y-datasets
LongRT = reshape(RTdata,direction="long",idvar="ID",varying=list(c("Time01","Time02","Time03","Time04","Time05","Time06","Time07","Time08","Time09","Time10","Time11","Time12","Time13","Time14","Time15","Time16","Time17","Time18","Time19","Time20","Time21")))
LongY = reshape(Ydata,direction="long",idvar="ID",varying=list(c("Item_17","Item_10","Item_9","Item_15","Item_5","Item_8","Item_2","Item_19","Item_6","Item_16","Item_3","Item_11","Item_12","Item_20","Item_14","Item_13","Item_7","Item_1","Item_18","Item_4","Item_21")))

#### Renaming and removing variables for ease of computation
LongRT <- select(LongRT, -c(Time01)) #Remove the "Time01" variable

names(LongY)[2:3]=c("Item","Y")
names(LongRT)[1:4]=c("Group","ID","Item","RT")

#### RTdata .tot, .sub & Problem ####
# RTdata.tot #
RTdata.tot <- RTdata %>%
  mutate(RT.tot = rowSums(across(c(Time01,Time02,Time03,Time04,Time05,Time06,Time07,Time08,Time09,Time10,Time11,Time12,Time13,Time14,Time15,Time16,Time17,Time18,Time19,Time20,Time21))))
# I cant use c_across for some reason, RT.tot = sum(c_across(2:22)


### MAYBE TRY WITHOUT REMOVING Group ### 
RTdata.sub <- select(RTdata, -c(Group)) #Removed the Numeric value for computation
RTdata.sub <- RTdata

# RTdata.sub #
RTdata.sub <- RTdata.sub %>% mutate(RT.sub1 = rowSums(.[1:4]))
RTdata.sub <- RTdata.sub %>% mutate(RT.sub2 = rowSums(.[5:8]))
RTdata.sub <- RTdata.sub %>% mutate(RT.sub3 = rowSums(.[9:12]))
RTdata.sub <- RTdata.sub %>% mutate(RT.sub4 = rowSums(.[13:16]))
RTdata.sub <- RTdata.sub %>% mutate(RT.sub5 = rowSums(.[17:20]))
RTdata.sub <- RTdata.sub %>% mutate(RT.sub6 = rowSums(.[21:21]))

#Removing all variables except for .sub and ID
RTdata.sub <- select(RTdata.sub, -c(Time01,Time02,Time03,Time04,Time05,Time06,Time07,Time08,Time09,Time10,Time11,Time12,Time13,Time14,Time15,Time16,Time17,Time18,Time19,Time20,Time21))

### RT Problem ###
LongRT <- LongRT %>%
  mutate(Problem = case_when(LongRT$Item == 1 ~ 1,LongRT$Item == 2 ~ 1,LongRT$Item == 3 ~ 1,LongRT$Item == 4 ~ 1,
                             LongRT$Item  == 5 ~ 2,LongRT$Item  == 6 ~ 2,LongRT$Item  == 7 ~ 2,LongRT$Item  == 8 ~ 2,
                             LongRT$Item  == 9 ~ 3,LongRT$Item  == 10 ~ 3,LongRT$Item  == 11 ~ 3,LongRT$Item  == 12 ~ 3,
                             LongRT$Item  == 13 ~ 4,LongRT$Item  == 14 ~ 4,LongRT$Item  == 15 ~ 4,LongRT$Item  == 16 ~ 4,
                             LongRT$Item  == 17 ~ 5,LongRT$Item  == 18 ~ 5,LongRT$Item  == 19 ~ 5,LongRT$Item  == 20 ~ 5,
                             LongRT$Item == 21 ~ 6))



#### Ydata .tot, .sub & Problem 
# Ydata .tot
### Y.tot
Ydata.tot <- Ydata %>%
  mutate(Y.tot = rowSums(across(c(Item_17,Item_10,Item_9,Item_15,Item_5,Item_8,Item_2,Item_19,Item_6,Item_16,Item_3,Item_11,Item_12,Item_20,Item_14,Item_13,Item_7,Item_1,Item_18,Item_4,Item_21))))

Ydata.sub <- Ydata.tot

### Y.sub
Ydata.sub <- Ydata.sub %>% mutate(Y.sub1 = rowSums(.[1:4]))
Ydata.sub <- Ydata.sub %>% mutate(Y.sub2 = rowSums(.[5:8]))
Ydata.sub <- Ydata.sub %>% mutate(Y.sub3 = rowSums(.[9:12]))
Ydata.sub <- Ydata.sub %>% mutate(Y.sub4 = rowSums(.[13:16]))
Ydata.sub <- Ydata.sub %>% mutate(Y.sub5 = rowSums(.[17:20]))
Ydata.sub <- Ydata.sub %>% mutate(Y.sub6 = rowSums(.[21:21]))

Ydata.sub <- select(Ydata.sub, -c(Item_17,Item_10,Item_9,Item_15,Item_5,Item_8,Item_2,Item_19,Item_6,Item_16,Item_3,Item_11,Item_12,Item_20,Item_14,Item_13,Item_7,Item_1,Item_18,Item_4,Item_21))


#Removing all variables except for ID and .sub variabels
Ydata.sub <- select(Ydata.sub, -c(Item_17,Item_10,Item_9,Item_15,Item_5,Item_8,Item_2,Item_19,Item_6,Item_16,Item_3,Item_11,Item_12,Item_20,Item_14,Item_13,Item_7,Item_1,Item_18,Item_4,Item_21))



### Ydata Problem
Ydata <- LongY %>%
  mutate(Problem = case_when(LongY$Item == 1 ~ 1,LongY$Item == 2 ~ 1,LongY$Item == 3 ~ 1,LongY$Item == 4 ~ 1,
                             LongY$Item  == 5 ~ 2,LongY$Item  == 6 ~ 2,LongY$Item  == 7 ~ 2,LongY$Item  == 8 ~ 2,
                             LongY$Item  == 9 ~ 3,LongY$Item  == 10 ~ 3,LongY$Item  == 11 ~ 3,LongY$Item  == 12 ~ 3,
                             LongY$Item  == 13 ~ 4,LongY$Item  == 14 ~ 4,LongY$Item  == 15 ~ 4,LongY$Item  == 16 ~ 4,
                             LongY$Item  == 17 ~ 5,LongY$Item  == 18 ~ 5,LongY$Item  == 19 ~ 5,LongY$Item  == 20 ~ 5,
                             LongY$Item == 21 ~ 6))

#### MERGE ####
( Ydata2 = merge(Ydata,Ydata.tot,all=TRUE))
( Ydata2 = merge(Ydata2,Ydata.sub,all=TRUE))

( Ydata2 = merge(Ydata2,LongY,all=TRUE))

Ydata3  <- select(Ydata2, -c(Y.tot,Item,Y,Problem))
Ydata3  <- select(Ydata2, -c(Y.tot,Item,Y,))
Ydata3 <- select(Ydata3, -c(Item_17,Item_10,Item_9,Item_15,Item_5,Item_8,Item_2,Item_19,Item_6,Item_16,Item_3,Item_11,Item_12,Item_20,Item_14,Item_13,Item_7,Item_1,Item_18,Item_4,Item_21))


Ydata <- select(Ydata, -c(Y))

Ydata2 <- select(Ydata2, -c(Item_17,Item_10,Item_9,Item_15,Item_5,Item_8,Item_2,Item_19,Item_6,Item_16,Item_3,Item_11,Item_12,Item_20,Item_14,Item_13,Item_7,Item_1,Item_18,Item_4,Item_21))


#### Reshape the 6 variables and ID for a new long-format. Can use "ID" and not "id" when duplicates are removed
Ydata4 = reshape(Ydata3,direction="long",idvar=c("Cake"),varying=list(c("Y.sub1","Y.sub2","Y.sub3","Y.sub4","Y.sub5","Y.sub6")))
#### Rename variables 

Ydata4 <- select(Ydata4, -c(Cake,Problem))
names(Ydata4)[2:3]=c("Problem","Y.sub")

 
Ydata4 <- select(Ydata4, -c(id)) <- NoClueWhatThisIs
### Slice by 21 to go from 63000 to 3000 observations, 500 rows x 6 Problem x 3 variables
Ydata4 <- slice(Ydata4, seq(21, nrow(Ydata4), 21))

Ydata2 <- select(Ydata2, -c(Item_17,Item_10,Item_9,Item_15,Item_5,Item_8,Item_2,Item_19,Item_6,Item_16,Item_3,Item_11,Item_12,Item_20,Item_14,Item_13,Item_7,Item_1,Item_18,Item_4,Item_21,Y.sub1,Y.sub2,Y.sub3,Y.sub4,Y.sub5,Y.sub6))


### Merge of Ydata sets to get 10500 obs x 6 variables
Ydata3 <- select(Ydata2, -c(Y.sub1,Y.sub2,Y.sub3,Y.sub4,Y.sub5,Y.sub6))

Ydata4 <- select(Ydata2, -c(Y.sub1, Y.sub2,Y.sub3, Y.sub4,Y.sub5, Y.sub6))

( Ydata5 = merge(Ydata2,Ydata4,all=TRUE))


#### Back to RTdata ###
RTdata3 <- RTdata
RTdata2 = reshape(RTdata.sub,direction="long",idvar=c("Cake"),varying=list(c("RT.sub1","RT.sub2","RT.sub3","RT.sub4","RT.sub5","RT.sub6")))

RTdata2 <- select(RTdata2, -c(Cake))
names(RTdata2)[3:4]=c("Problem","R.sub")

( RTdata3 = merge(RTdata2,LongRT,all=TRUE))
( RTdata4 = merge(RTdata3,RTdata6,all=TRUE))


RTdata6 <- select(RTdata.tot, -c(Time01,Time02,Time03,Time04,Time05,Time06,Time07,Time08,Time09,Time10,Time11,Time12,Time13,Time14,Time15,Time16,Time17,Time18,Time19,Time20,Time21))

#### ITS COMMING HOME ####


RTdata2 <- select(RTdata2, -c(Time01,Time02,Time03,Time04,Time05,Time06,Time07,Time08,Time09,Time10,Time11,Time12,Time13,Time14,Time15,Time16,Time17,Time18,Time19,Time20,Time21))
RTdata3 <- select(RTdata2, -c(Group,RT.tot))


RTdata4 = reshape(RTdata3,direction="long",idvar=c("Problem"),varying=list(c("RT.sub1","RT.sub2","RT.sub3","RT.sub4","RT.sub5","RT.sub6")))

RTdata4 <- select(RTdata4, -c(Problem))
names(RTdata4)[2:3]=c("Problem","R.sub")

RTdata6 <- select(RTdata2, -c("RT.sub1","RT.sub2","RT.sub3","RT.sub4","RT.sub5","RT.sub6"))

( RTdata7 = merge(RTdata6,RTdata4,all=TRUE))



#### Not completely finished, need to Split and remerge ####
(ASSIGNMENT3 = merge(RTdata9,Ydata5,all=TRUE))

names(ASSIGNMENT2)[5]=c("RT.sub")
ASSIGNMENT2 <- ASSIGNMENT2[, c(1,4,3,2,9,6,10,5,8,7)]


(RTdata5 = merge(RTdata7,LongRT,all=TRUE,by=intersect("ID","Group")))


#### SLICE ####
RTdata5 <- slice(RTdata5, seq(21, nrow(RTdata5), 21))

(Assignment2 = merge(RTdata5,Ydata5,all=TRUE))

RTdata5 <- select(RTdata5, -c(Group.x))

### Split Group -> Gender-Language

RTdata4 <- cbind(RTdata4[-3], t(as.data.frame(strsplit(RTdata4$Group, '_'), row.names=c("Group1", "Group2","Group3"))), row.names=NULL)

RTdata4 <- select(RTdata4, -c(Group,Group1,Group3))

RTdata4 <- RTdata4 %>% separate(Group2,into = c("Gender","Language"),sep = -2,convert = TRUE)

RTdata3 <- select(RTdata3, -c(Group))

(RTdata9 =  merge(RTdata3,RTdata4,all=TRUE))

# FINISHED!!! #
(ASSIGNMENT3 = merge(RTdata9,Ydata5,all=TRUE))

names(ASSIGNMENT3)[5]=c("RT.sub")
ASSIGNMENT3 <- ASSIGNMENT3[, c(1,7,8,2,3,10,4,11,5,9,6)]
names(ASSIGNMENT3)[1]=c("Person")

#### EXPORT ####
# .txt file separated with "."
write.table(ASSIGNMENT3, file = "ASSIGNMENT3.txt", sep = ".",
            row.names = TRUE, col.names = NA)


