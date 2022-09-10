# Data Wrangling Assignment


Ydata <- read_excel(path = "../data/data/Ydata.xlsx")
RTdata <- read.csv(file = "../data/data/RTdata.csv",header = T,sep = ";")


Ydata1 <- as.data.frame(Ydata)

str(Ydata1)


##1. Transform both datasets to long format

# reorder original variables

Ydata2 <- Ydata1[,sort(names(Ydata1))]

names(Ydata2)[2:13]<-paste("Item",10:21, sep = "_")


Ydata3 <- Ydata2[,c(1,14:22,2:13)]

names(Ydata3)
Long_Ydata <- reshape(Ydata3, direction = "long", idvar = "ID", 
                      varying = list(c("Item_1" ,"Item_2", "Item_3", "Item_4",
                                       "Item_5", "Item_6" ,"Item_7", "Item_8",
                                       "Item_9", "Item_10" ,"Item_11" ,"Item_12" ,
                                       "Item_13" ,"Item_14" ,"Item_15" ,"Item_16",
                                       "Item_17","Item_18" ,"Item_19" ,"Item_20" ,"Item_21")))

names(Long_Ydata)[2:3] <- c("Item","Y")


RTdata1 <- RTdata[order(RTdata$ID),sort(names(RTdata))]


length(unique(RTdata1$ID))

RTdata2 <- RTdata1[!duplicated(RTdata1$ID),]

# one anomaly is found based on the sample size of 500 persons

RTdata2 <- RTdata2[RTdata2$ID!=501,]


Long_RTdata <- reshape(RTdata2,direction = "long", idvar = "ID",
                       varying = list(c("Time01", "Time02", "Time03" ,"Time04" ,"Time05" ,
                                        "Time06" ,"Time07" ,"Time08", "Time09" ,
                                        "Time10" ,"Time11" ,"Time12" ,"Time13" ,
                                        "Time14" ,"Time15" ,"Time16" ,"Time17" ,
                                        "Time18","Time19" ,"Time20" ,"Time21")))


# only keep 3 variables
Long_RTdata <- Long_RTdata[,-1]
names(Long_RTdata)[2:3] <- c("Item","RT")



# add a new variable problem to both datasets 

Long_Ydata$Problem <- round(ceiling(Long_Ydata$Item/4),0)



Long_RTdata$Problem <- round(ceiling(Long_RTdata$Item/4),0)


##2. Create subscore and totalscore datasets and tranform to long format 

# subscores

attach(Ydata3)
subscore_Y <- data.frame(ID=Ydata3$ID,subscore_1=Item_1+Item_2+Item_3+Item_4,
                       subscore_2=Item_5+Item_6+Item_7+Item_8,
                       subscore_3=Item_9+Item_10+Item_11+Item_12,
                      subscore_4=Item_13+Item_14+Item_15+Item_16,
                      subscore_5=Item_17+Item_18+Item_19+Item_20,
                      subscore_6=Item_21)


Long_Ysubscore <- reshape(subscore_Y, direction = "long", idvar = "ID", timevar = "Problem",v.names = "Y.sub",
                      varying = list(c("subscore_1","subscore_2","subscore_3","subscore_4",
                                       "subscore_5","subscore_6")))


detach(Ydata3)


attach(RTdata2)

subscore_RT <- data.frame(ID=RTdata2$ID,subscore1=Time01+Time02+Time03+Time04,
                       subscore2=Time05+Time06+Time07+Time08,
                       subscore3=Time09+Time10+Time11+Time12,
                       subscore4=Time13+Time14+Time15+Time16,
                       subscore5=Time17+Time18+Time19+Time20,
                       subscore6=Time21)


Long_RTsubscore <- reshape(subscore_RT, direction = "long", idvar = "ID", timevar = "Problem",v.names = "RT.sub",
                          varying = list(c("subscore1","subscore2","subscore3","subscore4",
                                           "subscore5","subscore6")))

detach(RTdata2)


# totalscores (also apply attach/detach functions)

totalscore_Y <- data.frame(ID=Ydata3$ID,Y.tot=Item_1+Item_2+Item_3+Item_4+
                             Item_5+Item_6+Item_7+Item_8+Item_9+Item_10+Item_11+
                             Item_12+Item_13+Item_14+Item_15+Item_16+Item_17+
                             Item_18+Item_19+Item_20+Item_21)

totalscore_RT <- data.frame(ID=RTdata2$ID,RT.tot=Time01+Time02+Time03+Time04+
                            Time05+Time06+Time07+Time08+
                           Time09+Time10+Time11+Time12+
                            Time13+Time14+Time15+Time16+
                            Time17+Time18+Time19+Time20+Time21)


##3. Create personal info datasets(split the variable)

Group_info <- data.frame(do.call(rbind, strsplit(RTdata2$Group, split = "\\_")))


# extract gender and language from the second variable of Group_info
Gender <- substr(Group_info$X2,1,nchar(Group_info$X2) - 2)
Language<- substr(Group_info$X2,nchar(Group_info$X2) - 1,nchar(Group_info$X2))

Personal_info <- data.frame(ID=RTdata2$ID,Gender,Language)

# replace the gender which is unknown into NA value

Personal_info$Gender[Personal_info$Gender=="Unknown"] <- NA


##4. Merge everything together

Score_Y <- merge(Long_Ysubscore, totalscore_Y, all=TRUE)

Score_RT <- merge(Long_RTsubscore,totalscore_RT, all=TRUE)

Score <- merge(Score_Y,Score_RT,all = T)

Long_Y_RT<- merge(Long_Ydata, Long_RTdata, all = T)



Long_Score <- merge(Score, Long_Y_RT,all = T)

Final_data <- merge(Long_Score,Personal_info,all = T)


Final_data <- Final_data[order(Final_data$Problem,Final_data$Item,-Final_data$ID),]


# adjust the sequence of variables and change their data type 

Final_data1 <- data.frame(Person=Final_data$ID,Gender=as.factor(Final_data$Gender),
                          Language=as.factor(Final_data$Language),Item=as.numeric(Final_data$Item),
                          Problem=as.numeric(Final_data$Problem), Y=Final_data$Y,
                          RT=Final_data$RT, Y.sub=Final_data$Y.sub, RT.sub=Final_data$RT.sub,
                          Y.tot=Final_data$Y.tot, RT.tot=Final_data$RT.tot)
str(Final_data1)


write.table(Final_data1, file = "../data/Finaldata_exported.txt", row.names = F,
            sep = "\t", dec = ".")
