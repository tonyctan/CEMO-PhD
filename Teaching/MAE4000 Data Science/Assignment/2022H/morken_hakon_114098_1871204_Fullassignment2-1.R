#Import and reorder Ydata
library(readxl)
Ydata <- read_excel("~/Desktop/Assessment, Measurement and Evaluation S1/MAE4000/data/Ydata.xlsx")
Ydata1= Ydata 
Ydata1 = Ydata1[,c( 1, 19, 8, 12, 21, 6, 10, 18, 7, 4, 3, 13, 14, 17, 16, 5, 11, 2, 20, 9, 15, 22)]
Ydata1 = as.data.frame(Ydata1)
duplicated(Ydata1$ID)
longY = reshape(Ydata1, direction = "long", idvar = "ID", varying = list(c("Item_1", "Item_2", "Item_3", "Item_4", "Item_5", "Item_6", "Item_7", "Item_8", "Item_9", "It_10", "It_11", "It_12", "It_13", "It_14", "It_15", "It_16", "It_17", "It_18", "It_19", "It_20", "It_21")))
colnames(longY) = c("ID", "Item", "Y")


#Import and reorder RTdata
library(readr)
RTdata <- read.table("/Users/nils/Desktop/Assessment, Measurement and Evaluation S1/MAE4000/data/RTdata.csv", header= TRUE, sep=";")
library(tibble)
RTdata <- as_tibble(RTdata)
RTdata = RTdata[c(23, 22, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 15, 14, 13, 16, 19, 18, 17, 20, 21)]
RTdata = as.data.frame(RTdata)
duplicated(RTdata$ID)

#Removing duplicated IDs from RTdata
RTdata <- RTdata[!duplicated(RTdata$ID),]
#Making RTdata into longformat
longRT = reshape(RTdata, direction = "long", idvar = "id", varying = list(c("Time01",	"Time02",	"Time03",	"Time04",	"Time05",	"Time06",	"Time07",	"Time08",	"Time09",	"Time10",	"Time11",	"Time12",	"Time13",	"Time14", "Time15",	"Time16",	"Time17",	"Time18", "Time19",	"Time20",	"Time21")))
colnames(longRT) = c("ID", "Group", "Item", "RT", "id")

#Splitting variable Group
subRTdata = RTdata[c(1,2)]
subRTdata2 = data.frame(do.call(rbind,strsplit(subRTdata$Group,split = "_")))
subRTdata23 = cbind(subRTdata, subRTdata2)
subRTdata23 = subRTdata23[,c(1,4)]
subRTdata23$Gender = substr(subRTdata23$X2, 1,1)
subRTdata23$Lang = substr(subRTdata23$X2, nchar(subRTdata23$X2)-1, nchar(subRTdata23$X2))
subRTdata123 =subRTdata23[c(1,3,4)]

#merge - not complete
subRT = cbind(subRTdata123, longRT)
subRT = subRT[c(1,2,3,6,7)]
subRT1 = subRT
subRT1$idf <- paste(subRT1$ID, subRT1$Item)
longY$idf <- paste(longY$ID, longY$Item)

#making Y.tot 
Ydata3 = Ydata1
Ydata3$Y.tot = apply(Ydata3[,c(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22)], 1, sum)
longYtot = reshape(Ydata3, direction = "long", idvar = "ID", varying = list(c("Item_1", "Item_2", "Item_3", "Item_4", "Item_5", "Item_6", "Item_7", "Item_8", "Item_9", "It_10", "It_11", "It_12", "It_13", "It_14", "It_15", "It_16", "It_17", "It_18", "It_19", "It_20", "It_21")))
longYtot$idf <- paste(longYtot$ID, longYtot$time)

#making RT.tot
RTdata1 = RTdata
RTdata1$RT.tot = apply(RTdata1[c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)],1,sum)
longRTtot = reshape(RTdata1, direction="long", idvar = "id", varying = list(c("Time01",	"Time02",	"Time03",	"Time04",	"Time05",	"Time06",	"Time07",	"Time08",	"Time09",	"Time10",	"Time11",	"Time12",	"Time13",	"Time14", "Time15",	"Time16",	"Time17",	"Time18", "Time19",	"Time20",	"Time21")))
longRTtot$idf <- paste(longRTtot$ID, longRTtot$time)

#merge rt.tot and y.tot with larger dataset
totset <- merge(longRTtot, longYtot, by="idf")
totset1 <- merge (totset, subRT1, by= "idf")
totset1 <- totset1[c(1,2,4,5,6,9,11,13,14)]
colnames(totset1) <- c("IDEN", "Person", "RT.tot","Item", "RT", "Y.tot", "Y", "Gender", "Language")
totset1<- totset1[c(2, 8, 9, 4, 7, 5, 6,3,1 )]

#making problem
totset1$Problem <- ifelse(totset1$Item %in% 1:4, 1, ifelse(totset1$Item %in% 5:8, 2, ifelse(totset1$Item %in% 9:12, 3, ifelse(totset1$Item %in% 13:16, 4, ifelse(totset1$Item %in% 17:20,5, 6))))) 

#making rt.sub
install.packages("tidyverse")
library("tidyverse")

RTdata3 <- RTdata
RTdata3 <- RTdata3 %>% mutate(Rt.sub1 = rowSums(.[3:6]))
RTdata3 <- RTdata3 %>% mutate(Rt.sub2 = rowSums(.[7:10]))                              
RTdata3 <- RTdata3 %>% mutate(Rt.sub3 = rowSums(.[11:14]))
RTdata3 <- RTdata3 %>% mutate(Rt.sub4 = rowSums (.[15:18]))  
RTdata3 <- RTdata3 %>% mutate(Rt.sub5 = rowSums(.[19:22]))   
RTdata3 <- RTdata3 %>% mutate(Rt.sub6 = rowSums(.[23]))
RTdata3 <- RTdata3[,c(1,24, 25,26,27,28,29)]


#making Y.sub
Ydata4 <- Ydata1
Ydata4 <- Ydata4 %>% mutate(Y.1 = rowSums(.[2:5]))
Ydata4 <- Ydata4 %>% mutate(Y.2 = rowSums(.[6:9]))
Ydata4 <- Ydata4 %>% mutate(Y.3 = rowSums(.[10:13]))
Ydata4 <- Ydata4 %>% mutate(Y.4 = rowSums(.[14:17]))
Ydata4 <- Ydata4 %>% mutate(Y.5 = rowSums(.[18:21]))
Ydata4 <- Ydata4 %>% mutate(Y.6 = rowSums(.[22]))
Ydata4 <- Ydata4[,c(1,23,24,25,26,27,28)]



#merge rt.sub to totset1
longRTsub <- reshape(RTdata3, direction = "long", idvar = "id", timevar ="Problem", varying = list(c("Rt.sub1", "Rt.sub2", "Rt.sub3", "Rt.sub4", "Rt.sub5", "Rt.sub6")))
longRT$Problem <- ifelse(longRT$Item %in% 1:4, 1, ifelse(longRT$Item %in% 5:8, 2, ifelse(longRT$Item %in% 9:12, 3, ifelse(longRT$Item %in% 13:16, 4, ifelse(longRT$Item %in% 17:20,5, 6))))) 
longRT$idf <- paste(longRT$ID, longRT$Problem)
longRTsub$idf <- paste(longRTsub$ID, longRTsub$Problem)
longRTSub1 <- merge(longRT, longRTsub, by ="idf" )
longRTSub1$idf <- paste(longRTSub1$ID.x, longRTSub1$Item)
longRTSub1 <- longRTSub1[,c(1,10)]
colnames(longRTSub1) <- c("IDEN", "RT.sub")
totset1 <- merge(totset1, longRTSub1, by="IDEN")
totset1 <- totset1[,c(1,2,3,4,5,6,7,8,9,10,11)]


#merge y.sub to totset1
longYsub <- reshape(Ydata4, direction = "long", idvar = "id", timevar ="Problem", varying = list(c("Y.1", "Y.2", "Y.3", "Y.4", "Y.5", "Y.6")))
longY$Problem <- ifelse(longY$Item %in% 1:4, 1, ifelse(longY$Item %in% 5:8, 2, ifelse(longY$Item %in% 9:12, 3, ifelse(longY$Item %in% 13:16, 4, ifelse(longY$Item %in% 17:20,5, 6))))) 
longY$idf <- paste(longY$ID, longY$Problem)
longYsub$idf <- paste(longYsub$ID, longYsub$Problem)
longYSUB <- merge(longYsub, longY, by = "idf") 
longYSUB$idf <- paste(longYSUB$ID.x, longYSUB$Item)
longYSUB <- longYSUB[c(1,4)]
colnames(longYSUB) <- c("IDEN", "Y.sub")
totset1 <- merge(totset1, longYSUB, by = "IDEN")



#Reorder totset1 and change the names 
totset1 <- totset1[,c(2,3,4,5,10,6,7,12,11,8,9)]
colnames(totset1) <- c("Person", "Gender", "Language", "Item", "Problem", "Y", "RT", "Y.sub", "RT.sub", "Y.tot", "RT.tot")


#exporting dataset
write.table(totset1, file = "/Users/nils/Desktop/Assessment, Measurement and Evaluation S1/MAE4000/R/totset1.txt", dec = ".", sep = "\t")



