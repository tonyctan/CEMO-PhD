###Second assignment in Data Science, Morten Rasmus Puck

###The script is constructed in such way that different aspects are treated by itself, with each bookmark.
library(tidyr)
library(dplyr)
library(readxl)
library(stringr)
###Data import ----
#Importering the Y-dataset.
data_Y<-read_xlsx("D:/CEMO/Data Science 1. semester/Data generelt for Data Science/Ydata.xlsx")
View(data_Y) #View the dataset for correct import and some prior indications of trouble.

#Importering the RT-dataset.
data_RT <-read.csv("D:/CEMO/Data Science 1. semester/Data generelt for Data Science/RTdata.csv", sep=';')
View(data_RT) #View the dataset for correct import and some prior indications of trouble.

### data cleaning ----
### The data cleaning will be with each dataset. 
str(data_Y)
# Changing the names of the items.
data_Y <- data_Y %>% select(order(colnames(data_Y)))
YCol_name1 <- c(colnames(data_Y)[1:13],
                sub("_","_0",colnames(data_Y)[14:22]))
YCol_name <- sub("Item","It",YCol_name1)
colnames(data_Y) <- c(YCol_name)
#Changing the order of items in the dataset.
data_Y <- data_Y %>% select(order(colnames(data_Y)))

## Data RT.
str(data_RT)
data_RT <- data_RT %>% select(order(colnames(data_RT)))
data_RT$ID <- as.numeric(data_RT$ID) #Change the variable for integer til numerical to match the variable structure in Y data.

#Extract the language code.
data_RT$Language <-
  substr(data_RT$Group, nchar(data_RT$Group)-4, nchar(data_RT$Group)) #substracing the last 5 charactes to see country code.
data_RT$Language <- sub("_BE","",data_RT$Language) #Deleting the _BE from the variable to make it simpler.
table(data_RT$Language) #Check for the outcome in the language variable.

#Extract the gender code.
data_RT$Gender <- substr(data_RT$Group,8,8) #Only subtracting the first character in the gender, since it is sufficient to see the different gender group. 
table(data_RT$Gender) #Check for outcomes in the Gender variable.

data_RT <- data_RT[,c(-1)] #Dropping the group variable. 

### Distributions of the reaction times. 
# A control of negative values in timestamps by looking at the summary of every variables in the RT dataset. 
summary(data_RT) #None detective 

# A control of other than dichotomous outcomes by looking at the summary of every variables in the Y dataset. 
summary(data_Y) #All dichotomous items

##Dublicated variables.
duplicated_RT <- data_RT[(duplicated(data_RT$ID)==TRUE),] #3 duplicates in the RT dataset. 
duplicated_Y <- data_Y[(duplicated(data_Y$ID)==TRUE),] #Zero objects==zero duplicates in the Y data.


#### Data mergering ----
#Merge the two datasets with the Y dataset as base, and only the Y-dataset included. 
data_merged <- merge(data_Y[!duplicated(data_Y$ID),],data_RT[!duplicated(data_RT$ID),], by="ID", all.x=TRUE)
View(data_merged) #one observations is excluded because it only appears in the RT dataset.It is excluded since the score from the Y dataset will be important in evaluation of the response time.


#### Data choices ----
#One choice is to recode the scores in the Y data, if the student did not reached the question, aka response time=0. 
#Recode a timestamp at 0 to NA, because there is any time used at the item. 
for (i in 23:44){
  data_merged[[i]] <- ifelse(data_merged[[i]]==0, NA, data_merged[[i]])
}

#recoding the score of the items, if they did not use any time at the item.
for (i in 2:22){
  data_merged[[i]] <- ifelse(is.na(data_merged[[i+21]]), NA, data_merged[[i]])
}


### Data flip from wide to long. ----
#Recall the names in the Y dataset and RT dataset to make reshape-code shorter. 
names_Y <- colnames(data_Y)[-1]
names_RT <- colnames(data_RT)[-c(1,23,24)]
data_long = reshape(data_merged,direction="long",idvar="ID",varying=list(c(names_Y),c(names_RT)))
names(data_long)[4:6]=c("Item","Y","RT")

#Creating a data frame that indicate which problem the item is included. 
problemitemconnection <- rbind(cbind(c(1:4),1),cbind(c(5:8),2), cbind(c(9:12),3),cbind(c(13:16),4),cbind(c(17:20),5),cbind(c(21),6)) #Allocating all the items to a specific problem.
data_long$problem <- ifelse(data_long$Item %in% problemitemconnection[,1], problemitemconnection[data_long$Item,2], NA)
table(data_long$Item, data_long$problem) #A check in crosstable of the real distribution of items in problems. 


#### Data Calculation ----

# Calculation subscore, sub-problem reaction time, and total score and total reaction time.
#Constructing an unique identifer for ID and problem.  
data_long$IDproblem <- data_long$ID*10+data_long$problem

#Make the total score and total response time variable for each individual.
data_long_total <- merge(aggregate(Y ~ ID, data = data_long,sum),
                     aggregate(RT ~ ID, data = data_long,sum), 
                     by="ID",all=TRUE)
#Change the names of the columns to identifiable variable names.
colnames(data_long_total)[2:3] <- c("Y.tot", "RT.tot")

#Calculating the subscore and response time within each person and problem. 
data_long_sub <- merge(aggregate(Y ~ IDproblem, data = data_long,sum),
                       aggregate(RT ~ IDproblem, data = data_long,sum), 
                       by="IDproblem",all=TRUE)
#Change the names of the columns to identifiable variable names for the subscores.
colnames(data_long_sub)[2:3] <- c("Y.sub","RT.sub")

#Mergering the total and subscore on the long dataset.
data_long <- merge(data_long, data_long_sub, by="IDproblem",all.x=TRUE)
data_long <- merge(data_long, data_long_total, by="ID", all.x=TRUE)
#A last check of the dataset. 
View(data_long)
#A last check of the structure of the dataset.
str(data_long)

#Sorting the long dataset by ID and Item within ID. 
data_long <- arrange(data_long,ID, Item)


#### Data export ----
#Export the dataset to a .txt file with "." as decimals.
write.table(data_long, file="D:/CEMO/Data Science 1. semester/Data science week 2 22-26 aug/R-fil data science week 2 22-26 aug/data_long.txt", dec=".")

#Reimport the dataset to se differences. 
data_reimport <- read.table("D:/CEMO/Data Science 1. semester/Data science week 2 22-26 aug/R-fil data science week 2 22-26 aug/data_long.txt", dec=".")
#Comparing the exported dataset with the re-imported dataset. 
all_equal(data_long,data_reimport) #Change some variables form numbers to integers. No problems, since no decimals in the dataset. 

