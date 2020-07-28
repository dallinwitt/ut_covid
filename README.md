# Regional Spread of COVID-19 Across Utah
## Data Analysis and Visualization

#### Motivation
The COVID era has come with a deluge of data. While this has been a windfall for data scientists, it also presents them with an opportunity to convey an important message to the population at large. Being particularly concerned with the spread of the disease across my home state, I decided to analyze the data, and visualize it in a way that would help people understand how the spread of the disease has shifted over time, as it has moved from urban areas into farther-flung communities.

#### Methods
I used data from the [New York Times github](https://github.com/nytimes/covid-19-data) page, which provides county-level infection and mortality data. I combined this with data scraped from Wikipedia on demographic data for [Utah's counties](https://en.wikipedia.org/wiki/List_of_counties_in_Utah).  

I imported the data into R, and analyzed and plotted it using tidyverse libraries (namely ggplot2 and dplyr). I created a dictionary that assigned counties to region based on criteria that I determined myself. I was primarily seeking to create regions whose population was in the same order of magnitude (hundreds of thousands, when possible).

Plots were cleaned up and assembled in Paint.net.

#### Outcomes
Many people in Utah's suburban and rural regions erroneously assume that this is still a "city problem." While that may have been the case early on, the plot clearly shows that the share of cases, and particularly the relative proportion of cases is rapidly equalizing across the state, threatening rural areas just as much as it threatens urban.
