library(ggplot2)
mtcars # importing mtcars dataset default in R

mtcars$cyl<- as.factor(mtcars$cyl) # since we want cylinder as catergoirical variable

mt <-  ggplot(data= mtcars, mapping= aes(x=mpg, y=hp)) +
  geom_jitter(aes(color = cyl))+ #geom_jitter is better than geom_point() to show even small amount of random variation to the location of each point, and to avoid overplotting caused by discreteness in this smaller datasets
  geom_smooth(method="lm", se= TRUE, color= "black", size= 0.5) + #The layer “geom_smooth()” to aid seeing patterns in the presence of potential overplotting and method “lm” was used to fit linear models. 
  labs(title = "Fuel efficiency over engine power for different cylinder types", subtitle = "Fuel consumption vs engine power", caption = "The scatterplot created from the mtcars open access dataset default in R program", x = "Miles per Gallon (mpg)", y = "Horse Power (hp)")+
  theme(text=element_text(size=12,  family="serif")) # used for making desired font and fornt sizep; windowsFonts() = $serif <- "TT Times New Roman"

mt + facet_wrap(vars(cyl), ncol=1) # panels in one column