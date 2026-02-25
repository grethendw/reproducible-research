---
title: "DWLGRE003 - Reproducible Research Project"
author: "Grethen de Waal"
data: "Tuberculosis counts for 201 countries in 2000, by sex and age group"
---

<br>

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/grethendw/reproducible-research/HEAD)

<br>

#### Source of dataset
The dataset I have selected shows the number of TB cases per 100,000 for each age group, divided by sex, for 201 countries in the year 2000. 
This data were taken from a [Udemy R course](https://www.udemy.com/course/r-programming-for-statistics-and-data-science/) I did,
and was originally from the WHO, likely from [this report](https://iris.who.int/server/api/core/bitstreams/e031e926-f850-4d6d-a99f-d6ae841add4b/content). 

The data were sourced by the course convener, Simona (last name not provided), likely around 2023 when the course went online.
She edited the data to make it suitable for the course.

<br>

#### Data tidying process
I tidied the data using **tidyverse** and **countrycode** packages.
To do this, I pivoted the table, split the age and sex column and removed NA values using pivot_longer(). 
I used mutate() to add hyphens between the age ranges. 
I used countrycode() to add country names based on the codes in the data.
Finally, I removed the year column as it was the same for all observations.

<br>

#### Creation of charts
To create a box plot and a bar chart, I used the **ggplot2** package. 


