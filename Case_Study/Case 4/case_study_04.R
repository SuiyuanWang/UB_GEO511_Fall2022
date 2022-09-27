# Farthest airport from New York City
library(tidyverse)
library(dplyr)
library(nycflights13)

#Objective
#What is the full name (not the three letter code) of the destination airport farthest from any of the NYC airports in the flights table?
############Answer: Honolulu Intl
# Task
### name in airports form
### distance, dest, in flights form
###group_by flights by origin place, got EWR, JFK, LGA in NYC.
group_flights <- flights %>% group_by(origin)
###find the maximum airports for each group.
max_flights <- group_flights[which.max(group_flights$distance),]
max_flights
###change the column names for further join step.
colnames(airports)[1] <- "dest"
###left_join max_flight with airports table to get name information for the destination airport.
farthest_airport_for_three_airports <- left_join(max_flights, airports, by = "dest")
###selest the farthest one
farthest_airport <- farthest_airport_for_three_airports[which.max(farthest_airport_for_three_airports$distance),]
farthest_airport
####Convert the data.frame to a single character value with as.character(). This converts the data.frame object into a single value.
farthest_airport <- as.character(farthest_airport)
# Answer a question that requires understanding how multiple tables are related
# Save your script as a .R or .Rmd in your course repository
