# Clearing working memory
rm(list=ls(all =TRUE))

# setting working directory
# please change this as required
setwd("C:\\Users\\Shampa\\Desktop\\14 Oct 2pm")

#some library calls, perhaps not all of them will not be needed as I will not use ggplot
library(readr)
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra)
#install.packages("ggrepel")
library(ggrepel)
library('magrittr')
library('dplyr')
library('tidyr')


#importing a data provided in class
salt2 <- read.table(file="C:\\Users\\Shampa\\Desktop\\14 Oct 2pm\\salt2.txt", header=TRUE,sep="\t")
#Write the name of the file where the dataset is located.Also mention the headerand separeate those using semicolon.



str(salt2)
summary(salt2)


#creating subset for Area NC
salt.NC <- subset(salt2[-c(6:11),])

#creating subset for Area KZ
salt.KZ <- subset(salt2[-c(1:5),])


#Final barplot
barplot(matrix(c(mean(salt.NC$Autumn),mean(salt.KZ$Autumn),mean(salt.NC$Spring),mean(salt.KZ$Spring),mean(salt.NC$Summer),mean(salt.KZ$Summer),mean(salt.NC$Winter, na.rm=TRUE),mean(salt.KZ$Winter)),nr=2), beside=T, 
        col=c("aquamarine3","coral"), 
        names.arg=c("Autumn","Spring","Summer","Winter"),
        ylab="Salt level",
        xlab="Seasons",
        main = "Average salt level in areas: NC and KZ",
        ylim = c(0,40))
legend("top", c("NC","KZ"), pch=15, 
       col=c("aquamarine3","coral"), 
       bty="n",
       )

