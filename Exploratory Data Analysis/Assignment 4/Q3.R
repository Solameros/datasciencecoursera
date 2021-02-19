#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
#plot answer this question.

# for removing all object except x in the Environment in R
# rm(list=setdiff(ls(), "x"))

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")


Baltimore_emission <- filter(NEI, fips == "24510") 
Balt_emis_year_type <- Baltimore_emission %>% group_by(type,year) %>% summarise(Total = sum(Emissions))

Baltimore_plot <- ggplot(Balt_emis_year_type, aes(year, Total)) +
                  geom_bar(stat = "identity", aes(fill = type), position = "dodge") +
                  facet_grid(. ~ type)+
                  scale_x_continuous(labels = as.character(Balt_emis_year_type$year),breaks = Balt_emis_year_type$year) +
                  ggtitle("Baltimore different types of emitions") + 
                  labs(y = "Total Emissions (Ton)")
            

Baltimore_plot

dev.copy(png,'plot3.png')
dev.off()
