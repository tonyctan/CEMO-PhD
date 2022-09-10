## IMPORTING DATASETS
library(readr)
RTdata <- read_delim("../data/RTdata.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
library(readxl)
Ydata <- read_excel("../data/Ydata.xlsx")

##RESHAPING

colnames(Ydata)
## Reordering columns for clarity
Ydata_order <- Ydata[,c(1, 19, 8, 12, 21, 6, 10, 18, 7, 4, 3, 13, 14, 17, 16, 5, 11, 2, 20, 9, 15, 22)]

## Renaming variables 
colnames(Ydata_order)
names(Ydata_order)[2:22] <- paste("Item", 1:21, sep = "_")
Ydata <- data.frame(Ydata_order)

## Reshape
## Comment: I couldn't make work a function to not having manually write all variables
longY = reshape(Ydata, direction = "long", idvar = "ID", varying = list(c("Item_1","Item_2","Item_3", "Item_4", "Item_5", "Item_6", "Item_7", "Item_8", "Item_9", "Item_10", "Item_11", "Item_12", "Item_13", "Item_14", "Item_15", "Item_16", "Item_17", "Item_18", "Item_19", "Item_20", "Item_21")))

## Replacing columns names
names(longY)[3] <- paste("Y")
names(longY)[2] <- paste("Item")

## Addressing data set RTdata now
ncol(RTdata)

##Reordering for clarity 
RTdata_order <- RTdata[, c(23, 22, 1:21)]
RTdata <- data.frame(RTdata_order)

##Reshape Y
#longRT = reshape(RTdata, direction = "long", idvar = "ID", varying = list(c("Time01", "Time02", "Time03", "Time04", "Time05", "Time06", "Time07", "Time08", "Time09", "Time10", "Time11", "Time12", "Time13", "Time14", "Time15", "Time16", "Time17", "Time18", "Time19", "Time20", "Time21")))

##Got error about duplicated IDs. Checking.
length(unique(RTdata$ID))
nrow(RTdata)
RTdata$ID[duplicated(RTdata$ID)]

##IDs 327, 40, 27 are duplicated
RTdata[,1]

##Replacing missing IDs

RTdata[171,1] = 328

RTdata[460,1] = 39

RTdata[471,1] = 28

RTdata[,1]

##Reshape RT
longRT = reshape(RTdata, direction = "long", idvar = "ID", varying = list(c("Time01", "Time02", "Time03", "Time04", "Time05", "Time06", "Time07", "Time08", "Time09", "Time10", "Time11", "Time12", "Time13", "Time14", "Time15", "Time16", "Time17", "Time18", "Time19", "Time20", "Time21")))
names(longRT)[4] <- paste("RT")
names(longRT)[3] <- paste("Item")


##Computing Problem variable

install.packages("tidyverse")
library(tidyverse)
install.packages("sjmisc")
library(sjmisc)

longRT$Problem <-longRT$Item
longRT$Problem = rec(longRT$Problem, as.num = TRUE, rec = "1:4 = 1; 5:8 = 2; 9:12 = 3; 13:16 = 4; 17:20 = 5; 21 = 6")
longY$Problem <-longY$Item
longY$Problem = rec(longY$Problem, as.num = TRUE, rec = "1:4 = 1; 5:8 = 2; 9:12 = 3; 13:16 = 4; 17:20 = 5; 21 = 6")
View(longY)

RTsubscore <- RTdata
Ysubscore <- Ydata

View(RTsubscore)
RTsubscore$YsubP1 = rowSums(RTsubscore[, c(3:6)])
RTsubscore$YsubP2 = rowSums(RTsubscore[, c(7:10)])
RTsubscore$YsubP3 = rowSums(RTsubscore[, c(11:14)])
RTsubscore$YsubP4 = rowSums(RTsubscore[, c(15:18)])
RTsubscore$YsubP5 = rowSums(RTsubscore[, c(19:22)])
RTsubscore$YsubP6 = RTsubscore$Time21
ncol(RTsubscore)

RT.presub <- RTsubscore[-c(2:23)]
View(RT.presub)
RT.sub = reshape(RT.presub, direction = "long", idvar = "ID", varying = list(c(2:7)))
View(RT.presub)
RTsubscore$YsubTotal = rowSums(RTsubscore[, c(23:29)])

write.table(longRT, file = "../data/longRT.txt", row.names = FALSE, sep = " ", dec = ".")
write.table(longY, file = "../data/longY.txt", row.names = FALSE, sep = " ", dec = ".")
write.table(Ysubscore, file = "../data/Ysubscore.txt", row.names = FALSE, sep = " ", dec = ".")
