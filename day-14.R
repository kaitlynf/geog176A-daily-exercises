library(tidyverse)
library(sf)
library(ggplot2)

USAboundaries::us_states() %>%
  filter(!name %in% c("Alaska", "Hawaii", "Puerto Rico")) ->
  conus

get_conus = function(data, var){
  conus = filter(data, !get(var) %in% c("Hawaii", "Puerto Rico", "Alaska"))
  return(conus)
}

read_csv("~/github/geog-176A-labs/data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  get_conus("state_name") %>%
  select(city) ->
  conus_cities

conus %>%
  get_conus("state_name") %>%
  select(name) ->
  polygon

USAboundaries::us_counties() ->
  us_counties

get_conus(us_counties, "state_name") %>%
  st_transform(st_crs(conus_cities)) ->
  counties

point_in_polygon = function(points, polygon, id){
  st_join(polygon, points) %>%
    st_drop_geometry() %>%
    count(get(id)) %>%
    setNames(c(id, "n")) %>%
    left_join(polygon, by = id) %>%
    st_as_sf()
}


plot_pip = function(data){
  ggplot() +
    geom_sf(data = data, aes(fill = log(n)), alpha = .9, size = .2) +
    scale_fill_gradient(low = "grey", high = "purple") +
    theme_void()
}

point_in_polygon(conus_cities, counties, id = "name") %>%
  plot_pip()

ggsave("img/day14.png")
