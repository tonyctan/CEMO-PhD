#Imported files
RTdata = read.table(file = "data/RTdata.csv", 
                    header = TRUE, sep = ";")
View(RTdata)

saveRDS(RTdata, file = "data/RTdata2.Rds")
RTdata2 = readRDS(file = "data/RTdata2.Rds")
all.equal(RTdata, RTdata2)

library(readxl)
Ydata <- read_excel("data/Ydata.xlsx")
View(Ydata)
Ydata2 <- as.data.frame(Ydata) #converted tibble to data.frame
str(Ydata2)
saveRDS(Ydata2, file = "data/NewYdata.Rds")
NewYdata = readRDS(file = "data/NewYdata.Rds")
all.equal(Ydata2, NewYdata)

#RTdata restructuring
NewRTdata <- RTdata2[order(RTdata2$ID),order(names(RTdata2))]
table(NewRTdata$Group)
NewRTdata$Group = gsub("Gender_Female", "Female_", NewRTdata$Group)
NewRTdata$Group = gsub("Gender_Male", "Male_", NewRTdata$Group)
NewRTdata$Group = gsub("Gender_Unknown", "Unknown_", NewRTdata$Group)
NewRTdata$Group = gsub("_BE", "", NewRTdata$Group)
table(NewRTdata$Group)

NewRTdata <- cbind(NewRTdata, data.frame(do.call(rbind,strsplit(as.character(NewRTdata$Group), "_",))))
names(NewRTdata)[24] <- "Gender"
names(NewRTdata)[25] <- "Language"
names(NewRTdata)

which(duplicated(NewRTdata$ID))

NewRTdata <- NewRTdata[!duplicated(NewRTdata$ID),] #took out duplicated IDs

NewRTdata2 = reshape(NewRTdata, direction = "long", idvar = "ID", varying=list(c("Time01", "Time02", "Time03","Time04", "Time05", "Time06", "Time07", "Time08", "Time09", "Time10", "Time11", "Time12", "Time13", "Time14", "Time15", "Time16", "Time17", "Time18", "Time19", "Time20", "Time21")), v.names = "RT", "Item")
NewRTdata2 <- NewRTdata2[, -c(1)]


NewRTdata2$Gender <- replace(NewRTdata2$Gender, NewRTdata2$Gender == "Unknown", NA)
NewRTdata2$Gender <- as.factor(NewRTdata2$Gender)
class(NewRTdata2$Gender)
NewRTdata2$Language <- as.factor(NewRTdata2$Language)
class(NewRTdata2$Language)
NewRTdata2$RT <- replace(NewRTdata2$RT, NewRTdata2$RT == 0, NA)
str(NewRTdata2)

#make a unique id "Person"
NewRTdata2$Person <- paste(NewRTdata2$ID, NewRTdata2$Item, sep = "_")
class(NewRTdata2$Person)

#make a new variable "Problem"
Problem <- cut(NewRTdata2$Item, breaks=c(-0.01, 4, 8, 12, 16, 20, Inf), labels= c(1:6))
NewRTdata2$Problem <- Problem
NewRTdata2$Problem <- as.numeric(NewRTdata2$Problem)

#Ydata restructuring
names(NewYdata) = gsub("It_", "Item", names(NewYdata))
names(NewYdata)= gsub("Item_", "Item", names(NewYdata))

names(NewYdata)

order <- c("ID", "Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "Item9", "Item10", "Item11", "Item12", "Item13", "Item14", "Item15", "Item16", "Item17", "Item18", "Item19", "Item20", "Item21")
NewYdata <- NewYdata[,order]
str(NewYdata)

NewYdata2 = reshape(NewYdata, direction = "long", idvar = "ID", varying= list(c("Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "Item9", "Item10", "Item11", "Item12", "Item13", "Item14", "Item15", "Item16", "Item17", "Item18", "Item19", "Item20", "Item21")), v.names = "Y", "Item")
str(NewYdata2)
names(NewYdata2)

#make new variable "Problem"
Problem <- cut(NewYdata2$Item, breaks=c(-0.01, 4, 8, 12, 16, 20, Inf), labels= c(1:6))
NewYdata2$Problem <- Problem
NewYdata2$Problem <- as.numeric(NewYdata2$Problem)

#Sub data sets  for sub and tot
#RT.sub and RT.tot
saveRDS(NewRTdata, file = "data/SumsRTdata.Rds")
SumsRTdata = readRDS(file = "data/SumsRTdata.Rds")

SumsRTdata$AA <- rowSums(SumsRTdata[3:6])
SumsRTdata$BB <- rowSums(SumsRTdata[7:10])
SumsRTdata$CC <- rowSums(SumsRTdata[11:14])
SumsRTdata$DD <- rowSums(SumsRTdata[15:18])
SumsRTdata$EE <- rowSums(SumsRTdata[19:22])
SumsRTdata$FF <- rowSums(SumsRTdata[23])

SumsRTdata <- SumsRTdata[,c(2,26:31)]
SumsRTdata$RT.tot <- rowSums((SumsRTdata[2:7]))

SumsRTdataSub <- SumsRTdata[,c(1:7)]
SumsRTdataTot <- SumsRTdata[,c(1,8)]

SumsRTdataSub <- reshape(SumsRTdataSub, direction = "long", idvar = "ID", varying = list(c("AA", "BB", "CC", "DD", "EE", "FF")), v.names = "RT.sub", "Problem")

SumsRTdata2 <- merge(SumsRTdataSub, SumsRTdataTot, by= "ID")

#make a unique id "Person_P"
SumsRTdata2$Person_P <- paste(SumsRTdata2$ID, SumsRTdata2$Problem, sep = "_")

#Y.sub and Y.tot
saveRDS(NewYdata, file = "data/SumsYdata.Rds")
SumsYdata = readRDS(file = "data/SumsYdata.Rds")

SumsYdata$AA <- rowSums(SumsYdata[2:5])
SumsYdata$BB <- rowSums(SumsYdata[6:9])
SumsYdata$CC <- rowSums(SumsYdata[10:13])
SumsYdata$DD <- rowSums(SumsYdata[14:17])
SumsYdata$EE <- rowSums(SumsYdata[18:21])
SumsYdata$FF <- rowSums(SumsYdata[22])

SumsYdata <- SumsYdata[,c(1,23:28)]
SumsYdata$Y.tot <- rowSums((SumsYdata[2:7]))

SumsYdataSub <- SumsYdata[,c(1:7)]
SumsYdataTot <- SumsYdata[,c(1,8)]

SumsYdataSub <- reshape(SumsYdataSub, direction = "long", idvar = "ID", varying = list(c("AA", "BB", "CC", "DD", "EE", "FF")), v.names = "Y.sub", "Problem" )
SumsYdataSub$Problem <- as.numeric(SumsYdataSub$Problem)

SumsYdata2 <-merge(SumsYdataSub, SumsYdataTot, by="ID")

NewYdata2$Person <- paste(NewYdata2$ID, NewYdata2$Item, sep = "_")
class(NewYdata2$Person)

#make unique id "Person_P"
SumsYdata2$Person_P <- paste(SumsYdata2$ID, SumsYdata2$Problem, sep = "_")

#to merge: SumsRTdata2 and SumsYdata2
sumstrialmerge <- merge(SumsRTdata2, SumsYdata2, by ="Person_P")

#new data frame for RT.sub, RT.tot, Y.sub and Y.tot
RTYdatamerge2 <- sumstrialmerge[, c(1:5,8,9)]


# to merge NewRTdata2 and NewYdata2
trialmerge <- merge(NewRTdata2, NewYdata2, by = "Person")

#new data frame from main RT and Y data
RTYdatamerge1 <- trialmerge[,c(1:7,10)]

#make new unique id "Person_P" for main
RTYdatamerge1$Person_P <- paste(RTYdatamerge1$ID.x, RTYdatamerge1$Problem.x, sep = "_")


#merge RTYdatamerge1 and RTYdatamerge2 to RTYdatamerge
RTYdatamerge <- merge(RTYdatamerge1, RTYdatamerge2, by = "Person_P")

RTYdatamerge <- RTYdatamerge[, c("ID.x.x", "Gender", "Language", "Item.x", "Problem.x.x", "Y", "RT", "Y.sub", "RT.sub", "Y.tot", "RT.tot")]
names(RTYdatamerge)[1] <- "Person"
names(RTYdatamerge)[4] <- "Item"
names(RTYdatamerge)[5] <- "Problem"
names(RTYdatamerge)

#Final merged dataframe
str(RTYdatamerge)
dim(RTYdatamerge)
RTYdatamerge$Person <- as.numeric(RTYdatamerge$Person)
RTYdatamerge$Item <- as.numeric(RTYdatamerge$Item)
RTYdatamerge$RT.sub <- as.integer(RTYdatamerge$RT.sub)
RTYdatamerge$RT.tot <- as.integer(RTYdatamerge$RT.tot)

RTYdatamerge <- RTYdatamerge[order(RTYdatamerge[,4], -RTYdatamerge[,1]),] #reordered "Item" then "Person"

write.table(RTYdatamerge, file = "data/RTYdatamerge-exported.txt", row.names = FALSE, sep = "\t", dec = ".")

