# Specific Tasks
library(tidyverse)
# Create a new R script in RStudio
# Load data from a comma-separated-values formatted text file hosted on a website
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
summary(temp)
# Graph the annual mean temperature in June, July and August (JJA) using ggplot
ggplot(temp, aes(x = YEAR , y = JJA)) +
  geom_line() +
  geom_smooth() + #Add a smooth line with geom_smooth()
  xlab("Year") +
  ylab("Mean Summer Temperatures (°C)") + # Add informative axis labels using xlab() and ylab() including units
  labs(title = "Mean Summer Temperatures in Buffalo, NY",
       subtitle = "Summer includes June, July, and August",
       caption = "Figure.1. Data from the global Historical Climate Network. Blue line is a LOESS smooth."
       ) + # Add a graph title with ggtitle()
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0),
        plot.caption.position = "panel") + # Left align the caption
ggsave("Case2.png")
# Save a graphic to a png file using png() and dev.off() OR ggsave
# Save the script
# Click ‘Source’ in RStudio to run the script from beginning to end to re-run the entire process
# What do you tell your grandfather and his brother? What additional tests / visualizations could you do?
# The summers are getting hotter!
  