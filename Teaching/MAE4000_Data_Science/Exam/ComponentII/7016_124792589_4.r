install.packages("tidyverse")
install.packages("nycflights13")
library(tidyverse)
library(nycflights13)
library(RColorBrewer)
library(stringr)
flights #dataset from nycflights13
airlines #dataset from nycflights13


#Merge two datasets into one new df
MYFLIGHTS <- flights
AIRLINE1 <- airlines

AVG_DELAY <- merge(MYFLIGHTS, AIRLINE1, by = "carrier", all = TRUE)

#subsetting, remove NA, adding new variables
AVG_DELAY <- AVG_DELAY[,c("carrier", "dep_delay", "arr_delay", "origin", "dest", "name")]
AVG_DELAY <- na.omit(AVG_DELAY)

#Variables for mean delay departure time and mean delay arrival time
AVG_DELAY <- AVG_DELAY %>%
  group_by(origin, carrier) %>%
  mutate(MDEP_DELAY = mean(dep_delay, na.rm = TRUE)) %>%
  
  group_by(origin, carrier) %>%
  mutate(MARR_DELAY = mean(arr_delay, na.rm = TRUE))

#Variables for Departure and Arrival Status based on 15 min threshold

AVG_DELAY$ARR_STATUS <- ifelse(AVG_DELAY$MARR_DELAY > 15, "Delayed",
                ifelse(AVG_DELAY$MARR_DELAY < 0, "Early", "On-time"))

AVG_DELAY$DEP_STATUS <- ifelse(AVG_DELAY$MDEP_DELAY > 15, "Delayed",
                ifelse(AVG_DELAY$MDEP_DELAY <0, "Early", "On-time"))

AVG_DELAY$name <- factor(AVG_DELAY$name)

str(AVG_DELAY)
summary(AVG_DELAY)

#new df
saveRDS(AVG_DELAY, file = "/Users/emilynery/Documents/MAE4000/data/AVG_DELAY.Rds")
AVG_DELAY = readRDS(file = "/Users/emilynery/Documents/MAE4000/data/AVG_DELAY.Rds")

#ggplot to generate the graphic
dd <-ggplot(AVG_DELAY, aes(x= name, y=MDEP_DELAY)) +
  geom_hline(yintercept = 0, linetype = "solid", color = "#cccccc") +
  geom_hline(yintercept = 15, linetype = 3, color = "#969696") +
  geom_segment(aes(x=name, xend=name, y=0, yend=MDEP_DELAY), color= "gray48", size = 1.3) +
  geom_point(aes(color = ARR_STATUS, shape = ARR_STATUS, fill = ARR_STATUS), size = 2.5) +
  scale_shape_manual(values = c(23, 22, 21)) +
  scale_fill_manual(values = c("#D95F02", "#7570B3", "#1B9E77")) +
  scale_color_manual(values = c("#D95F02", "#7570B3", "#1B9E77")) +
  facet_grid(.~origin) +
  coord_flip() +
  theme_light()

dd

#Labels
ee <- dd + labs (x = "Airline Carrier", y= "Average Departure Time from New York City \n(in minutes)",
                 title = "Figure",
                 subtitle = "Airline Performance: Departure Time vs Arrival Status",
                 color = "Average Arrival Status \nat Destination",
                 shape = "Average Arrival Status \nat Destination",
                 fill = "Average Arrival Status \nat Destination")
ee

#Theme elements
ff <- ee + theme(panel.grid.major.y = element_blank(),axis.ticks.y = element_blank(),
                 strip.text = element_text(face = "bold"), 
                 strip.background = element_rect(fill = "#636363", color = "#636363"),
                 plot.title = element_text(face = "bold", size = 12),
                 plot.title.position = "plot",
                 plot.subtitle = element_text(face = "italic", hjust = 0),
                 plot.caption.position = "plot",
                 panel.border = element_rect(color = "#636363", fill = NA, size = 0.8))
ff

#Text annotation
gg <- ff + annotate(geom = "text", x= 3, y=16, angle= 270, size = 2.5, label = "Delay threshold", color = "#969696" )

gg #finished plot


ggsave ("Visualization-68274.png", width =10  , height =10)
