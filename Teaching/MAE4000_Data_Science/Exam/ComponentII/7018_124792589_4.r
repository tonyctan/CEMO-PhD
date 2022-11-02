library(ggplot2)
data()
?CO2
CO2 # built-in Data in R
head(CO2) # To see the structure of data, check the variables
ggplot(CO2, aes(x = uptake, y = conc, colour = Type))+
  geom_point(size = 1.5, alpha = 0.5)+
  geom_smooth(method = lm, se = F)+
  facet_wrap(~Treatment)+
  labs(title = "CO2 Uptake and Concentration", subtitle = "in Grass Depending on Treatment and Region", 
       x = "Uptake(umol/m^2sec)", y = "Concentration(mL/L)") +
  theme_bw()

