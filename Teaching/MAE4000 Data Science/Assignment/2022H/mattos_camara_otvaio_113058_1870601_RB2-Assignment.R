#DATA WRANGLING - ASSIGNMENT DESCRIPTION 
#The two datasets Ydata.xlsx and RTdata.csv contain, respectively,
# binary responses (i.e., correct: Y = 1; wrong: Y = 0) and reaction times RT 
# in seconds, for the same set of 21 Items of a computer-based cognitive ability
# test and answered by the same sample of 500 Persons. Participants had 
# 20 minutes to complete the full test (i.e., the test automatically stops after
# the time limit). The participants were also asked to provide some biographical 
# information, Gender and Language group (i.e., NL or FR), which the computer 
# program wrote out under the column Group. Every consecutive item quadruple was 
# attached to the same cognitive Problem (i.e., 4 question items per problem, 
# except for the last problem with only 1 question).
# MISSIONS:
# 1. Restructure the dataset in a long format with the following variables: 
# Person, Gender, Language, Item, Problem Y, RT, Y.sub, RT.sub, Y.tot, RT.tot.
#   The .sub and .tot variables stand for the person’s summed subtotal across 
#   items on the problem that the item is part of and the person’s overall 
#   summed total across all items, respectively.
# 2. Audit the dataset by documenting and cleaning up any anomalies that might 
#    occur. For instance, if the reaction time indicates that the person has 
#    not reached the item and is equal to zero, then set the RT and Y value 
#    for that item to NA, which indicates it is missing.

########################################################
#Otávio Mattos

# First I imported the relevant data to Ydata and RTdata and ensured that they have data frame formats 
# (through the function "data.frame"). (Without that, Ydata gets a tribble format.)

library("readxl")
Ydata <- data.frame(read_excel("../data/Ydata.xlsx"))
RTdata <- data.frame(read.csv(file="../data/RTdata.csv",sep=";",header=TRUE))

#Separating gender and language into different columns:

metadata = (data.frame(do.call(rbind,strsplit(RTdata$Group,split = "\\_"))))[2]
RTdata = RTdata[,!names(RTdata) == "Group"]

i = 1
while (i <= nrow(metadata))
{
  metadata[i,2] = substr(metadata[i,1],1,nchar(metadata[i,1])-2)
  metadata[i,3] = substr(metadata[i,1],nchar(metadata[i,1])-1,nchar(metadata[i,1]))
  i = i + 1
}

metadata = metadata[,2:3]
names(metadata) = c("Gender","Language")
RTdata = cbind(RTdata,metadata)
View(RTdata)

#Checking for duplicated IDs in Ydata and RTdata

sum(duplicated(RTdata["ID"])) #duplicated IDs in RTdata (3 IDs)
sum(duplicated(Ydata["ID"])) #no duplicated IDs in Ydata

#After finding duplicated IDS in RTdata, I stored the ID-duplicated entries  
#in a different variable for further inspection:

ID_duplicates = RTdata$ID[duplicated(RTdata["ID"])]
RT_duplicates = RTdata[sort(names(RTdata))][RTdata$ID %in% ID_duplicates,]

View(RT_duplicates)

#My inspection revealed that entries with duplicated IDs have different RT values across trials. 
#It might be that the duplicated IDs are just a typing mistake, and the entries refer
#to different individuals. I will explore further this possibility by checking the missing IDs:

library(dplyr)
IDcheck = data.frame(first_column = 1:nrow(RTdata)) #IDcheck = vector with values from 1 to 498 (the number of rows(subjects) in RTdata)
names(IDcheck) = "ID"
missingIDs = anti_join(IDcheck,RTdata["ID"])
missingIDs

#I found 6 missing IDs in RTdata. Interestingly, 3 of these missing IDs (28, 39, and 328) are continuous with the 
#duplicated IDs (27, 40, 327). Therefore, most likely, the duplicated IDs were just mistyped. For this reason, 
#I decided to correct the duplicated IDs, keeping the subjects in the dataset:

RTdata[RTdata$ID %in% ID_duplicates,]["ID"]

RTdata[172,]["ID"] = 328
RTdata[472,]["ID"] = 28
RTdata[459,]["ID"] = 39

sum(duplicated(RTdata["ID"])) #Now there is no duplicated IDs in RTdata.

#Now I will also check Ydata for missing IDs:

IDcheck_y = data.frame(first_column = 1:nrow(Ydata)) #IDcheck = vector with values from 1 to 500 (the number of rows(subjects) in RTdata)
names(IDcheck_y) = "ID"
missingIDs_y = anti_join(IDcheck_y,Ydata["ID"])
missingIDs_y #No missing IDs in Ydata

#After correcting the duplicated IDs in RTdata, three IDs are still missing: 401, 470, 471. These IDs are
#*NOT* missing in Ydata. When I later merge these two datasets, these IDs in Ydata will have no RT data.
#I cannot know whether these missing IDs resulted from mistyping or whether the subjects' RT were simply not 
#introduced in RTdata. Therefore, I cannot really fix this problem. Subjects 401, 470, and 471 will be later 
#excluded from the analyses

#From now on, I will focus on (1)reshaping the datasets, (2) creating new columns with calculations, and (3) 
#merging the datasets.

#First, I will standardize the column names in Ydata (instead of Item_1, It_13, numbers only):

for (i in 2:ncol(Ydata))
  {
    item_number = (data.frame(do.call(rbind,strsplit(names(Ydata[i]),split = "\\_"))))[2]
    names(Ydata)[i] = item_number
  }

#Here I just order the columns
Ydata = Ydata[order(strtoi(names(Ydata)), decreasing = FALSE)]

#Now I reshape Ydata from "wide" to "long"
item_list = list(c(names(Ydata[1:length(Ydata)-1]))) #the list of variables that will take a "long" format. ID is not included
Ydata = reshape(Ydata,direction="long",idvar="ID",varying=item_list)
Ydata = Ydata[with(Ydata,order(ID)),]

#The column names are renamed
names(Ydata)[1:3] = c("ID", "Item", "Y")

#values in Ydata["Item"] converted from int to numeric (just like the output in the assignment)
Ydata["Item"] = lapply(Ydata["Item"], as.numeric)

#Next I add a column "problem" (total of 6 problems: four question items per problem, 
# except for the last problem with only 1 question.)

for (i in 1:nrow(Ydata))
{
  if (Ydata[i,"Item"] %in% 1:4){Ydata[i,4]=1}
  if (Ydata[i,"Item"] %in% 5:8){Ydata[i,4]=2}
  if (Ydata[i,"Item"] %in% 9:12){Ydata[i,4]=3}
  if (Ydata[i,"Item"] %in% 13:16){Ydata[i,4]=4}
  if (Ydata[i,"Item"] %in% 17:20){Ydata[i,4]=5}
  if (Ydata[i,"Item"] == 21){Ydata[i,4]=6}
}  

names(Ydata)[4] = "Problem"

# I now calculate Y.sub and Y.tot. The .sub and .tot variables stand for the 
# person’s summed subtotal across items on the problem that the item is part 
# of and the person’s overall summed total across all items, respectively.

#YTOT

Ytot = aggregate(x = Ydata$Y,                # Specify data column
          by = list(Ydata$ID),               # Specify group indicator
          FUN = sum)

names(Ytot) = c("ID", "Y.tot")

#YSUB

Ysub = aggregate(Ydata$Y ~ Ydata$ID + Ydata$Problem, FUN = sum)

names(Ysub) = c("ID","Problem", "Y.sub")

Ysub = Ysub[with(Ysub, order(Ysub$ID,Ysub$Problem), decreasing = FALSE),]

#integrate Ytot and Ysub to Ydata

Ysubtot = merge(Ytot,Ysub, all=TRUE)

Ydata = merge(Ydata,Ysubtot, all=TRUE)
Ydata = Ydata[with(Ydata, order(Ydata$ID,Ydata$Item), decreasing = FALSE), ]
View(Ydata)

#Now I change my attention to RTdata

#Similarly to Ydata, I standardize the column names in RTdata (instead of "Time_1", numbers only):

library(stringr)

for (i in 1:length(RTdata))
 {
  if (is.na(strtoi(str_sub(names(RTdata)[i],-2))) == FALSE)
   { names(RTdata)[i] = str_sub(names(RTdata)[i],-2)}
 }

View(RTdata)

#For reasons I did not understand, column names "Time08" and "Time09" did not change.
#The line below modifies those names that were left unmodified

names(RTdata)[8:9] = c("08", "09")

#I move the names of the columns that will receive a long format to item_list
#(Gender, Language, and ID not included)

item_list = list(c(names(RTdata[1:21]))) 

#Now I reshape RTdata to long, order the data frame based on ID and rename the columns

RTdata = reshape(RTdata,direction="long",idvar="ID",varying=item_list)
RTdata = RTdata[with(RTdata,order(ID)),]
names(RTdata) = c("ID", "Gender", "Language", "Item", "RT")
View(RTdata)

str(RTdata)

#values in RTdata ["ID"] and RTdata["Item"] converted from int to numeric

for (i in c("ID","Item")){RTdata[i] = lapply(RTdata[i], as.numeric)}

str(RTdata)

#merge Ydata and RTdata:

YandRT = merge(Ydata,RTdata, all=TRUE)
View(YandRT)

#Now I will address the following assignment's request: if the reaction time indicates that the 
# person has not reached the item and is equal to zero, then set the RT and 
# Y value for that item to NA.

#Next, the for loop is used to assign NA to RT and Y when RT = 0. 

for (i in 1:nrow(YandRT))
  {
  if (YandRT[i,"RT"] == 0 | is.na(YandRT[i,"RT"]))
    {
    YandRT[i,"RT"] = NA
    YandRT[i,grep("^Y", names(YandRT))] = NA
    }
  }

View(YandRT)

#Below I calculate RT.tot and RT.sub! The .sub and .tot variables stand for the 
# person’s summed subtotal across items on the problem that the item is part 
# of and the person’s overall summed total across all items, respectively.

#RTTOT

RTtot = aggregate(x = YandRT$RT,                      # Specify data column
                  by = list(YandRT$ID),               # Specify group indicator
                  FUN = sum)

names(RTtot) = c("ID", "RT.tot")

View(RTtot)

#RTSUB

RTsub = aggregate(YandRT$RT ~ YandRT$ID + YandRT$Problem, FUN = sum)

names(RTsub) = c("ID","Problem", "RT.sub")

RTsub = RTsub[with(RTsub, order(RTsub$ID,RTsub$Problem), decreasing = FALSE),]

View(RTsub)

#integrate RTtot and RTsub to the final dataset

RTsubtot = merge(RTtot,RTsub, all=TRUE)

YandRT = merge(YandRT,RTsubtot, all=TRUE)
YandRT = YandRT[with(YandRT, order(YandRT$ID,YandRT$Item), decreasing = FALSE), ]
YandRT = YandRT[,c(1,9,10,5,2,6,11,8,4,7,3)] #This line is just to order the columns (as in the assignment's output)
View(YandRT)

#Notice that sums involving NA values produce NA results. Therefore, we find .sub and .tot values
#(for both Y and RT) with NA values. It is possible to sum values ignoring NAs by adding "na.rm = TRUE" to the
#computation, as in the following example:


#RTtot = aggregate(x = YandRT$RT,                     
#                  by = list(YandRT$ID),               
#                  FUN = sum, na.rm = TRUE)


#Even though it is possible to sum values ignoring NAs, I think this might be inappropriate. For example, 
#in the case of Y responses, by doing so, NA and 0 (wrong responses) would be treated in the same way.


write.table(YandRT, file = "../data/DataWrangling.txt", append = FALSE, sep = "\t", dec = ".",
            row.names = TRUE, col.names = TRUE)
