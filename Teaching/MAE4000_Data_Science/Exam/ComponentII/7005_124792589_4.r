## Packages used 
{library(MASS) #Package where data set was obtained
library(ggplot2)
## Source of data for figure was MASS package
## Data set is called Melanoma
data("Melanoma") ## Calling data set
## Decided to convert gender factor for clarity when working with the figure
Melanoma["sex"][Melanoma["sex"] == "0"] <- "Female"
Melanoma["sex"][Melanoma["sex"] == "1"] <- "Male"
## Plot
ggplot(data = Melanoma, aes(x = age, y = time)) +
  geom_point(shape = 20) + ## Changed default point shapes
  ## Assigning new break for both variables:
  scale_x_continuous(breaks = seq (0, 100, 10)) + 
  scale_y_continuous(breaks = seq (0, 6000, 1000)) +
  ## Inclusion of regression line and 95% CI interval
  geom_smooth(aes(linetype = "Regression Line (95% CI)"), method = "lm", colour = "black", size = 0.5, se = TRUE) +
  ## Creation two facets based of gender factor
  facet_grid(rows = vars(sex)) + 
  ## Assigning labels to both axis
  labs(x = "Age at Moment of Detection (Years)", y = "Survival Time (Days)") +
  ## Customizing theme for APA compliance
  theme (panel.background = element_blank(),
        text = element_text(family = "serif", size = 16), ##Font change to similar to Times New Roman
        axis.ticks.length = unit(5, "pt"), ## Length of ticks
        axis.line = element_line(size = 0.3), ## Reducing default size of line
        axis.title =  element_text(size = 14), ## Title more prominent
        axis.text = element_text(size = 12, color = "black"), ## Text of axis less prominent than axis title
        strip.background = element_rect(fill = "#EEEEEE"), ## Changing color of facet labels so it is more discreet
        strip.text.y = element_text(size = 14), ## Text of panels consistent with axis titles
        panel.spacing = unit(20, "pt"), ## Added some spacing between panels for clarity
        legend.title = element_blank(), ## Legend title left blank to avoid "linetype" text
        legend.position = "bottom", ## Decided to position the legend in the bottom since on the right used too much space and reduced the axis  
        legend.spacing.y = unit(1, "pt") ## Small re-position of legend
        )
}
