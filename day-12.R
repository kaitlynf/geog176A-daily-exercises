# Author: Kaitlyn Fu
# Day 12 daily assignment
# Aug 24, 2020

library(tidyverse)
library(sf)

USAboundaries::us_states() %>%
  filter(state_name == "Colorado") ->
  CO

USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico",
                            "Alaska",
                            "Hawaii")) ->
  states

(mutate(states,
        deim9 = st_relate(states, CO),
        touch = st_touches(states, CO, sparse = F))) %>%
  filter(touch == "TRUE")

ggplot(states) +
  geom_sf() +
  geom_sf(data = CO, fill = "blue", alpha = .3) +
  geom_sf(data = st_filter(states, CO, .predicate = st_touches), fill = "red", alpha = .5) +
  labs(title = "States Bordering Colorado")
  ggthemes::theme_map()

  ggsave("img/day-12.png")
