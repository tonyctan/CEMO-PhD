#Step 1
library("readxl")
getwd()
setwd("C:/Users/Tony/Desktop/submissions")
Ydata <- read_excel("data/Ydata.xlsx")
names(Ydata) = gsub(pattern="em", replacement="", names(Ydata)) 
names(Ydata) = gsub(pattern="It_", replacement="", names(Ydata)) 
str(Ydata)
Ydata <- as.data.frame(Ydata)
str(Ydata)

# Reshaping Ydata
longY = reshape(Ydata,direction="long",idvar="ID",varying=list(c("1", "2", "3", "4","5", "6", "7", "8","9", "10", "11", "12","13", "14", "15", "16","17", "18", "19", "20","21")))
names(longY)[2:3]=c("Item","Y")

# RTdata
RTdata = read.csv(file="data/RTdata.csv",sep=";",header=TRUE,dec=".")
names(RTdata) = gsub(pattern="Time", replacement="It_", names(RTdata))
names(RTdata) = gsub(pattern="It_0", replacement="", names(RTdata))
names(RTdata) = gsub(pattern="It_", replacement="", names(RTdata))
str(RTdata)

# Deleting duplicates
RTdata$ID[duplicated(RTdata$ID)]
table(RTdata$ID)
RTdata = RTdata[!duplicated(RTdata$ID), ]
RTdata$ID[duplicated(RTdata$ID)]

# Reshaping RTdata
longRT = reshape(RTdata,direction="long",idvar="ID",varying=list(c(1:21)))
names(longRT)[3:4]=c("Item","RT")
longRT = longRT[c("ID","Item", "RT")]

# Removing rows
longRT<-subset(longRT, Item!="Group")


# Adding Problem variable
longY$Item = as.numeric(longY$Item)
longY$Problem <- ceiling(longY$Item/4)
str(longY)
longRT$Item = as.numeric(longRT$Item)
longRT$Problem <- ceiling(longRT$Item/4)
str(longRT)

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

# Subsetting and Reshaping subscores 
Ydata.small <- Ydata[c("ID","Y.sub1","Y.sub2","Y.sub3","Y.sub4","Y.sub5","Y.sub6")]
RTdata.small <- RTdata[c("ID","RT.sub1","RT.sub2","RT.sub3","RT.sub4","RT.sub5","RT.sub6")]

Y.subscore = reshape(Ydata.small,direction="long",idvar="ID",varying=list(c(2:7)))
RT.subscore = reshape(RTdata.small,direction="long",idvar="ID",varying=list(c(2:7)))
names(Y.subscore)[2:3]=c("Problem","Y.sub")
names(RT.subscore)[2:3]=c("Problem","RT.sub")

# Adding total score variables
Ydata$Y.tot = rowSums(Ydata[,c(2:22)])
RTdata$RT.tot = rowSums(RTdata[,c(1:21)])

# Subsetting and Merging totalscores 
Ydata.tot.scores <- Ydata[c("ID","Y.tot")]
RTdata.tot.scores <- RTdata[c("ID","RT.tot")]

Y.Sub.Tot = merge(Y.subscore,Ydata.tot.scores,by="ID")
RT.Sub.Tot = merge(RT.subscore,RTdata.tot.scores,by="ID")
Y.Sub.Tot$Problem = as.numeric(Y.Sub.Tot$Problem)
RT.Sub.Tot$Problem = as.numeric(RT.Sub.Tot$Problem)
RT.Sub.Tot$ID = as.numeric(RT.Sub.Tot$ID)

# Step 3
# Split Gender and Language
Split.step1 = data.frame(do.call(rbind,strsplit(RTdata$Group,split = "\\_")))
names(Split.step1) = c("G","GenLan","BE")

Split.step2 = data.frame(do.call(rbind,strsplit(Split.step1$GenLan,split = "[A-Z]{2}$")))
names(Split.step2)=c("Gender1")
library("stringi")
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
Data.frame1$Gender = factor(Data.frame1$Gender1, levels = c("Female", "Male"))
Data.frame1$Language = factor(Data.frame1$Language1, levels = c("FR", "NL"))
Gen.Lan = Data.frame1[c("ID", "Gender", "Language")]
str(Gen.Lan)
Gen.Lan$ID = as.numeric(Gen.Lan$ID)

# The last merge
first = merge(RT.Sub.Tot,Y.Sub.Tot, all = TRUE)
second = merge(longY, longRT, all = TRUE)
third = merge(first, second, all = TRUE)
the.last = merge(third, Gen.Lan, all = TRUE)

the.last$RT.sub = as.integer(the.last$RT.sub)
the.last$RT.tot = as.integer(the.last$RT.tot)

# ID to Person
names(the.last) = gsub(pattern="ID", replacement="Person", names(the.last))
str(the.last)

# Reordering
data <- the.last[, c("Person","Gender","Language","Item","Problem", "Y","RT","Y.sub","RT.sub","Y.tot","RT.tot")]

# Ordering
sorted <- data[order(data$Item, -data$Person),]
str(sorted)

# Removing Person #501 to the bottom of data.frame
top = sorted[-grep("501", sorted$Person),]
bottom = sorted[grep("501", sorted$Person),]
the.last = rbind(top, bottom)
rownames(the.last) <- c(1:10521)

# Result check
str(the.last)
head(the.last, 3)

# Exporting as .txt file
write.table(the.last, file = "the.last.txt", sep = "\t",
            row.names = FALSE)
Check = read.table(file="the.last.txt", header = TRUE)