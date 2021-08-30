# Installation of Libraries
library(readxl)
library(tidyverse)
library(dplyr)
library(tidyr)

# Importing data sets to R working environment
Ydata <- read_excel("../data/Ydata.xlsx")
RTdata <- read.csv(file = "../data/RTdata.csv", header = TRUE, sep = ";")

# Reordering the Column names and Column order of the Y data set
Ydata1 <- Ydata # Make a copy
names(Ydata1) <- gsub("It_", "", names(Ydata1))
names(Ydata1) <- gsub("_", "", names(Ydata1))
names(Ydata1) <- gsub("Item", "", names(Ydata1))
Ydata1 <- Ydata1[, c(
    "ID", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
    "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"
)]

# Checking whether all the ID number sin Ydata is sequenced properly.
y <- seq(from = 1, to = 500)
Id_y <- Ydata1$ID
y - Id_y
# ID numbers for the Ydata is sequenced properly.

# Ordering two data sets in decreasing order: from 500 to 1 (Based on ID)
Ydata2 <- Ydata1[order(Ydata1$ID, decreasing = TRUE),]
Ydata3 <- Ydata2
names(Ydata3) <- as.numeric(names(Ydata3))

# Reordering the Column names and Column order of the Y data set.

RTdata1 <- RTdata # Make a copy
names(RTdata1) <- gsub("Time", "", names(RTdata1))
RTdata1 <- RTdata1[, c(
    "ID", "Group", "01", "02", "03", "04", "05", "06", "07",
    "08", "09", "10", "11", "12", "13", "14", "15", "16", "17",
    "18", "19", "20", "21"
)]
names(RTdata1)[-c(1, 2)] <- as.numeric(names(RTdata1)[-c(1, 2)])

# Checking whether all the ID numbers are sequenced properly in RT data set.
ID_z <- RTdata1$ID
x <- seq(from = 500, to = 3)
diff <- x - ID_z
diff_1 <- c(0, diff)
diff_2 <- c(diff, 0)
diff_3 <- diff_2 - diff_1
cbind(seq(1:499), diff_3)
# In fact, there are a number of errors require further attention.

# Issue number 1: 98th line of the RTdata (Wrong naming)
RTdata1$ID[98] <- 401

# Issue number 2: 171th line of RTdata (wrong naming)
RTdata1$ID[171] <- 328

# Issue number 3: 460th line of RTdata (Wrong naming)
RTdata1$ID[460] <- 39

# Issue number 4: 471th line of RTdata (Wrong naming)
RTdata1$ID[471] <- 28

# Issue number 5: 29-30th lines of RTdata (Missing Research Units)
RTdata470 <- data.frame(470, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)
RTdata471 <- data.frame(471, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)
names(RTdata470) <- names(RTdata1)
names(RTdata471) <- names(RTdata1)
RTdata2 <- rbind(RTdata1, RTdata470, RTdata471)

# Separating Gender and language within the group variable. 
RTdata3 <- RTdata2
RTdata3$Group <- gsub("Gender", "", RTdata3$Group )
RTdata3$Group <- gsub("BE", "", RTdata3$Group)
RTdata3$Group <- gsub("_", "", RTdata3$Group)
RTdata3$Group <- gsub("FR", "_FR", RTdata3$Group)
RTdata3$Group <- gsub("NL", "_NL", RTdata3$Group)
RTdata4 <- RTdata3
RTdata4 <- separate(RTdata4, col = Group, into = c("Gender", "Language"), sep = "_")
# The group column has been separated into two different variables: Gender and Language 

# However, the "Unknown" value still needs to be identified as NA. 
RTdata4$Gender <- gsub("Unknown", NA ,RTdata4$Gender)


# Checking if both of the data sets are ordered in parallel to each other 
head(Ydata2)
head(RTdata5)
str(RTdata5)

# Factor separation for RTdata set. 
RTdata5 <- RTdata4
RTdata5$Gender <- factor(RTdata5$Gender,levels = c("Male", "Female"), 
                         labels = c("Male", "Female"), ordered = is.ordered(RTdata5$Gender))
RTdata5$Language <- factor(RTdata5$Language, levels = c("NL", "FR"), 
                           labels = c("NL", "FR"), ordered = is.ordered(RTdata5$Language))

# Checking whether the Gender and Language columns are factorised correctly. 
str(RT)


# Full merging together and changing the header 
merge1 <- full_join(Ydata2, RTdata5, by = "ID", copy = FALSE)
str(merge1)
names(merge1) <- gsub(".x", "Y", names(merge1))
names(merge1) <- gsub(".y", "T", names(merge1))
merge2 <- merge1[,order(names(merge1), decreasing = F)]

merge3 <- merge2[, c("ID", "Gender", "Language","1T","1Y","2T","2Y","3T","3Y","4T","4Y","5T","5Y","6T","6Y",
                     "7T","7Y","8T","8Y","9T","9Y","10T","10Y", "11T","11Y","12T"
                     ,"12Y","13T","13Y","14T","14Y","15T","15Y","16T","16Y","17T"
                     ,"17Y","18T","18Y","19T","19Y","20T","20Y", "21T", "21Y")]
names(merge3) <- c("ID", "Gender", "Language",
                   "T1.1","Y1.1","T1.2","Y1.2", "T1.3", "Y1.3","T1.4","Y1.4",
                   "T2.1","Y2.1","T2.2","Y2.2", "T2.3", "Y2.3","T2.4","Y2.4",
                   "T3.1","Y3.1","T3.2","Y3.2", "T3.3","Y3.3","T3.4"
                     ,"Y3.4","T4.1","Y4.1","T4.2","Y4.2","T4.3","Y4.3","T4.4","Y4.4","T5.1"
                     ,"Y5.1","T5.2","Y5.2","T5.3","Y5.3","T5.4", "Y5.4","T6.1", "Y6.1")

# First attempt at reshaping the dataset 
Transformed_Data <- reshape(merge3, direction = "long", idvar = "ID",
                            varying = list(c("T1.1","Y1.1","T1.2","Y1.2","T1.3",
                                             "Y1.3","T1.4","Y1.4","T2.1","Y2.1","T2.2","Y2.2",
                                              "T2.3","Y2.3","T2.4","Y2.4","T3.1","Y3.1","T3.2","Y3.2", "T3.3","Y3.3","T3.4"
                                              ,"Y3.4","T4.1","Y4.1","T4.2","Y4.2","T4.3","Y4.3","T4.4","Y4.4","T5.1"
                                              ,"Y5.1","T5.2","Y5.2","T5.3","Y5.3","T5.4", "Y5.4","T6.1", "Y6.1")), sep = ".")

Transformed_dataRT <- reshape(RTdata5, direction = "long", idvar = "ID",
                            varying = list(c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
                                             "12", "13", "14", "15", "16", "17", "18", "19", "20", "21")))
Transformed_dataY <- reshape(Ydata2, direction = "long", idvar = "ID",
                             varying = list(c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
                                              "12", "13", "14", "15", "16", "17", "18", "19", "20", "21")))
str(Ydata2)
str(RTdata5)
names(Ydata2) <- 