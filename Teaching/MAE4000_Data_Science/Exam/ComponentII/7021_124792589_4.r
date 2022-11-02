#install.packages("ggplot2")
#install.packages("scales")
#Install.packages("dplyr")
library("ggplot2")
library("scales")
library("dplyr")

#Download flights dataset 
flights_original = read.table(file = "../data/flights.txt", sep = ";", header = T)
flights=as.data.frame(flights_original)


#Rename origin
flights=flights %>% rename("Origin"="origin" )


#Convert air_time to min to hrs
flights$air_time <- (flights$air_time) / 60


#Convert numbers to months with 3 letters for later use
month=(1:12)
month_names=(month.name[month])
month_names=substr(month_names, 1, 3)


#VISUAL
(flights_visual <- ggplot(data = flights, aes(x = month, y = air_time, fill = Origin))+
  facet_grid(
    rows = vars(Origin))+                     #To get panels.
  geom_col()+                                 #To get bars.
  theme_bw()+                                 #To make background black and white.
  theme_classic()+                            #To remove existing grid lines so they were not double.
  scale_fill_manual(                          #To make bar colors color blind friendly and pretty:)
    "Origin",
    values = c("EWR" = "orange",
               "JFK" = "#FF68A1",
               "LGA" = "purple"))+
  scale_x_continuous(
    n.breaks=12,                              #To change scale on x-axis so it hits right on the month 
    labels = c(".",
               month_names,                   #To change names on labels from numbers to month.
               "."))+                         #Dots because all breaks needed names, but there were 14 breaks and only 12 months. 
  geom_hline(
    yintercept=0)+                            #To add the line on zero back because it disappeared when I removed the grid lines earlier. 
  labs(
    title = "Air time per month (2013)",             #To make explaining text.
    subtitle = "Airports in New York City", 
    x = "Months", 
    y = "Air time (hrs) origin to destination")+
  theme(
    axis.text.x = element_text(
      angle = 90,                             #Turn the angle to get room for all month names.
      vjust = 0.5,
      hjust=1),
    panel.grid.major = element_line(
      colour="grey",                          #To get grid lines in line with the months.
      size=0.3),
    axis.title = element_text(face="bold"),   #To make titles bold.
    plot.title = element_text(face="bold"),
    strip.background = element_blank(),
    strip.text.y = element_blank())           #To remove redundant information as the origin names are mentioned twice.
)

