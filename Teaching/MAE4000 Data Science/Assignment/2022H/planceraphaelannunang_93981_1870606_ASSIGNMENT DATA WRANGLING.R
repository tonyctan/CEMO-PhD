#Installing Packages I might need 
library(dplyr)
install.packages("readr")
library(readr)
install.packages("caret")
install.packages("caTools")
library(caTools)
library("caret")
library("tidyr")
Ydata <- read_excel("~/Desktop/MAE 4000/data/Ydata.xlsx")
RTdata <- read.csv("~/Desktop/MAE 4000/data/RTdata.csv",header=TRUE, sep=";")
View(RTdata)
View(Ydata)
str(Ydata)
str(RTdata)
#Checking for Duplication
sum(duplicated(Ydata[,c("ID")]))
sum(duplicated(RTdata[,c("ID")]))
# Identifying which of the IDS is duplicated
which(duplicated(RTdata$ID))
RTdata1 = RTdata
RTdata1[171,23] = 328
RTdata1[460,23] = 39
RTdata1[471,23] = 28
View(RTdata1)
sum(duplicated(RTdata1[,c("ID")])) 
max(RTdata1$ID)
#no more duplicates: The previous line gets rid of duplicated IDS
RTdata1[98,23] = 401
max(RTdata1$ID)
max(RTdata1$ID)
#Getting 401 instead of 500 shows missing data.
setdiff(1:500, RTdata1$ID)
setdiff(1:500, Ydata$ID)
#no missing ID-numbers
head(RTdata1)
RTdata1 = RTdata1[,c(1:12,15,14,13,16,19,18,17,20,21,22,23)]
View(RTdata1)

head(Ydata)
colnames(Ydata)
Ydata1 = Ydata[,c(1,19,8,12,21,6,10,18,7,4,3,13,14,17,16,5,11,2,20,9,15,22)]
View(Ydata1)
# Getting Rid of Un-needed names in order to split data
class(RTdata1$Group)
RTdata1$Group[RTdata1$Group=="Gender_FemaleFR_BE"] <- "Female.FR"
RTdata1$Group[RTdata1$Group=="Gender_FemaleNL_BE"] <- "Female.NL"
RTdata1$Group[RTdata1$Group=="Gender_MaleFR_BE"] <- "Male.FR"
RTdata1$Group[RTdata1$Group=="Gender_MaleNL_BE"] <- "Male.NL"
RTdata1$Group[RTdata1$Group=="Gender_UnknownNL_BE"] <- "NA.NL"
RTdata1$Group[RTdata1$Group=="Gender_UnknownFR_BE"] <- "NA.FR"
table(RTdata1$Group)

RTdata2 = separate(RTdata1, col = "Group", into=c("Gender", "Language"),
                   sep = "\\.")
str(RTdata2)
RTdata2$Gender = as.factor(RTdata2$Gender)
RTdata2$Language = as.factor(RTdata2$Language)
str(RTdata2)
RTdata2$Gender = droplevels(RTdata2$Gender, exclude = "NA") 
#removes NA as a level in Gender
str(RTdata2)
summary(RTdata2)
summary(Ydata1)
str(Ydata1)
Ydata.df = as.data.frame(Ydata1)
str(Ydata.df)
#From wide to long
longY = Ydata.df %>%
  gather(key = "Item", value = "Y", c(-"ID"))
str(longY)

longRT1 = RTdata2[,c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,24)]
longRT = longRT1 %>%
  gather(key = "Item", value = "RT", c(-"ID"))
str(longRT)
#from character to numeric
longY$Item = gsub("\\D", "", longY$Item)
longY$Item = as.numeric(longY$Item)
str(longY$Item)

longRT$Item = gsub("\\D", "", longRT$Item)
longRT$Item = as.numeric(longRT$Item)
str(longRT)
#PROBLEM VARIABLE
longRT$Problem = longRT$Item
longRT$Problem[longRT$Problem == 2] = 1
longRT$Problem[longRT$Problem == 3] = 1
longRT$Problem[longRT$Problem == 4] = 1
longRT$Problem[longRT$Problem == 5] = 2
longRT$Problem[longRT$Problem == 6] = 2
longRT$Problem[longRT$Problem == 7] = 2
longRT$Problem[longRT$Problem == 8] = 2
longRT$Problem[longRT$Problem == 9] = 3
longRT$Problem[longRT$Problem == 10] = 3
longRT$Problem[longRT$Problem == 11] = 3
longRT$Problem[longRT$Problem == 12] = 3
longRT$Problem[longRT$Problem == 13] = 4
longRT$Problem[longRT$Problem == 14] = 4
longRT$Problem[longRT$Problem == 15] = 4
longRT$Problem[longRT$Problem == 16] = 4
longRT$Problem[longRT$Problem == 17] = 5
longRT$Problem[longRT$Problem == 18] = 5
longRT$Problem[longRT$Problem == 19] = 5
longRT$Problem[longRT$Problem == 20] = 5
longRT$Problem[longRT$Problem == 21] = 6

longY$Problem = longY$Item
longY$Problem[longY$Problem == 2] = 1
longY$Problem[longY$Problem == 3] = 1
longY$Problem[longY$Problem == 4] = 1
longY$Problem[longY$Problem == 5] = 2
longY$Problem[longY$Problem == 6] = 2
longY$Problem[longY$Problem == 7] = 2
longY$Problem[longY$Problem == 8] = 2
longY$Problem[longY$Problem == 9] = 3
longY$Problem[longY$Problem == 10] = 3
longY$Problem[longY$Problem == 11] = 3
longY$Problem[longY$Problem == 12] = 3
longY$Problem[longY$Problem == 13] = 4
longY$Problem[longY$Problem == 14] = 4
longY$Problem[longY$Problem == 15] = 4
longY$Problem[longY$Problem == 16] = 4
longY$Problem[longY$Problem == 17] = 5
longY$Problem[longY$Problem == 18] = 5
longY$Problem[longY$Problem == 19] = 5
longY$Problem[longY$Problem == 20] = 5
longY$Problem[longY$Problem == 21] = 6
#creating RT.sub and Y.sub
RTdata.sub = RTdata2
RTdata.sub$RT.sub1 = rowSums(RTdata2[,1:4])
RTdata.sub$RT.sub2 = rowSums(RTdata2[,5:8])
RTdata.sub$RT.sub3 = rowSums(RTdata2[,9:12])
RTdata.sub$RT.sub4 = rowSums(RTdata2[,13:16])
RTdata.sub$RT.sub5 = rowSums(RTdata2[,17:20])
RTdata.sub$RT.sub6 = RTdata.sub$Time21
RTdata.sub2 = RTdata.sub[,c("ID", "RT.sub1", "RT.sub2", "RT.sub3", 
                            "RT.sub4", "RT.sub5", "RT.sub6")]
Ydata.sub = Ydata.df
Ydata.sub$Y.sub1 = rowSums(Ydata.df[,2:5])
Ydata.sub$Y.sub2 = rowSums(Ydata.df[,6:9])
Ydata.sub$Y.sub3 = rowSums(Ydata.df[,10:13])
Ydata.sub$Y.sub4 = rowSums(Ydata.df[,14:17])
Ydata.sub$Y.sub5 = rowSums(Ydata.df[,18:21])
Ydata.sub$Y.sub6 = Ydata.df$It_21

Ydata.sub2 = Ydata.sub[,c("ID", "Y.sub1", "Y.sub2", "Y.sub3",
                          "Y.sub4", "Y.sub5", "Y.sub6")]
#from wide to long (.sub)
longRT.sub = RTdata.sub2 %>%
  gather(key = "Problem", value = "RT.sub", c(-"ID"))
longY.sub = Ydata.sub2 %>%
  gather(key = "Problem", value = "Y.sub", c(-"ID"))

#from character to numeric
longRT.sub$Problem = gsub("\\D", "", longRT.sub$Problem)
longRT.sub$Problem = as.numeric(longRT.sub$Problem)
str(longRT.sub)

longY.sub$Problem = gsub("\\D", "", longY.sub$Problem)
longY.sub$Problem = as.numeric(longY.sub$Problem)
str(longY.sub)
#creating RT.tot and Y.tot
longRT.tot = RTdata2
longRT.tot$RT.tot = rowSums(longRT.tot[,1:21])

longY.tot = Ydata.df
longY.tot$Y.tot = rowSums(longY.tot[,2:22])

longRT.tot2 = longRT.tot[,c("ID", "RT.tot")]
longY.tot2 = longY.tot[,c("ID", "Y.tot")]
#merging datasets
RTmerge = merge(longRT.sub, longRT.tot2, by = "ID")
Ymerge = merge(longY.sub, longY.tot2, by = "ID")

NEWmerge = merge(RTmerge, Ymerge)

longNEW = merge(longRT, longY)

NEWlongmerge = merge(NEWmerge, longNEW)

RTgenlang = RTdata2[,c("ID", "Gender", "Language")] 
#picking up Gender and Language

Final.dataset = merge(NEWlongmerge, RTgenlang)
str(Final.dataset)
# 
names(Final.dataset)[1]<-paste("Person")
Final.dataset = Final.dataset[,c("Person", "Gender", "Language", "Item", "Problem",
                                 "Y", "RT", "Y.sub", "RT.sub", "Y.tot", "RT.tot")]

Final.dataset = Final.dataset[order(Final.dataset[,4], -Final.dataset[,1],  
                                    Final.dataset[,5]), ]
Final.dataset$RT.tot = as.integer(Final.dataset$RT.tot)
Final.dataset$RT.sub = as.integer(Final.dataset$RT.sub)
str(Final.dataset)
head(Final.dataset)

#changing reaction time = o to NA 
Final_dataset$RT.sub[Final_dataset$RT.sub == 0] = NA
write.table(Final_dataset, file="../data/Assigment_RAPHAELPLANCE.txt",row.names = FALSE,
            sep="\t", dec = ".")

