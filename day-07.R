# Name: Kaitlyn Fu
# Aug 12, 2020

install.packages("USAboundaries")

library (dplyr)

library (tidyverse)

library (ggplot2)

library(sf)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read.csv(url)

head(covid, 5)

library(USAboundaries)

region = data.frame(state_abbr = state.abb, state_name = state.name, region = state.region)

head(region)

inner_join(covid, region, by = c("state" = "state_name")) %>%
  group_by(region) %>%
  group_by(date, add = TRUE) %>%
  summarize(cases = sum(cases, na.rm = TRUE), deaths = sum(deaths, na.rm = TRUE)) %>%
  pivot_longer(cols = c('cases','deaths')) ->
  covid_region

  ggplot(covid_region, aes(x = date, y = value, group = 1)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  theme_light() +
  theme_linedraw() +
  theme(legend.position = "bottom") +
  theme(legend.position = "NA") +
  labs(title = "Cummulative Cases and Deaths by Region", x = "Date", y = "Daily Cummulative Count",
       subtitle = "COVID-19 Data: NY Times",
       caption = "Daily Exercise 7")

  ggsave("img/covid_region.png")
