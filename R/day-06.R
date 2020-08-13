

# title: "Daily Exercise 06"
# date: Aug 11, 2020
# author: "Kaitlyn Fu"

library(dplyr)

library(tidyverse)

install.packages("ggplot2")

library(ggplot2)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read.csv(url)


# Question 1
covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(case = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(case, n = 6) %>%
  pull(state)

covid %>%
filter(state %in% c("California", "Florida", "Texas", "New York", "Georgia", "Illinois")) %>%
  ggplot(aes(x = date, y = cases)) +
  geom_line(aes(color = state)) +
  labs(title = "Cummulative Case Counts", x = "date", y = "cases") +
  facet_wrap(~state) +
  theme_light()

ggsave("img/plot1.png")


#Question 2
covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases)) +
  geom_col(color = "red") +
  labs(title = "National Cummulative Case Counts", x = "date", y = "cases") +
  theme_light()

ggsave("img/plot2.png")

