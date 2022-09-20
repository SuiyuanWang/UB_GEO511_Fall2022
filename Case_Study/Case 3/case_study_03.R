library(ggplot2) 
library(gapminder)
library(dplyr)

head(gapminder)

gapminder

# Use filter() to remove “Kuwait” from the gapminder dataset
gapminder_without_Kuwait <- gapminder %>%
  filter(country != "Kuwait")
gapminder_without_Kuwait

# Plot #1 (the first row of plots)
p1 <- ggplot(gapminder_without_Kuwait, aes(x = lifeExp, y = gdpPercap)) +
  geom_point(aes(color = continent, size = pop/100000)) +
  scale_y_continuous(trans = "sqrt") +
  facet_wrap(~year,nrow=1) +
  theme_bw() +
  labs(title = "Wealth and life expectancy through time",
       tag = "Figure 1",
       x = "Life Expectancy",
       y = "GDP per capita",
       size = "Population (100k)",
       color = "Continent")
p1
ggsave("p1.png", width = 15, units = "in")
#Prepare the data for the second plot
gapminder_continent <- gapminder_without_Kuwait %>% 
  group_by(continent, year) %>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), pop = sum(as.numeric(pop)))

# plot2 (the second row of plots)
p2 <- ggplot(gapminder_without_Kuwait, aes(x = year, y = gdpPercap)) +
  geom_line(aes(color = continent, group = country)) +
  geom_point(aes(color = continent, group = country)) +
  #geom_point(data = gapminder_continent, aes(x = year, y = gdpPercapweighted)) +
  geom_line(data = gapminder_continent, aes(x = year, y = gdpPercapweighted)) +
  geom_point(data = gapminder_continent, aes(x = year, y = gdpPercapweighted, size = pop/100000)) +
  facet_wrap(~continent, nrow=1) + 
  theme_bw() + 
  labs(caption = "Source: Data from specific spreadsheets on Gapminder.org circa 2010.",
       x = "Year",
       y = "GDP per capita",
       size = "Population (100k)",
       color = "Continent")
p2
ggsave("p2.png", width = 15, units = "in")