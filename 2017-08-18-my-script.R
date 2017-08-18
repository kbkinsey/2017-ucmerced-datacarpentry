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