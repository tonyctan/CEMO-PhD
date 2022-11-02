library(ggplot2)
library(tidyr)
library(dplyr)
flights = read.table(file="C:/Users/Eier/Documents/MAE4000/data/flights.txt", header = TRUE, sep = ";", quote = "\"",
                     dec = ".", fill = TRUE, comment.char = "")
#Deleting column that are not required 
flights1<-flights[,-c(1,2,3,4,5,7,8,11,12,13,14,17,18,19)]
#making all the "NA" values to 0
flights1[is.na(flights1)] = 0
#Getting mean of different variables
flights2=flights1%>%
  group_by(carrier)%>%
  summarise_at(vars(dep_delay,arr_delay,air_time,distance),list(mean)) 
#Rounding to 2 decimal points
flights2$Dep_Delay <- round(flights2$dep_delay, 2)
flights2$Arr_Delay <- round(flights2$arr_delay, 2)
flights2$Airtime <- round(flights2$air_time, 2)
flights2$Dis_Travelled <- round(flights2$distance, 2)
#Creating a data set with required variables
flights3<-flights2[,c(1,6,7,8)]
#Renaming variable 
names(flights3)[1] = 'Carrier'
#Converting to long data
long <- gather(flights3, key="measure", value ="value", c( "Dep_Delay", "Arr_Delay","Airtime"))
# Listing variable 
variable_names <- list(
  "Dep_Delay" = "Departure Delay(average)" ,
  "Arr_Delay" = "Arrival Delay(average)",
  "Airtime" = "Airtime(average)")

vlebel <- function(variable,value){
  return(variable_names[value])
}
#Creating bar plot
g<-ggplot(long, aes(x=Carrier, y=value))+
  geom_bar(stat='identity',width = 0.9, fill="#6082B6")+
  facet_wrap(~measure, scales="free_y",ncol = 1,labeller= vlebel)

g+
 labs(
   title = "Air Carrier Performance", 
   subtitle = "Year 2013",
   x = "Air Carrier Name", y = "Time (in minutes)",
   caption="Note: Negative value means in average arrival/departure occurs before scheduled time")+
theme(
    panel.border = element_rect(color = "black", fill = NA, size = 0.01),
    panel.grid.major = element_blank(), 
    panel.grid.major.y  = element_line( colour = "#d9d9d9",size   = 0.001 ),
    panel.background = element_blank(),
    plot.background = element_rect(colour = "black", fill=NA, size=0.5),
    plot.title = element_text(color = "black",face = "bold", size = 12, hjust = 0),
    plot.subtitle = element_text(color="black",face = "bold", size = 10, hjust = 0),
    plot.caption = element_text(face = "italic",size=10,hjust = 0),
    axis.title.x = element_text(color = "black", size = 10, face = "bold"),
    axis.title.y = element_text(color = "black", size = 10, face = "bold"),
    axis.text.x = element_text(color = "black", size = 8),
    axis.text.y = element_text(color = "black", size = 8),
    strip.background =element_rect(fill="white"),
    strip.text = element_text(size = 10, color = "black",face = "bold")
    )
#Saving image
ggsave(file="flight.png", width=7, height=5, dpi=300)

