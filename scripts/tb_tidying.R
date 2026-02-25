# Load packages for analysis
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggthemes) 
library(psych)

install.packages("ggpattern")
library(ggplot2)
library(ggpattern)


# Load data and rename to something shorter
tb <- read_csv("tb_untidy.csv") # I had to store this data in /Users/User/Documents/GIT/reproducible-research because it wouldn't read from the "data" folder
tb <- as_tibble(tb)
tb

#### Tidy the data ----

## Problems to solve:
# 1. remove NA - can do this with pivot_longer()
# 2. column with sex and age needs to be made into observations
# 3. the age groups need to be split with a hyphen using mutate()
# 4. Country codes should be names
# 5. "year" column is unnecessary


## Problems 1 and 2:
# can use pivot_longer()
# first combining all the sex and age groups into one column 
# then splitting the column 

?pivot_longer # looking this up because I'm used to gather() and separate()

tb_tidy <- tb %>%
  pivot_longer(
    cols = m04:fu, 
    names_to = c("sex", "age"),   #this tells R the names of the new columns
    names_pattern = "(.)(.*)",    # (.) is the first char, (.*) is everything after
    values_to = "cases",          # this is where the values previously stored under the m04 etc are stored
    values_drop_na = TRUE)         # this removes the NA values

tb_tidy


## Problem 3
# I'm sure there is a faster way to do this

tb_tidy <- tb_tidy %>%
  mutate(age = case_when(
    age == "014" ~ "0-14",
    age == "1524" ~ "15-24",
    age == "2534" ~ "25-34",
    age == "3544" ~ "35-44",
    age == "4554" ~ "45-54",
    age == "5564" ~ "55-64",
    age == "65"   ~ "65+",
    TRUE ~ age                  # this keeps everything else as is
  ))

tb_tidy 


## Problem 4

install.packages("countrycode") # to extract country names from country codes
library(countrycode)
# use iso2c: ISO-2 character

tb_tidy <- tb_tidy %>%
  mutate(country_name = countrycode(country, origin = "iso2c", destination = "country.name"))

tb_tidy <- tb_tidy %>%
  relocate(country, country_name) # to reorder the columns

tb_tidy

# country code AN could not be matched unambiguously, so I kept both the country codes and the names. 
# I tried using the mutate() function the way I used it to add the hyphens in the age ranges but it didn't work.

tb_tidy_NA <- tb_tidy %>%
  mutate(country_name = case_when(
    country_name == "NA" ~ "Netherlands Antilles",
    TRUE ~ country_name))

tb_tidy_NA


# Problem 5
# Remove the year column

tb_tidy$year <- NULL
tb_tidy


## Export tidied dataset

write.csv(tb_tidy, file = "tb_tidied.csv", row.names = FALSE)



#### Make some charts ----

RColorBrewer::display.brewer.all()

## box plot
tidy_box <- ggplot(tb_tidy, aes(x = age, y = cases, fill = sex)) +
  geom_boxplot(position = "dodge") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(x = "Age Group", 
        y = "Number of Cases",
        fill = "Sex")

tidy_box    # most of the useful information is cut off


## bar chart
 
 # Calculate mean and standard error for the bars
 tb_summary <- tb_tidy %>%
   group_by(age, sex) %>%
   summarise(
     mean_cases = mean(cases, na.rm = TRUE),
     se_cases = sd(cases, na.rm = TRUE) / sqrt(n()), 
     .groups = "drop"
   ) 
 
 
tidy_bar <- ggplot(tb_summary, aes(x = age, y = mean_cases, fill = sex)) +
  geom_col(position = "dodge") +
  geom_errorbar(
    aes(ymin = mean_cases - se_cases, ymax = mean_cases + se_cases),
    position = position_dodge(width = 0.9),
    width = 0.25) +
  scale_fill_brewer(palette = "Paired") +
   theme(panel.border = element_rect(colour = "black", fill = NA, linewidth = 1)) +
   theme_minimal() +                        
  labs(x = "Age Group", 
       y = "Number of Cases",
       fill = "Sex") 

tidy_bar     # this chart looks nicer but may contain less information (can't see the mean etc)





