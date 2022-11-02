# Importing the flights data
setwd("/Users/macbook/Desktop/Master_Uio/Høst_2022/MAE4000/")
mtcars = read.table(file="data/mtcars.txt", sep=";", header = TRUE)

require("ggplot2")
require("extrafont")

# Constructing the graph
fig <- ggplot(data=mtcars, aes(x=mpg, y=wt, color=cyl)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw() +
  theme(legend.position = "none") +
  theme(
    text=element_text(family="Times New Roman", size=12),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12),)

fig

# New facet label names to use when dividing the graph into panels
cyl <- c("V4 engine","V6 engine","V8 engine")
names(cyl) <- c("4","6","8")

# Dividing the graph into panels
fig.1 <- fig + facet_wrap(~cyl, scales = "free", labeller = labeller(cyl = cyl))
fig.1

# Annotating
fig.1 + labs(title = "Correlation between fuel efficiency and weight of vehicles", subtitle = "/Categorized by cylinder engines/",x = "Travelled miles per gallon of fuel", y = "The overall weight of vehicles(lb/1000)")

 