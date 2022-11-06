#install.packages('lavaan')
library(lavaan)
#install.packages('psych')
library(psych)


### Correlation between variables
# Loading data
mydata <- readRDS("likert_data.rds")                         
# Inspecting data
apply(mydata, 2, unique)                                    
# Recoding 9999 to NA
mydata[mydata==9999] <- NA                                  
# Inspecting data again
apply(mydata, 2, unique)
# Correlation between two variables

cor(mydata[,1], mydata[,2], use = "pairwise.complete.obs")  
# Full correlation matrix written as a .csv
write.csv2(cor(mydata, use = "pairwise.complete.obs"),
           "correlation_table.csv")                         


### Test-retest reliability / alternate forms
mydata <- readRDS("dich_data.rds")
sum_score_1 <- apply(mydata[,3:22], 1, sum)
sum_score_2 <- apply(mydata[,23:42], 1, sum)
# correlation between test 1 and test 2
cor(sum_score_1,sum_score_2)

#### Internal reliability 

### Alpha

### Dichotomous items
# Loading data
mydata <- readRDS("dich_data.rds")                         
# Inspecting the data
apply(mydata, 2, unique)

### Calculating alpha using the first 20 items
alpha(mydata[,3:22])
### Calculating alpha using the last 20 items
alpha(mydata[,23:42])
### Calculating alpha using all the items
alpha(mydata[,3:42])

### Likert scale items
# Loading data
mydata <- readRDS("likert_data.rds")
# Recoding as necessary as identified earlier
mydata[mydata==9999] <- NA                                  
### Calculating alpha using the first cluster
alpha(mydata[,1:10])

### Single factor model using lavaan
# Specifying model 
mymodel_spes <- "f =~ teaching_1 + teaching_2 + teaching_3 + teaching_4 + teaching_5 + teaching_6 + teaching_7 + teaching_8 + teaching_9 + teaching_10"
# Estimating model
mymodel <- cfa(mymodel_spes, mydata)
# Summary of model
summary(mymodel)
# Coefficients from model
params <- c(coef(mymodel))
# Calculating the omega coefficient 
loadings <- params[1:10]
error_var <- params[11:20]
omega_calc <- sum(loadings)^2/(sum(loadings)^2+sum(error_var))

### standardized model
# Estimating a standardized model 
mymodel <- cfa(mymodel_spes, mydata, std.lv = T)
# Summary of model
summary(mymodel)
# Extracted coefficients from model 
params <- c(coef(mymodel))
# Vector with the factor loadings
loadings <- params[1:10]  
# Vector with the unique variance
unique_var <- params[11:20]
# Calculating the omega coefficient
omega_calc <- sum(loadings)^2/(sum(loadings)^2+sum(unique_var))
# Comparing alpha and omega
alpha(mydata[,1:10])                      
omega_calc

