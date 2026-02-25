---
title: "DWLGRE003 - Reproducible Research Project"
author: "Grethen de Waal"
data: "Tuberculosis counts for 201 countries in 2000, by sex and age group"
module: "Introduction to Reproducible Research"
---

<br>

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/grethendw/reproducible-research/HEAD)

<br>

#### Source of dataset
The dataset I have selected shows the number of TB cases per 100,000 for each age group, divided by sex, for 201 countries in the year 2000. 
This data were taken from a [Udemy R course](https://www.udemy.com/course/r-programming-for-statistics-and-data-science/) I did,
and was originally from the WHO, likely from [this report](https://iris.who.int/server/api/core/bitstreams/75cba848-3a89-4e05-a736-afb69d0bece5/content). 

The data were sourced by the course convener, Simona (last name not provided), likely around 2023 when the course went online.
She edited the data to make it suitable for the course, but the exact steps are unclear.

<br>

#### Using the repository
* **data/** contains the raw dataset ("tb_untidy.csv") and the processed, tidy version ("tb_tidied.csv")

* **scripts/** contains the R code used to tidy the dataset.

* **output/** contains the two charts made after the data was tidied.

* **RR deliverable 20260220.Rmd** contains the full process and code of tidying "tb_untidy.csv" and generating charts.

<br>


#### Data tidying process
I tidied the data using **tidyverse** and **countrycode** packages.

* I pivoted the table, split the age and sex column and removed NA values using pivot_longer( ). 

* I used mutate( ) to add hyphens between the age ranges. 

* I used countrycode( ) to add country names based on the codes in the data.

* Finally, I removed the year column as it was the same for all observations.

<br>

#### Creation of charts
To create a box plot and a bar chart, I used the **ggplot2** package. 


