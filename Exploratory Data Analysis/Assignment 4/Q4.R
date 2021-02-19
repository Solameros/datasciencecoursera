#4. Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

# for removing all object except x in the Environment in R
# rm(list=setdiff(ls(), "x"))

library(dplyr)
library(ggplot2)


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")


Coal_SCC <- SCC[grepl("[Cc]oal",SCC$EI.Sector),]$SCC
Coal_emissions <- subset(NEI,
                         Coal_SCC %in% NEI$SCC)


Coal_tot_emission <- Coal_emissions %>% 
                     group_by(year) %>% 
                     summarise(Total = sum(Emissions))

options(scipen=10000)
barplot(Coal_tot_emission$Total,
        names = Coal_tot_emission$year,
        xlab = "Year", 
        ylab = "Total PM2.5 Emission from Coal (Ton)",
        ylim = c(0, max(Coal_tot_emission$Total) + 2000000),
        col = "#700000")

dev.copy(png,'plot4.png')
dev.off()
