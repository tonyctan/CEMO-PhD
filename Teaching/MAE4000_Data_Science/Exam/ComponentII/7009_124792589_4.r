
library(tidyverse)
library(nycflights13)

# imported from class
data = read.table('../data/flights.txt', sep = ';', header = TRUE)
data = flights
head(data) # inspect the data
data = na.omit(data) # drop all NAs

# create time_of_day column
data$time_of_day =  ifelse(data$hour < 6, 'Dawn',
                           ifelse(data$hour < 12, 'Morning',
                                  ifelse(data$hour < 18, 'Afternoon',
                                         ifelse(data$hour < 24, 'Evening'))))
data$time_of_day = as.factor(data$time_of_day)

# people are concerned when their flights delay but do not complain when it departs 
# a few min before  their scheuled time
# subset flights with dep_time > 20 mins
dep_more_20 = data[data$dep_delay > 20, ]

dep_more_20$month = as.factor(dep_more_20$month)

# plot bar graph showing 
ggplot(data = dep_more_20, mapping = aes(x = origin, y = dep_delay, fill = time_of_day))+
  geom_bar(stat = "summary", fun = "mean", width = .5) + 
  scale_fill_brewer('Departure Time', palette ='Set3') +
  facet_wrap(~carrier) +
  labs(title = 'Average Departure Delays in the 3 Major Airports in New York City',
       subtitle = 'Faceted by Airlines and Coloured by period of the day',
       x = 'Origin',
       y = 'Average Depature Delay (min)',
       caption = 'Note: Figures in the table only consider flights which have records of delays more than 20 minutes.
       Source: Flights that departed NYC in 2013 ') +
  theme(panel.background = element_blank(),
       strip.background = element_rect(color = 'black', 
                                         fill = 'white'),
        panel.grid.minor.y = element_line(linetype = 2,
                                         size = 0.1,
                                         color = '#808080')) +
  theme_classic()





