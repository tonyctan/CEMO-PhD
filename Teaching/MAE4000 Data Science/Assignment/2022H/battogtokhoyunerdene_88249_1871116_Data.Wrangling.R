#Step 1
Ydata <- read_excel("data/Ydata.xlsx")
names(Ydata) = gsub(pattern="em", replacement="", names(Ydata)) 
names(Ydata) = gsub(pattern="It_", replacement="", names(Ydata)) 
View(Ydata)

install.packages("reshape2")
library("reshape2")
longY <- melt(Ydata,
              id.vars = c("ID"))
names(longY)[2:3]=c("Item","Y")
longY$Problem <- ifelse(longY$Item==1:4, 1, ifelse(longY$Item==5:8, 2, NA))
longY$Problem[longY$Item == "1"] = "1"
longY$Problem[longY$Item == "2"] = "1"
longY$Problem[longY$Item == "3"] = "1"
longY$Problem[longY$Item == "4"] = "1"
longY$Problem[longY$Item == "5"] = "2"
longY$Problem[longY$Item == "6"] = "2"
longY$Problem[longY$Item == "7"] = "2"
longY$Problem[longY$Item == "8"] = "2"
longY$Problem[longY$Item == "9"] = "3"
longY$Problem[longY$Item == "10"] = "3"
longY$Problem[longY$Item == "11"] = "3"
longY$Problem[longY$Item == "12"] = "3"
longY$Problem[longY$Item == "13"] = "4"
longY$Problem[longY$Item == "14"] = "4"
longY$Problem[longY$Item == "15"] = "4"
longY$Problem[longY$Item == "16"] = "4"
longY$Problem[longY$Item == "17"] = "5"
longY$Problem[longY$Item == "18"] = "5"
longY$Problem[longY$Item == "19"] = "5"
longY$Problem[longY$Item == "20"] = "5"
longY$Problem[longY$Item == "21"] = "6"
str(longY)

RTdata = read.csv(file="data/RTdata.csv",sep=";",header=TRUE,dec=".")
names(RTdata) = gsub(pattern="Time", replacement="It_", names(RTdata))
names(RTdata) = gsub(pattern="It_0", replacement="", names(RTdata))
names(RTdata) = gsub(pattern="It_", replacement="", names(RTdata))
longRT <- melt(RTdata,
               id.vars = c("ID"))
names(longRT)[2:3]=c("Item","RT")
longRT$Problem[longRT$Item == "1"] = "1"
longRT$Problem[longRT$Item == "2"] = "1"
longRT$Problem[longRT$Item == "3"] = "1"
longRT$Problem[longRT$Item == "4"] = "1"
longRT$Problem[longRT$Item == "5"] = "2"
longRT$Problem[longRT$Item == "6"] = "2"
longRT$Problem[longRT$Item == "7"] = "2"
longRT$Problem[longRT$Item == "8"] = "2"
longRT$Problem[longRT$Item == "9"] = "3"
longRT$Problem[longRT$Item == "10"] = "3"
longRT$Problem[longRT$Item == "11"] = "3"
longRT$Problem[longRT$Item == "12"] = "3"
longRT$Problem[longRT$Item == "13"] = "4"
longRT$Problem[longRT$Item == "14"] = "4"
longRT$Problem[longRT$Item == "15"] = "4"
longRT$Problem[longRT$Item == "16"] = "4"
longRT$Problem[longRT$Item == "17"] = "5"
longRT$Problem[longRT$Item == "18"] = "5"
longRT$Problem[longRT$Item == "19"] = "5"
longRT$Problem[longRT$Item == "20"] = "5"
longRT$Problem[longRT$Item == "21"] = "6"
str(longRT)

# Removing rows
longRT1<-subset(longRT, Item!="Group")

# Step 2
Ydata$Y.sub1 = rowSums(Ydata[,c("1", "2", "3", "4")])
Ydata$Y.sub2 = rowSums(Ydata[,c("5", "6", "7", "8")])
Ydata$Y.sub3 = rowSums(Ydata[,c("9", "10", "11", "12")])
Ydata$Y.sub4 = rowSums(Ydata[,c("13", "14", "15", "16")])
Ydata$Y.sub5 = rowSums(Ydata[,c("17", "18", "19", "20")])
Ydata$Y.sub6 = Ydata$`21`

RTdata$RT.sub1 = rowSums(RTdata[,c("1", "2", "3", "4")])
RTdata$RT.sub2 = rowSums(RTdata[,c("5", "6", "7", "8")])
RTdata$RT.sub3 = rowSums(RTdata[,c("9", "10", "11", "12")])
RTdata$RT.sub4 = rowSums(RTdata[,c("13", "14", "15", "16")])
RTdata$RT.sub5 = rowSums(RTdata[,c("17", "18", "19", "20")])
RTdata$RT.sub6 = RTdata$`21`

Ydata.small <- Ydata[c("ID","Y.sub1","Y.sub2","Y.sub3","Y.sub4","Y.sub5","Y.sub6")]
RTdata.small <- RTdata[c("ID","RT.sub1","RT.sub2","RT.sub3","RT.sub4","RT.sub5","RT.sub6")]

Y.subscore <- melt(Ydata.small,
                   id.vars = c("ID"))
RT.subscore <- melt(RTdata.small,
                    id.vars = c("ID"))
names(Y.subscore)[2:3]=c("Problem","Y.sub")
names(RT.subscore)[2:3]=c("Problem","RT.sub")

Ydata$Y.tot = rowSums(Ydata[,c("1", "2", "3", "4","5", "6", "7", "8","9", "10", "11", "12","13", "14", "15", "16","17", "18", "19", "20","21")])
RTdata$RT.tot = rowSums(RTdata[,c("1", "2", "3", "4","5", "6", "7", "8","9", "10", "11", "12","13", "14", "15", "16","17", "18", "19", "20","21")])

Ydata.small.with.tot <- Ydata[c("ID","Y.tot")]
RTdata.small.with.tot <- RTdata[c("ID","RT.tot")]

Y.Sub.Tot = merge(Y.subscore,Ydata.small.with.tot,by="ID")
RT.Sub.Tot = merge(RT.subscore,RTdata.small.with.tot,by="ID")

# To remove Y.sub and RT.sub from the value of Problem
remove1 = data.frame(gsub("Y.sub","",Y.Sub.Tot$Problem,perl=TRUE))
names(remove1) = c("Problem1")
remove2 = data.frame(gsub("RT.sub","",RT.Sub.Tot$Problem,perl=TRUE))
names(remove2) = c("Problem1")

Test1 = cbind(Y.Sub.Tot, remove1)
Ydata.subtot = Test1[c("ID", "Problem1", "Y.sub", "Y.tot")]
names(Ydata.subtot) = gsub(pattern="1", replacement="", names(Ydata.subtot)) 

Test2 = cbind(RT.Sub.Tot, remove2)
RTdata.subtot = Test2[c("ID", "Problem1", "RT.sub", "RT.tot")]
names(RTdata.subtot) = gsub(pattern="1", replacement="", names(RTdata.subtot)) 

# Split Gender and Language
Split.step1 = data.frame(do.call(rbind,strsplit(RTdata$Group,split = "\\_")))
names(Split.step1) = c("G","GenLan","BE")

Split.step2 = data.frame(do.call(rbind,strsplit(Split.step1$GenLan,split = "[A-Z]{2}$")))
names(Split.step2)=c("Gender1")
Split.step3 = data.frame(stri_sub(Split.step1$GenLan,-2))
names(Split.step3)=c("Language1")

# add gender and language separately
RTdata.with.gen.lan = cbind(RTdata, Split.step2, Split.step3)

# Subsetting Gender and Language
Data.frame1 = RTdata.with.gen.lan[c("ID", "Gender1", "Language1")]

# Factoring Gender and Language
Data.frame1$Gender[Data.frame1$Gender1 == "Female"] = "1"
Data.frame1$Gender[Data.frame1$Gender1 == "Male"] = "2"
Data.frame1$Gender[Data.frame1$Gender1 == "Unknown"] = "NA"
Data.frame1$Gender = factor(Data.frame1$Gender1, levels = c("Male", "Female"))
Data.frame1$Language = factor(Data.frame1$Language1, levels = c("FR", "NL"))
Gen.Lan = Data.frame1[c("ID", "Gender", "Language")]
str(Gen.Lan)

# Test merge
first = merge(RTdata.subtot,Ydata.subtot, all = TRUE)
second = merge(longY, longRT1, all = TRUE)
third = merge(first, second, all = TRUE)
the.last = merge(third, Gen.Lan, all = TRUE)

# Removing person 501
Last.data.frame<-subset(the.last, ID!="501")

# ID to Person
names(Last.data.frame) = gsub(pattern="ID", replacement="Person", names(Last.data.frame))

# Result... But, without correct ordering and sorting by Person
str(Last.data.frame)
tail(Last.data.frame, 3)

