library(ggplot2)
library(nycflights13)

summary(mtcars)
head(mtcars)
mtcars$cyle = as.factor(mtcars$cyl)
mtcars

ggplot(data = mtcars, mapping = aes(x = hp, y = mpg, color = qsec))+
  geom_point(size = 8) +
  facet_grid(~cyl) +
  labs(title = "RELATIONSHIP BETWEEN MPG AND HORSEPOWER  FACETED BY CYLINDER AND COLORED BY QSEC ",
       x = "HORSEPOWER",
       y = "MILES PER GALLON")

