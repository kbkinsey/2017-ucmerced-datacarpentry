## My script from data carpentry UC Merced
## Kinsey Brock @kbkinsey kbrock@ucmerced.edu
## UC Merced

## make a data folder
## click + new folder and name it "data"

## download data ----
# download.file("https://ndownloader.figshare.com/files/2292169",
#              "data/portal_data_joined.csv")

## read data into R ----
surveys <- read.csv("data/portal_data_joined.csv")

##explore our data ----
##explore our data (content)
head(surveys) #show first 6 rows of data
tail(surveys) #show last 6 rows of data
tail(surveys, 12) # show last 12 rows

##explore our data (summary)
str(surveys) #structure of the data
summary(surveys) #gives you min. max. mean of data

##explore size
dim(surveys) #gives you number of rows and columns
nrow(surveys)
ncol(surveys)

names(surveys)

## the $ operator for isolating columns of your data
head(surveys$weight)
tail(surveys$weight)
str(surveys$weight)
summary(surveys$weight)

## plot data ----

## scatterplot: plot(x,y)
plot(surveys$year, surveys$weight)
plot(surveys$hindfoot_length, surveys$weight)

## histogram
summary(surveys$month)
hist(surveys$month)
hist(surveys$month, col="grey", breaks = 12)
#adding the "breaks" in made the bins better and not plotting it like it's continuous data

## explore factor variable
summary(surveys$taxa)
levels(surveys$taxa)
nlevels(surveys$taxa)
hist(surveys$taxa) #can't do it, must be numeric variable

class(surveys$taxa) #it's a factor
table(surveys$taxa) #turns it into table
class(table(surveys$taxa)) #now it's a table
barplot(table(surveys$taxa))

## subset in base R ----
## [rows, columns]

## return all columns for genus Ammodramus
surveys[surveys$genus == 'Ammodramus', ] #space after comma will give you all Ammodramus

## return a few columns
surveys[surveys$genus == 'Ammodramus', # c means "combine" numbers or strings together
        c('record_id', 'month', 'weight')]

## quiz ----
## how many observations (rows) are there in Jan and Feb?

nrow(surveys[surveys$month == 1 | surveys$month == 2, ])

table(surveys$month == 1 | surveys$month == 2)

#what's the length (number of rows) are less than 3? is basically what this one is saying
length(which(surveys$month <3))

length(which(surveys$month == 1 | surveys$month == 2 ))

## answer is 5213

## Day 2 of Workshop ----
## Practice pushing content to github
## Write code, save, then commit, pull, push!

surveys <- read.csv("data/portal_data_joined.csv")

install.packages("tidyverse")
library(tidyverse)

## select the columns plot_id, species_id, and weight
## surveys dataframe
select(surveys, plot_id, species_id, weight)

## using filter select rows where year is 1995
filter(surveys, year == 1995)

## want rows where year is 1995 and the columns where plot_id, species_id, and weight

## PIPES! ----

## THIS IS A PIPE    %>%

surveys %>%
  filter(year == 1995) %>%
  select(plot_id, species_id, weight)

surveys_sml <- surveys %>%
  filter(year == 1995) %>%
  select(plot_id, species_id, weight)

surveys_sml

## create two new columns
surveys %>%
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg * 2)

## remove rows with NAs in it
surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg * 2) %>%
  head

## Day 2 Challenge! ---- 
## Create a new data frame from the surveys data that
## meets the following criteria: contains only the species_id column and a new
## column called hindfoot_half containing values that are half the
## hindfoot_lengthvalues. In this hindfoot_half column, there are no NAs and all
## values are less than 30.

surveys %>%
  mutate(hindfoot_half = hindfoot_length / 2) %>%
  filter(!is.na(hindfoot_half)) %>%
  filter(hindfoot_half < 30) %>%
  select(species_id, hindfoot_half)


surveys %>%
  mutate(hindfoot_half = hindfoot_length / 2) %>%
  select(species_id, hindfoot_half) %>%
  filter(!is.na(hindfoot_half), hindfoot_half < 30)

## group by and summarize

surveys %>%
  group_by(sex) %>%
  summarise(mean_weight = mean(weight, na.rm = T))

## also want it to group on species id

surveys %>%
  filter(!is.na(weight),
         sex == "F" | sex == "M") %>%
  group_by(species_id, sex) %>%
  summarise(mean_weight = mean(weight))

surveys %>%
  filter(sex == "F" | sex == "M") %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = T),
  min_weight = min(weight, na.rm = T))

## tally counts the total count of how many males and females in dataset
surveys %>%
  group_by(sex) %>%
  tally(record_id)

## More Challenges ----

## Challenge

## 1. How many individuals were caught in each plot_type surveyed?
surveys %>%
  group_by(plot_type) %>%
  tally


## 2. Use group_by() and summarize() to find the mean, min, and 
## max hindfoot length for each species (using species_id).

surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(species_id) %>%
  summarize (min_hindfoot_length = min(hindfoot_length, na.rm = TRUE), 
             mean_hindfoot_length = mean(hindfoot_length, na.rm = TRUE), 
             max_hindfoot_length = max(hindfoot_length, na.rm = TRUE))

## 3. What was the heaviest animal measured in each year? Return
## the columns year, genus, species_id, and weight. Hint: it does not include summarize

## 4. You saw above how to count the number of individuals of each sex using a
## combination of group_by() and tally(). How could you get the same result using
## group_by() and summarize()? Hint: see ?n.



  

