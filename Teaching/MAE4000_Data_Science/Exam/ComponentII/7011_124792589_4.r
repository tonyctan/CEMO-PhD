# Libraries ---------------------------------------------------------------

library("ggplot2")
library("lattice") #Necessary to import "USRegionalMortality" database

# Importing and adapting data set ------------------------------------------------------

USSuicide.df = USRegionalMortality[USRegionalMortality$Cause == "Suicide",]
USSuicide.df = USSuicide.df[,!(names(USSuicide.df) == "SE")] #excluding SE column since we will not work with it here

#Adding a Mean column

USSuicide_M.df = aggregate(Rate ~ Status + Sex, data = USSuicide.df, mean) #Rate mean based on Sex and Status (urban vs. rural) 
colnames(USSuicide_M.df) = c("Status", "Sex", "Mean")
USSuicide.df = merge(USSuicide.df,USSuicide_M.df, by=c("Status","Sex"), all.x = T)

#Adding a SD column
USSuicide_SD.df = aggregate(Rate ~ Status + Sex, data = USSuicide.df, sd) #Rate SD based on Sex and Status (urban vs. rural) 
colnames(USSuicide_SD.df) = c("Status", "Sex", "SD")
USSuicide.df = merge(USSuicide.df,USSuicide_SD.df[], by=c("Status","Sex"), all.x = T)

# Setting the APA theme --------------------------------------

apa_theme = theme(
  plot.margin = unit(c(1, 1, 1, 1), "cm"),
  plot.background = element_rect(fill = "white", color = NA),
  plot.title = element_text(size = 16, face = "bold", hjust = 0.5,vjust = 4),
  axis.line = element_line(color = "black", size = .5),
  axis.title = element_text(size = 14, color = "black",
                            face = "bold"),
  axis.text = element_text(size = 14, color = "black"),
  axis.text.x = element_text(size = 14, margin = margin(t = 10)),
  axis.title.y = element_text(size = 14, margin = margin(r = 10)),
  axis.ticks = element_line(size = .5),
  strip.text.x = element_text(size = 14, color = "black"),
  panel.grid = element_blank()
)

theme_set(theme_minimal(base_size = 18) + apa_theme)

# Plotting ----------------------------------------------------------------

ggplot(data=USSuicide.df, aes(x=Sex,y=Mean)) +
  geom_col(width= .9, position=position_dodge(.9)) +
  facet_wrap(~Status)+
  ggtitle("Mean suicide rate per 100,000 people \nacross US regions (2011 - 2013)")+
  ylab("Mean Suicide Rate")+
  geom_errorbar(aes(ymin=Mean-SD, ymax=Mean+SD),
              size=.5,    # Thinner lines
              width=.2,
              position=position_dodge(.9))

