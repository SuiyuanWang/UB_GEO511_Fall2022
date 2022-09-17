####Data acquired with the R tidycensus package | @kyle_e_walker

library(tidycensus)
library(tidyverse)
library(tigris)
options(tigris_use_cache = TRUE)

census_api_key("83e6682de7bfa24b9c6133fc65a0aea557d1f7b4")


################################Work with Decennial Census#####################
age10 <- get_decennial(geography = "state", 
                       variables = "P013001", 
                       year = 2010)

head(age10)
age10 %>%
  ggplot(aes(x = value, y = reorder(NAME, value))) + 
  geom_point()+
  xlab("Median age") +
  ylab("States") + # Add informative axis labels using xlab() and ylab() including units
  labs(caption = "Figure.1. Data from 2010 Decennial Census."
  ) # Add a graph title with ggtitle()
ggsave("Figure1.png")

########################Work with American Community Survey#####################
vt <- get_acs(geography = "county", 
              variables = c(medincome = "B19013_001"), 
              state = "VT", 
              year = 2018)

vt

vt %>%
  mutate(NAME = gsub(" County, Vermont", "", NAME)) %>%
  ggplot(aes(x = estimate, y = reorder(NAME, estimate))) +
  geom_errorbarh(aes(xmin = estimate - moe, xmax = estimate + moe)) +
  geom_point(color = "red", size = 3) +
  labs(title = "Household income by county in Vermont",
       subtitle = "2014-2018 American Community Survey",
       y = "",
       x = "ACS estimate (bars represent margin of error)")
ggsave("Figure2.png")


########################Population estimition project#####################
us_components <- get_estimates(geography = "state", product = "components")

us_components

unique(us_components$variable)

net_migration <- get_estimates(geography = "county",
                               variables = "RNETMIG",
                               year = 2019,
                               geometry = TRUE,
                               resolution = "20m") %>%
  shift_geometry()

net_migration

order = c("-15 and below", "-15 to -5", "-5 to +5", "+5 to +15", "+15 and up")

net_migration <- net_migration %>%
  mutate(groups = case_when(
    value > 15 ~ "+15 and up",
    value > 5 ~ "+5 to +15",
    value > -5 ~ "-5 to +5",
    value > -15 ~ "-15 to -5",
    TRUE ~ "-15 and below"
  )) %>%
  mutate(groups = factor(groups, levels = order))

state_overlay <- states(
  cb = TRUE,
  resolution = "20m"
) %>%
  filter(GEOID != "72") %>%
  shift_geometry()


ggplot() +
  geom_sf(data = net_migration, aes(fill = groups, color = groups), size = 0.1) +
  geom_sf(data = state_overlay, fill = NA, color = "black", size = 0.1) +
  scale_fill_brewer(palette = "PuOr", direction = -1) +
  scale_color_brewer(palette = "PuOr", direction = -1, guide = "none") +
  coord_sf(datum = NA) +
  theme_minimal(base_family = "") +
  labs(title = "Net migration per 1000 residents by county",
       subtitle = "US Census Bureau 2019 Population Estimates",
       fill = "Rate",
       caption = "Data acquired with the R tidycensus package | @kyle_e_walker")
ggsave("Figure3.png")


