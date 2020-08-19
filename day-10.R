library(dplyr)

library(sf)

USAboundaries::us_states() %>%
  filter(!state_name %in% c("Alaska", "Hawaii", "Puerto Rico")) ->
  CONUS

length(st_geometry(CONUS))

st_combine(CONUS) %>%
  st_cast("MULTILINESTRING") ->
  us_combine

st_union(CONUS) %>%
  st_cast("MULTILINESTRING") ->
  us_union
