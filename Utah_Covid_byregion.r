#import tidyverse library
library(tidyverse)
library(ggthemes)

#read in NYT covid data from github
US_covid <- read.csv("https://github.com/nytimes/covid-19-data/raw/master/us-counties.csv")

#read in csv showing region and population for each county
UT_region_pop <- read.csv("county_region_pop.csv") 

#filter for only Utah, and inner join with juris_pop df. rename population to county_pop
UT_covid <- US_covid %>%
    filter(state == "Utah") %>%
    inner_join(UT_region_pop, by = "county")

names(UT_covid)[8] <- "county_pop"
UT_covid$date <- as.POSIXct(UT_covid$date)

#restructure the df so that there is only one value (sum) for each jursidiction per day
by_region <- UT_covid %>%
    group_by(date, region) %>%
    summarize(cases = sum(cases), deaths = sum(deaths))

abs_plot <- ggplot(by_region, aes(x = date, y = cases, fill = region))+
    geom_area()+
    labs(x = "Date", 
         y = "Number of Cases", 
         title = "Population Proportion \n Proportion of Cases in Utah \n Number of Covid Cases in Utah", 
         legend = "Region", 
         caption = "Source: github.com/nytimes/covid-19-data")+
    theme_few()+
    theme(
        plot.title = element_text(size = 14, hjust = 0.5),
        plot.caption = element_text(size = 10, face = 'italic', color = 'gray80', hjust = 0) 
    )+
    scale_fill_tableau()

ggsave("covid_abs.png", height = 6, width = 10, units = "in")

prop_plot <- ggplot(by_region, aes(x = date, y = cases, fill = region))+
    geom_area(stat = 'identity', position = 'fill', aes(fill = region))+
    labs(x = "Date", 
         y = "Proportion", 
         title = "Proportion of Cases \n by Region", 
         legend = "Region", 
         caption = "Source: github.com/nytimes/covid-19-data")+
    theme_few()+
    theme(
        plot.title = element_text(size = 14, hjust = 0.5),
#        plot.caption = element_text(size = 10, face = 'italic', color = 'gray80', hjust = 0) 
    )+
    scale_fill_tableau()

prop_plot

ggsave("covid_proportion.png", height = 6, width = 10, units = "in")

UT_pop_prop <- UT_region_pop %>%
    group_by(region)%>%
    summarize(region_pop = sum(population))

pop_prop_col <- ggplot(UT_pop_prop, aes(x = "", y = region_pop, fill = region))+
    geom_col(width = 1)

pop_prop_col+
    theme_few()+
    labs(title = "Population Distribution")+
    theme(plot.title = element_text(size = 14, hjust = 0.5))+
    scale_fill_tableau()

ggsave("population_proportion.png", height = 6, width = 6, units = "in")

abs_plot
