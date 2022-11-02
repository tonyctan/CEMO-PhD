

#---------Exam portfolio Component II Data Vis -------------#

library(ggplot2)
library(dplyr)
library(ggrepel)
library(scales)

#Load data
flights <- read.table("/Users/fannyloof/Desktop/Assesment Measurment and Evaluation/MAE4000/data/Exam/data/flights.txt", sep = ";", dec = ".", header = T)

#Create outlier flag, credit to Johan Braeken representatives bootcamp
outlier <- aggregate(flights["arr_delay"], list(flights$hour), FUN = function(x){c(IQR(x, na.rm = T), Q1 = quantile(x, .25, na.rm = T), Q3 = quantile(x,.75, na.rm=T))})
outlier <- do.call(data.frame, outlier)
names(outlier) <- c("hour", "IQR", "Q1", "Q2") 

flights <- merge(flights, outlier, all.x = T)
flights$flag <- (flights$arr_delay < (flights$Q2 + 1.5*flights$IQR) | flights$arr_delay > (flights$Q1 - 1.5*flights$IQR)) 

flights <- flights[which(flights$flag),] #exclude outliers

#Subsetting data for different origins
flights_JFK <- flights[flights$origin == "JFK",]
flights_EWR <- flights[flights$origin == "EWR",]
flights_LGA <- flights[flights$origin == "LGA",]

#number of flights / hour
calc_flights_per_hours <- function(df){
  df$flightsPerHour <- rep(NA,nrow(df))
  for (i in 6:20){
    hour <- i
    no_of_flight_hour <- nrow(df[df$hour==i,])
    df[df$hour==i,24] <- no_of_flight_hour
  }
return(df)
}

flights_JFK <- calc_flights_per_hours(flights_JFK)
flights_EWR <- calc_flights_per_hours(flights_EWR)
flights_LGA <- calc_flights_per_hours(flights_LGA)

flights_combined <- rbind(flights_JFK, flights_LGA, flights_EWR) #combining datasets

#arrival delay per number of flight and hour
flights_combined$arr_delay_per_flight_hour <- flights_combined$arr_delay / flights_combined$flightsPerHour

#mean arrival delay per flight and hour and airport for individual airports
data_single_airports <- aggregate(flights_combined["arr_delay_per_flight_hour"], list(flights_combined$hour, flights_combined$origin), mean, na.rm = T)
names(data_single_airports) <- c("hour", "origin", "mean_arrdelay_perflight")

data_single_airports$typeOfMean <- rep("For single Airport",37) #for fill-function in plot

# mean of means of arrival delay per flight across all airports
data_all_airports <- data_single_airports
data_all_airports$typeOfMean <- rep("Across all Airports", 37) #for fill-function in plot

stats_all_airports <- aggregate(data_all_airports["mean_arrdelay_perflight"], list(data_all_airports$hour), mean, na.rm=T)
names(stats_all_airports) <- c("hour", "mean_arrdelay_perflight")

all_airports <- merge(data_all_airports, stats_all_airports, by="hour")
all_airports$mean_arrdelay_perflight.x <- NULL
names(all_airports) <- c("hour", "origin", "typeOfMean", "mean_arrdelay_perflight")

all_airports <- all_airports[,c("hour","origin", "mean_arrdelay_perflight", "typeOfMean")]

# Combining datasets
finishedData<- rbind(data_single_airports,all_airports)

#Rename origin variable
renameOrigin <- function(df){
  df <- df %>%
    mutate(origin = recode(origin, "EWR" = "Newark Airport",  "JFK" = "John F. Kennedy Airport", "LGA" = "LaGuardia Airport"))
}

# finished dataser ready for visualization
finishedData <- renameOrigin(finishedData)

#-----------PLOT---------------
ggplot(data = finishedData, aes(x = hour, y = mean_arrdelay_perflight, fill = as.factor(typeOfMean), position_dodge(1))) +
  geom_col(position="dodge") +
  scale_fill_manual(values = c("#999999", "#000000")) +
  scale_x_continuous(breaks = 5:20) +
  scale_y_continuous(breaks = seq(-20, 40, 5)) +
  facet_grid(~origin) +
  theme(
    plot.title = element_text(size = 22),
    plot.subtitle = element_text(size = 16),
    axis.title.x = element_text(size=14),
    axis.title.y = element_text(size = 14),
    strip.text = element_text(size = 15)) +
  theme(panel.grid.major.y = element_line(color = "gray", size = 0.2, linetype = 1), panel.grid.major.x = element_line(color = "gray", size = 0.2, linetype = 1)) +
  theme(panel.grid.minor.y = element_line(color = "gray", size = 0.2, linetype = 1)) +
  labs(x="Hour of the day",
       y= "Average arrival delay per flight (min)",
       title = "Airport Arrival Delay",
       subtitle =  "Average hourly arrival delay for New York airports 2013") +
  guides(fill = guide_legend(title = "Averrage Arrival Delay Category"))

