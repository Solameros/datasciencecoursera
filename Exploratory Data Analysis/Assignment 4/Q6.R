# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# for removing all object except x in the Environment in R
# rm(list=setdiff(ls(), "x"))

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Baltimore emissions per year
locations_fips <- c("24510", "06037")
locations_names <- c("Baltimore City", "Los Angeles County")
locations_emissions <- subset(NEI, NEI$fips %in% locations_fips & type == "ON-ROAD")
locations_emis_year <- locations_emissions %>% 
                     group_by(fips,year) %>% 
                     summarize( Total = sum(Emissions, rm.na = TRUE))

# factor(x = char(), levels, labels)
#locations_emis_year$year <- as.factor(locations_emis_year$year)
locations_emis_year$Location <- factor(locations_emis_year$fips, 
                                   levels = locations_fips, 
                                   labels = locations_names)

ggplot(locations_emis_year, aes(x = year, y = Total)) + 
        geom_bar(stat = "identity", aes(fill = Location), position = "dodge") +
        scale_fill_manual(values=c("#56B4E9", "#E69F00")) +
        labs(x = "Year", y = "PM2.5 Emissions (tons)") +
        ggtitle("Baltimore City and LA County On Road Emissions") +
        scale_x_continuous(labels = as.character(locations_emis_year$year),breaks = locations_emis_year$year) +
        theme(legend.position = "bottom")

dev.copy(png,'plot6.png')
dev.off()


#There are two types of bar charts, determined by what is mapped to bar height. By default, 
#geom_bar uses stat = "count" which makes the height of the bar proportion to the number of cases 
#in each group (or if the weight aethetic is supplied, the sum of the weights). If you want the 
#heights of the bars to represent values in the data, use stat = "identity" and map a variable to 
#the y aesthetic.

#stat_count counts the number of cases at each x position. If you want to bin the data in ranges, 
#you should use stat_bin instead.
