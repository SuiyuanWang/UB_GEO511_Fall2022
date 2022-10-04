library(spData)
library(sf)
library(tidyverse)
library(units)

# library(units) #this one is optional, but can help with unit conversions.

#load 'world' data from spData package
data(world)
# load 'states' boundaries from spData package
data(us_states)
# plot(world[1])  #plot if desired
# plot(us_states[1]) #plot if desired

albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
## world dataset
trans_world <- st_transform(world, albers)
world_Canada <- trans_world %>% filter(name_long=="Canada")
canada_buffer <- st_buffer(world_Canada, dist = 10000)

## us_states object
trans_us <- st_transform(us_states, albers)
us_NY <- trans_us %>% filter(NAME == "New York")

## creat a 'border' object
border <- st_intersection(canada_buffer, us_NY)
ggplot() +
  geom_sf(data = us_NY) +
  geom_sf(data = border, fill = "red") +
  labs(title = "New York Land within 10KM")
ggsave("Figure.png")
area_m <- st_area(border)
set_units(area_m, km^2)
