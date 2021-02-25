
#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using 
#the base plotting system, make a plot showing the total PM2.5 emission from all sources for 
#each of the years 1999, 2002, 2005, and 2008.



## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")


emission_by_year <- split(NEI$Emissions, as.factor(NEI$year))
Total_emission_by_year <- sapply(emission_by_year, sum)
barplot(Total_emission_by_year, xlab = "Year", ylab = "Total PM2.5 Emission (Ton)", col = "#00563f")

dev.copy(png,'plot1.png')
dev.off()