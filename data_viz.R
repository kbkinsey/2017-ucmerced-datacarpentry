## Data visualization

library(tidyverse)

surveys_complete <- read.csv('data_output/surveys_complete.csv')

## ggplot2

ggplot(data = surveys_complete, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id)) #alpha is transparency, could also do color = blue for all points blue

## Challenge

## Use what you just learned to create a scatterplot of weight over species_id
## with the plot types showing different colors. Is this a good way to show
## this type of data

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_point(alpha = 0.1, aes(color = plot_type))

## boxplot instead of scatter

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot()

#OR
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot(aes(color = plot_type))

#now let's change labels
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot() +
  labs(x = "Species",
       y = "Weight (g)",
       title = "Mammal Plot") +
  theme(plot.title = element_text(hjust = .5)) #hjust means horizontal position

#can make it two plots by sex by adding
# facet_grid(sex~.)

## Time Series ----

yearly_counts <- surveys_complete %>%
  group_by(year, species_id) %>%
  tally

ggplot(data = yearly_counts, aes(x = year, y = n)) +
  geom_line()   #not informative

ggplot(data = yearly_counts, aes(x = year, y = n, group = species_id)) +
  geom_line()   #getting closer, each line is a species, total count of species over time

ggplot(data = yearly_counts, 
       aes(x = year, y = n, 
        group = species_id,
        color = species_id)) +
  geom_line() #cool, colored by species

ggplot(data = yearly_counts, 
       aes(x = year, y = n, 
           group = species_id,
           color = species_id)) +
  geom_line() +
  facet_wrap(~ species_id)
#cool, colored by species

yearly_sex_counts <- surveys_complete %>%
  group_by(year, species_id, sex) %>%
  tally

ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~species_id)
  
##Challenge
## Use what you just learned to create a plot that
## depicts how the average weight of each species
## changes through the years.

yearly_avg_weight <- surveys_complete %>%
  group_by(year, species_id) %>%
  summarise(mean_weight=mean(weight))


ggplot(data=yearly_avg_weight, 
       aes(x=year, y=mean_weight,
           color=species_id)) +
  geom_line()+
  facet_wrap(~ species_id)+
  labs(x = "Year",
       y = "Mean weight (g)")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90),
  legend.position="none")

#make plot an object and save to computer#
my_plot <- ggplot(data=yearly_avg_weight, 
                  aes(x=year, y=mean_weight,
                      color=species_id)) +
  geom_line()+
  facet_wrap(~ species_id)+
  labs(x = "Year",
       y = "Mean weight (g)")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90),
        legend.position="none")

my_plot

ggsave("my_plot.png", my_plot) #saving plot to computer

  


