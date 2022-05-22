# Load packages
library(bayesrules)
library(tidyverse)
library(janitor)

# Import article data
data(fake_news)

# Tabulate fake rate
fake_news %>%
    tabyl(type) %>%
    adorn_totals("row")

# Tabulate exclamation usage and article type
fake_news %>%
    tabyl(title_has_excl, type) %>%
    adorn_totals("row")
