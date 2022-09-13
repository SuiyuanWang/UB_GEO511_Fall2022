# Specific Tasks
library(tidyverse)
library(ggpubr)


# Create a new R script in RStudio
# Load data from a comma-separated-values formatted text file hosted on a website
Buffalo_dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")
Buffalo_temp=read_table(Buffalo_dataurl,
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))
summary(Buffalo_temp)

Florida_dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00012839_14_0_1/station.txt"
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00012839&dt=1&ds=14")
Florida_temp=read_table(Florida_dataurl,
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))
summary(Florida_temp)

Allstation_temp <- bind_rows("Buffalo, NY" = Buffalo_temp,
                             "Miami, Florida" = Florida_temp,
                             .id = "Station")
summary(Allstation_temp)

dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")
temp=read_table(dataurl,
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))

ggplot(Allstation_temp, aes(x = YEAR , y = JJA, group = Station, color = Station)) +
  geom_line() +
  geom_smooth(aes(colour = Station)) + #Add a smooth line with geom_smooth()
  xlab("Year") +
  ylab("Mean Summer Temperatures (°C)") + # Add informative axis labels using xlab() and ylab() including units
  labs(title = "Mean Summer Temperatures in Buffalo, NY, and Miami, FL",
       subtitle = "Summer includes June, July, and August",
       caption = "Figure.1. Data from the global Historical Climate Network. Lines are LOESS smooth.")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0),
        plot.caption.position = "panel")
ggsave("Case2_Buffalo_Florida_Summer_Compare.png")

  
# Graph the annual mean temperature in June, July and August (JJA) using ggplot
ggplot(temp, aes(x = YEAR , y = JJA)) +
  geom_line() +
  geom_smooth(colour = "red") + #Add a smooth line with geom_smooth()
  xlab("Year") +
  ylab("Mean Summer Tem (°C)") + # Add informative axis labels using xlab() and ylab() including units
  labs(title = "Mean Summer Temperatures in Buffalo, NY",
       subtitle = "Summer includes June, July, and August",
       caption = "Data from the global Historical Climate Network. Red line is a LOESS smooth."
  ) + # Add a graph title with ggtitle()
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0),
        plot.caption.position = "panel") # Left align the caption
ggsave("Case2_Buffalo_Summer_tem.png")


# Save a graphic to a png file using png() and dev.off() OR ggsave
# Save the script
# Click ‘Source’ in RStudio to run the script from beginning to end to re-run the entire process
# What do you tell your grandfather and his brother? What additional tests / visualizations could you do?
# The summers are getting hotter!
ggplot(temp, aes(x = YEAR , y = DJF)) +
  geom_line() +
  geom_smooth() + #Add a smooth line with geom_smooth()
  xlab("Year") +
  ylab("Mean Winter Tem (°C)") + # Add informative axis labels using xlab() and ylab() including units
  labs(title = "Mean Winter Temperatures in Buffalo, NY",
       subtitle = "Winter includes December, January, and February",
       caption = "Data from the global Historical Climate Network. Blue line is a LOESS smooth."
  ) + # Add a graph title with ggtitle()
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0),
        plot.caption.position = "panel") # Left align the caption
ggsave("Case2_Buffalo_Winter_tem.png")
