#importing data set mtcars
bil <- read.table("data/mtcars.txt", sep = ";", header = TRUE)

#changing the name of the column am 
colnames(bil)=c("mpg","cyl","disp","hp","drat","wt","qsec","vs","transmission","gear","carb")

#changing the values from numbers to characters to be able to use as facet 
bil$transmission[bil$transmission==1]<-"manual gear"
bil$transmission[bil$transmission==0]<-"automatic gear"

#creating the plots with mpg,hp and transmission 
ggplot(data=bil,aes(x=mpg,y=hp,color=transmission))+
         ylim(0,400)+
  labs(x="Gallons pr miles",y="Gross horsepower")+
  geom_point()+
  geom_line()+
  facet_grid(~transmission)





