# Name: Kaitlyn Fu
# Aug 17, 2020

library (dplyr)

library (tidyverse)

library (ggplot2)

install.packages("ggthemes")

library(ggthemes)

install.packages("zoo")
library(zoo)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read.csv(url)

state.of.interest = "Hawaii"

covid %>%
  filter(state == state.of.interest) %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  mutate(newCases = cases - lag(cases),
         roll7 = rollmean(newCases, 7, fill = NA, align = "right")) %>%
  ggplot(aes(x = date)) +
  geom_col(aes(y = newCases), col = NA, fill = "red") +
  geom_line(aes(y = roll7)) +
  ggthemes::theme_hc() +
  labs(title = "New Reported Cases by Day in Hawaii") +
  ggsave("img/hawaiicases.png")


