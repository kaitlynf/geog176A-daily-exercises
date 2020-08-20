library(dplyr)

library(sf)

library(ggplot2)

USAboundaries::us_states() %>%
  filter(!state_name %in% c("Alaska", "Hawaii", "Puerto Rico")) ->
  CONUS

length(st_geometry(CONUS))

st_combine(CONUS) %>%
  st_cast("MULTILINESTRING") ->
  us_combine

ggplot() +
  geom_sf(data = us_combine)

st_union(CONUS) %>%
  st_cast("MULTILINESTRING") ->
  us_union

ggplot() +
  geom_sf(data = us_union)
