
# restructure and audit data arising from a timed intelligence test
# import libraries
library('Ecdat')
library('readxl')
library('reshape2')

# import datasets
ydata <- read_excel('../data/Ydata.xlsx')
rtdata <- read.csv('../data/RTdata.csv', sep = ';', header = TRUE)

# inspect data
head(ydata)
str(ydata)

# check ID > 500
#ydata[ydata$ID > 500, ]

# check for duplicated ids
ydata[duplicated(ydata$ID),] # no duplicates

# reshape ydata from wide to long
longY <- melt(ydata, 
              id.vars = 'ID')

# create Item column by extracting the Item number from variable
longY$Item = as.numeric(gsub('\\D', "",longY$variable))
names(longY)[3] = 'Y' # name the value 'Y'
longY = longY[,-c(2)] # drop the variable column
longY = longY[,c(1,3,2)] # subset only relevant columns for longY

#create ID_Problem column: Item num matches Problem num
longY$ID_Problem = paste(longY$ID, longY$Item, sep = '_')

# create a new df to compute total
longY_total <- longY[, c(1,3)]
Y_tot <- aggregate(Y~ID, longY_total, sum) #aggregate by Y and ID
names(Y_tot)[2] = 'Y.tot'

# compute subtotal
longY$sub = ceiling(longY$Item / 4)
longY$ID_sub = paste(longY$ID, longY$sub, sep = '_') #unique rows

Y_sub = aggregate(Y~ID_sub, data = longY, sum) # aggregate by Y and ID_sub
names(Y_sub)[2] = 'Y.sub'

# merge Y_tot and Y_sub to longY
longY = merge(longY, Y_tot, by = 'ID', all = TRUE)
longY = merge(longY, Y_sub, by = 'ID_sub', all = TRUE)

str(longY)

#longY_sub <- longY[, c(2, 3)]
longY$sub = ceiling(longY$Item/4)

# inspect rtdata
head(rtdata)
str(rtdata)

# check missing ID from 1:50
sum(c(1:500) %in% rtdata$ID)

# check ID > 500
rtdata[rtdata$ID > 500,]


#check for duplicated id
rtdata[duplicated(rtdata$ID),]['ID']

# drop rows with duplicated IDs
rtdata = rtdata[!duplicated(rtdata$ID), ]

# separate $Group to extract language and gender
gender <- data.frame(do.call(rbind, strsplit(rtdata$Group, split='_')))
names(gender) <- c('title', 'gen_lang', 'be')
# extract language and gender 
rtdata$Language = substr(gender$gen_lang, nchar(gender$gen_lang)-1, nchar(gender$gen_lang))
rtdata$Gender = substr(gender$gen_lang, 0, nchar(gender$gen_lang)-2)
# delete group column
rtdata <- rtdata[,-c(22)]

# change Unknown gender to NA
rtdata$Gender = replace(rtdata$Gender, rtdata$Gender == 'Unknown', NA)

# convert language and gender 
rtdata$Gender = as.factor(rtdata$Gender)
rtdata$Language = as.factor(rtdata$Language)

# reshape rtdat to long
rtlong <- melt(rtdata,
               id.vars = c('ID', 'Language', 'Gender'))

names(rtlong)[5] = 'RT' # rename value to RT
# extract problem number from variable
rtlong$value = as.numeric(gsub('\\D', "", rtlong$variable))
#rtlong <- rtlong[,-c(4)] # drop variable column
names(rtlong)[6] = 'Problem'


rtlong$ID_Problem = paste(rtlong$ID, rtlong$Problem, sep = '_')


# create rtSubscore dataset
rt_total <- rtlong[, c(1, 5)]
RT_tot <- aggregate(RT ~ ID, data = rt_total, sum)
names(RT_tot)[2] <- 'RT.tot'


# create subtotal df for rtlong
rt_subtotal <- rtlong[,c(1, 5, 6)]
rt_subtotal$sub = ceiling(rt_subtotal$Problem/4)

rt_subtotal$ID_Problem = paste(rt_subtotal$ID, rt_subtotal$sub, sep = '_')


table(rt_subtotal$ID_Problem)


#print('stop')
# create subtotals based on ID_problem
RT_sub = aggregate(RT~ID_Problem, data = rt_subtotal, sum)

#table(RT_sub$ID_Problem)
names(RT_sub)[2] = 'RT.sub'

# merge RT_tot and RT_sub to rtlong
rtlong = merge(rtlong, RT_tot, by = 'ID', all = TRUE)
rtlong = merge(rtlong, RT_sub, by = 'ID_Problem', all = TRUE)


# merge rtlong and longY
rt_y <- merge(rtlong, longY, by = 'ID_Problem', all = TRUE)
#rt_y = rt_y[, -c(1, 5, 10, 11, 14)]

# reorder column names of rt_y
data.frame(names(rt_y))
rt_y = rt_y[, c(2, 4, 3, 12, 7, 13, 6, 16, 9, 15, 8)]
names(rt_y)[1] = 'Person'

rt_y = rt_y[order(rt_y$Person, decreasing = TRUE),]
rt_y = rt_y[order(rt_y$Item, na.last =  TRUE),]

str(rt_y)
head(rt_y)

# save file to txt format
write.table(rt_y, '../data/data_wrang.txt', sep = '\t', dec = '.')
