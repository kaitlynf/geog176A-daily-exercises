# Author: Kaitlyn Fu
# Day 11 daily assignment
# Aug 20, 2020

library(sf)

library(tidyverse)

library(units)

homes = readr::read_csv("~/github/geog176A-lab01/data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  filter(city %in% c("Santa Barbara", "Milpitas"))

st_distance(homes)

#Equal Area Projection
st_distance(st_transform(homes, 5070))

#Equidistance Projection
st_distance(st_transform(homes, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'))

#Modify the Units
st_distance(homes)

st_distance(homes) %>%
  set_units("km") %>%
  drop_units()
