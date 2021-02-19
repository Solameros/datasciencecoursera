
#5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# filtering Balitmore rows
Baltimore_emission <- filter(NEI, fips == "24510")

# filtering on road rows
Balt_Onroad <- subset(Baltimore_emission, 
                       Baltimore_emission$type == "ON-ROAD")

# In using summarise you usually want to group first. Grouping by year and getting sum.
Balt_Onroad_tot <- Balt_Onroad %>% 
                    group_by(year) %>%
                    summarize(Total = sum(Emissions, na.rm = TRUE))

# ggplot(data, mapping = aes(), ...) plotting the year vs total emissions of on road
Balt_Onroad_plot <- ggplot(Balt_Onroad_tot, aes(year, Total))

Balt_Onroad_plot <- Balt_Onroad_plot + 
                     geom_point(color = "red", size = 5, alpha = 1) + 
                     xlab("Year") +
                     ylab("Total Emissions (Tons)") +
                     ggtitle("Baltimore On road Emissions")

Balt_Onroad_plot

dev.copy(png,'plot5.png')
dev.off()