

#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# for removing all object except x in the Environment in R
# rm(list=setdiff(ls(), "x"))

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

Baltimore_emission <- filter(NEI, fips == "24510")
Balt_emission_by_year <- split(Baltimore_emission$Emissions, as.factor(Baltimore_emission$year))
Balt_total_emission <- sapply(Balt_emission_by_year, sum)
barplot(Balt_total_emission, xlab = "Year", 
        ylab = "Total PM2.5 Emission in Baltimore City, Maryland (Ton)",
        col = "#008080")

dev.copy(png,'plot2.png')
dev.off()