#========================================================#
#                                                        #
#     Intro to R                                         #
#     FW5121 Conservation Planning                       #
#     Spring 2019                                        #
#     By: Chad Zirbel, Mike Verhoeven, and Laura Dee     #
#                                                        #
#========================================================#

# outline -----------------------------------------------------------------
#' ## Outline
#' 0. R setup & tutorial
#' 1. Pull in data
#'    a. setwd()
#'    c. read.csv(), read.table(), others?
#' 2. Re-organize, re-shape
#' 3. Cleaning/ data view
#' 4. Perform a calculation (by row, by column, by group, parallel narrative to Excel)
#' 5. Visualization
#' 6. Mapping
#' 7. Re-create some figures & maps!
#' 8. Other resources for learning R?

# R setup & basics ------------------------------------------------------

##Why use R?##
# It's free
# Language based (Reproducible)
# Powerful data wrangling capabilities
# flexible statistical analysis toolkit
# Graphics and data visualization
# powerful, cutting-edge analytics
# A robust, vibrant community
# easily expandable to include
#  - projects: "packages" of files & settings: R Studio Projects
#  - version control: github, others
#  - annotated, easily readable code: R Markdown
#  - custom data oriented web apps: R Shiny
#  - linking to databases (when your dataset is too big to be stored locally!)

##R basics##

# The different parts of R
#' 1. The script
#' 2. The Console
#' 3. Environment
#' 4. Files/Plots/Packages/Help

#If you can think of it, R can probably do it.
#for example
install.packages(c("devtools"))
library(devtools)
install_github("Gibbsdavidl/CatterPlots")
library(CatterPlots)
meow<-multicat(xs=-10:10, ys=rnorm(21),
               cat=c(1,2,3,4,5,6,7,8,9,10),
               catcolor=list('black'),
               canvas=c(-0.1,1.1, -0.1, 1.1),
               xlab="some cats", ylab="other cats", main="Random Cats")

#or we can do this
devtools::install_github("melissanjohnson/pupR")
library(pupR)
pupR()
pupR()
pupR()

##commenting##
#on each line, everything after a pound sign will not be calculated, but instead will run as a comment
#It is good practice to thoroughly comment your code. Your collaborators and future you will thank you
1+1 #you can also comment on a line of working code, as long as the code goes before "#"

#Run code by pressing ctrl+enter (cmd+enter on a mac) on a line of code within an R script
7*2*2

##assigning variables
x<-3 #"Alt -" is the shortcut for "<-" 
x

y=4
y

#We can store more than just numbers
z<-"hello world"
z

#we can also store multiple values within a variable.
w<-c(1,2,3)
w

#we can also store a matrix or data frame of numbers, or characters
a<-matrix(1:9, nrow=3)
a

##Functions##
#Every command starts with a function and an open parentheses
#then a series of arguments seperated by commas followed by a closed parentheses
w
mean(w)

##getting help##
##a question mark before a function pulls up the help file asociated with said function
?mean() 

mean() #F1 while cursor is in the function is a shortcut for this in R studio

#two question marks locates all occurences of the word within all base R and loaded package help files
??mean()

#We can also create our own functions. Here is a function that calculates the mean.
#redundant I know but hopefully you can see the utility

my_mean_func<-function(x){ # my_mean_function[names the function] <- function(x[names arguments you'll use in making fn]){[starts function]
  x_mean<-sum(x)/length(x) # tells fn to do this calculation
  return(x_mean) # finally, print the calculated value
}

b<-c(1,2,3,4)
my_mean_func(b)

##installing/loading packages##
#Base R has many useful functions but R also has an archive of user created functions.
#you can download these packages using install.packages()

install.packages("janitor")

#The load the package into your R session using library()

library(janitor) #remember: F1 within "janitor" will pull up helpfile
#we will use the clean_names() function from this package later

##Loops##
#We can use loops to complete repetitive calculations and tasks:
b
for (i in 1:length(b)){ #for instances 1 through however long b is
  print(b[i]^2)         #return the value of b^2
}

#R has different types of loops including for, repeat, and while. We wont cover them here but they are useful

## Exercise##
#Write a function that will calculate the standard deviation of a population from a sample of the pop (sample SD) - 
# https://statistics.laerd.com/statistical-guides/measures-of-spread-standard-deviation.php
# Then use your function to caclulate sd from a known sample: 

sd <- function(x){
  a <- c() # make an empty variable "a" to store intermediate calculations
  for (i in 1:length(x)){ # for numbers 1-length of our sample, 
    a[i] <- (x[i] - mean(x))^2 # for each position (1 through length(sample)) in "a", calculate for that same position in "x", the dif of each value from mean of "x", and square that value; 
  }
  return(sqrt((sum(a)/(length(x)-1)))) # calculate & return the square root of the sum of all the values in "a" divided by the size of our sample minus 1.
}
##End Exercise##

##Built in distributions##
#test the function using a known sample
#R has built in stats including a nice set of distributions: dnorm(), dpois(), etc.
#The prefix "r" will select a random set from the distribution used, like "rnorm(n, mean, sd)"
sample <- round(rnorm(30,16,2), digits = 1) # draw 30 random numbers from a normal dist with mean=16 and sd=2 
sd(sample) # result ought to have an SD somewhere around 2!

##setting a working directory##
#The working directory is where R will look for the files you load
#R will also output files to your working directory
#you can view your current working directory using getwd()
getwd()

setwd() #add the file path to the folder where the files you want are stored.
#The file path needs to be within "" and seperated with / or \\

#Rstudio's environment tab also has an import data menu (refrain from using this, lacks reproducibility)

#R projects are also a powerful tool for managing your code and files (especially when you are working on multiple projects)
#We wont cover them here but check out this post for more info: https://r4ds.had.co.nz/workflow-projects.html

#Ex1: loading data into R -----------------------------------------------------

##Exercise: HW Data##
# 1. Download the data for today's problem set from Canvas. 

# 2. Save it to your working directory location (use getwd() and setwd() to troubleshoot)

# 3a. Read the data into R by assiging it to a variable, like:  er.data <- read.csv("filename.csv")
er.data <- read.csv("Ecoregion_Data_Set.csv")

# 3b. Read the data directly into R from a web URL. First visit the URL and view to see what R will be using as data: https://github.com/crzirbel/FW5121_Intro_to_R. Click on the Ecoregion_Data_Set.csv and view as Raw. Copy link and assign it to a variable using read.csv() Ex: read.csv("https...Ecoregion_Data_Set.csv") 
er.data <- read.csv("https://raw.githubusercontent.com/crzirbel/FW5121_Intro_to_R/master/Ecoregion_Data_Set.csv")

# 4. Inspect what you loaded using View()
View(er.data)

# 5. Compare to the Excel spreadsheet from Moodle. Why are there blank rows & columns?
View(er.data)
##END Exercise##

# cleaning and manipulating data ------------------------------------------

##cleaning datasets##
#There are lots of ways that imported data can be "messy." R and packages within offer many tools to clean up datasets!

# can select rows or columns from a data.frame (or matrix, list, etc.) using brackets
er.data[,1] # view column 1
er.data[12,1] # row 12, column 1
er.data[12,"Ecoregon"] # can call columns by names
er.data[1:3,] # rows 1-3, all columns implied by leaving blank after column
er.data[-c(1:3),] # all rows except rows 1-3, all cols (just prints it, doesn't remove it from dataset)
er.data <- er.data[-c(1:3),] # reassign er.data


# Ex 2: dropping a column -------------------------------------------------

##Exercise: Drop last column##
er.data[,"X"]
names(er.data)
er.data <- er.data[,-7]
##END Exercise##

#clean column names
names(er.data) <- tolower(names(er.data))

names(er.data)[2] <- "land.value.usdperha"
names(er.data)[5:6] <- c("tot.area.milha","existing.prot.area.ha")

# (Compare to excel) We want the units of tot area on same scale as existing prot area. We can calculate a new column of values using the previous set of columns
er.data$tot.area.ha <- er.data$tot.area.milha * 1000000


# Ex3: calculate in a dataframe -------------------------------------------

##Exercise: Calculation##
# Proportion of each ecoregion that is protected:
er.data$proportion.prot <- er.data$existing.prot.area.ha/er.data$tot.area.ha

# (Compare to excel) sort the regions by proportion protected
order(er.data[,"proportion.prot"], decreasing = F) # what are the row #s for proportion.prot in increasing order
er.data[order(er.data[,"proportion.prot"], decreasing = F), c("ecoregon","proportion.prot")] # print the ecoregion and proportion protected columns in the order we just described

## End EXERCISE ##

# there may be better solutions for many tasks in other packages. Example:
library(data.table)
er.dt <- data.table(er.data)
setkey(er.dt, proportion.prot)
er.dt[ ,.(ecoregon, proportion.prot)]


# Working with datasets -------------------------------------------------
#load IPBES protected area data from:
#Brooks, T. M., Akçakaya, H. R., Burgess, N. D., Butchart, S. H., Hilton-Taylor, C., Hoffmann, M., ... & Perianin, L.
#(2016). Analysing biodiversity and conservation knowledge products to support regional environmental assessments.
#Scientific data, 3, 160007.

ipbes.data<-read.csv("https://datadryad.org/bitstream/handle/10255/dryad.107691/PAs_IPBES.csv?sequence=5")

#Lets look at the data what do we see?
View(ipbes.data)

#reloading data with na.strings and clean_names to fix problems in the df
ipbes.data<-read.csv("https://datadryad.org/bitstream/handle/10255/dryad.107691/PAs_IPBES.csv?sequence=5",
                     na.strings = "n/a")
ipbes.data<-clean_names(ipbes.data)

head(ipbes.data)

summary(ipbes.data)

str(ipbes.data)

# merging datasets ------------------------------------------------------------
#dataset of GDP by country
gdp<-read.csv("https://github.com/crzirbel/FW5121_Intro_to_R/raw/master/GDP.csv")

#load in a table from Brooks et al. 2016 that has country info for the regions used in the IPBES report
ipbes.country.region<-read.csv("https://github.com/crzirbel/FW5121_Intro_to_R/raw/master/ipbes_country_region_lookup.csv")

#merge datasets together
#We use by or by.x and by.y to tell merge() which column(s) we want it to match the two datasets by
#all, all.x, and all.y are used to tell merge which rows should be kept in the merged datset
ipbes.region.gdp<-merge(ipbes.country.region, gdp, by.x = "country.ipbes", by.y = "country", all.x=T)

#now we can aggregate the data so that it matches the IPBES protected area data
#Here we aggregate by region and sub region, and sum across duplicate rows within those groups
#Instead of taking the sum we could also take the mean or max or even use a custom function
ipbes.gdp.ag<-aggregate(gdp~ipbes.region+ipbes.sub.region, data=ipbes.region.gdp, sum)

#merge gdp and protected area data frames
ipbes.gdp.proc<-merge(ipbes.data,ipbes.gdp.ag, by.x="subregion", by.y="ipbes.sub.region")

#look at the new dataset we have now
head(ipbes.gdp.proc)

# plotting using ggplot ---------------------------------------------------
##plotting##
library(ggplot2)

#baseplot
#there is built-in plotting capability in R
plot(data = ipbes.data, total_protected_areas_km2 ~ region, xlab = "", xaxt = "n" )
axis(1, at=1:8, labels=levels(ipbes.data$region), las = 2, cex.axis = 0.8)

levels(ipbes.data$region)

#ggplot
#using ggplot allows far more flexibility in your plotting, and a friendlier syntax
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

ggplot(ipbes.data, aes(region, total_area_km2))+ # build a plotting space 
  geom_point()+ # map some data into that space
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) # adjust things

# Lets re-create a figure from IPBES report:
subset(ipbes.data, region== "Americas")

# can only plot one variable?
am.prot.prop <- ggplot(subset(ipbes.data, region== "Americas"), 
  aes(subregion, total_proportion_in_protected_areas))+ 
  geom_col(alpha = .5)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
am.prot.prop

#split by EEZ and Land
am.prot.prop+
  geom_col(aes(y = subset(ipbes.data, region== "Americas")$proportion_of_exclusive_economic_zone_in_protected_areas), alpha = .5)

# we can re-arrange for easier plotting:
americas.data <- subset(ipbes.data, region== "Americas")[,c(2,5,8,11)]
names(americas.data)

#
library(tidyr)
americas.data <- gather(americas.data, key = "metric", value = "proportion", 2:4)


americas.data$percent <- americas.data$proportion*100

ipbes.plot <- ggplot(americas.data, aes(subregion, percent, fill = metric))+ 
  geom_col( position = "dodge")+
  ylab("PROPORTION (%) OF PROTECTED \n AREA COVERAGE")+
  xlab("AMERICAS REGION AND SUBREGIONS")+
  scale_fill_manual(name = NULL , values = c("#AACE83", "#9883A8", "#4F5F53"),
                      labels = c( "Terrestrial", "Marine (EEZ)*", "Total"))+
  scale_y_continuous( breaks = seq(0,35, by = 5),
                      labels = seq(0,35, by = 5),
                      limits = c(0,30))+
  theme(legend.position="bottom",
        legend.justification = "left",
        legend.background = element_rect('snow2'),
        axis.ticks = element_blank(),
        panel.background = element_rect(fill = 'snow2'),
        plot.background = element_rect(fill = "snow2"),
        axis.title = element_text(face = "bold"),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 2, l = 0)),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank()
        )
ipbes.plot


americas.data$subregion <- as.factor(as.character(americas.data$subregion)) #reset factor levels to drop full dataset levels
americas.data$subregion <-  factor(americas.data$subregion,levels(americas.data$subregion)[c(4,1,2,3,5)]) # make order match what we want
americas.data$metric <- as.factor(as.character(americas.data$metric))
americas.data$metric <- factor(americas.data$metric, levels(americas.data$metric)[c(2,1,3)])
ipbes.plot


#facets
ipbes.data.facet <- ipbes.data[,c(1,2,5,8,11)]
ipbes.data.facet <- gather(ipbes.data.facet, key = "metric", value = "proportion", 3:5)
ipbes.data.facet$percent <- ipbes.data.facet$proportion*100

ipbes.plot.global <- ggplot(ipbes.data.facet, aes(subregion, percent, fill = metric))+ 
  geom_col( position = "dodge")+
  ylab("PROPORTION (%) OF PROTECTED \n AREA COVERAGE")+
  scale_fill_manual(name = NULL , values = c("#AACE83", "#9883A8", "#4F5F53"),
                    labels = c( "Terrestrial", "Marine (EEZ)*", "Total"))+
  scale_y_continuous( breaks = seq(0,35, by = 5),
                      labels = seq(0,35, by = 5),
                      limits = c(0,30))
ipbes.plot.global

ipbes.plot.global+
  facet_wrap(aes(region))


# mapping ----------------------------------------------------------------------
#manipulating, analyzing, and plotting shapefiles is an area of R that is currently underdevelopment.
#you will see alot of different packages to manipulate shapefiles including sp, rgdal, and sf
#Today we will use sf which is relatively new

library(sf)
#load the shapefile for the IPBES map
#you can look in the github repository at the folder called shapefile for all of the files asociated with the shapefile
#you only need to load the .shp file
#the st_read() is just like read.csv() but it reads .shp files
ipbes.sp<-st_read("shapefile/EEZv8_WVS_DIS_V3_ALL_final_v7disIPBES.shp") #file currently only stored locally

#I used mapshaper.org to simplify the shapefile. I recommend doing this when working with large shapefiles
#especially when you aren't looking for publication quality figures right away. This will greatly reduce plotting time.

#The original shapefile contained over 19 million verticies. I simplified it to 2.5% of its orginal complexity
#Let's see how many verticies are there now
sum(rapply(st_geometry(ipbes.sp), nrow))
#Much simplier

#The orginal file was also 293MB (too big for github)
#This file is only 7.6MB

#The unsimplified version of this file took >30 minutes to plot on my laptop.
#The developers working on ggplot know about the plotting time issues and it is an active area of development.

#To differenciate our regions and the type of protected area lets combine two character columns using paste()
ipbes.sp$IPBES_regi_type<-as.factor(paste(ipbes.sp$IPBES_regi,ipbes.sp$type, sep= "_"))
#now we have a new column "IPBES_regi_type" 

#Just some code to make the plot look better
#This matches the colors with the Brooks et al. figure. These are the hexcodes and the order matches the order of:
levels(ipbes.sp$IPBES_regi_type)

colors<-c("#BEDAFF", "#FFE5B2", "#FFD380", "#B9E1A5", "#89CD66", "#DAC4E8", 
          "#C19ED6", "#DDA4AD", "#CE6667", "#E5E1E0", "#CCCCCC")
#Here I'm trying to pull specific colors to match the figure, usually this isn't your goal, but its important to use
#colors that are printer/colorbind friendly. Use contrast appropriately.

#Here I create a coordinates df to plot the region names
ipbes.coords<-as.data.frame(sf::st_coordinates(st_point_on_surface(ipbes.sp)))
ipbes.coords$IPBES_sub<-ipbes.sp$IPBES_sub #add the subregion column to the coord df
ipbes.coords$type<-ipbes.sp$type #add the type column to the coord df
#This only keeps the labels for the "Land" so the map doesn't get crowded
ipbes.coords<-ipbes.coords[ipbes.coords$type%in%"Land",]
#Here I create a line break in two of the longer names using \n
ipbes.coords$IPBES_sub <- plyr::revalue(ipbes.coords$IPBES_sub, c("East Africa and adjacent islands"= "East Africa and\nadjacent islands",
                                                                  "Central and Western Europe"= "Central and Western\nEurope"))
#Lets plot the map now
ggplot(ipbes.sp)+ #tell ggplot which shapefile to plot
  geom_sf(aes(fill = IPBES_regi_type)) + #This is the main geom within ggplot that can turn the "geometry" into a map
  scale_fill_manual(values= colors) +    #Tell ggplot which colors to use
  geom_text(data = ipbes.coords, aes(X, Y, label = IPBES_sub), size= 1.75, #add the sub-region labels
            colour = "black", fontface= "bold") +
  theme(text = element_text(size=20), #This theme function allows you to customize the look of the plot. There are built in themes or you can create custom themes
        panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),axis.line = element_line(size=.7, color="black"),
        legend.position = "none",axis.title=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank())
#There are a few issues with the positioning of the labels but this looks pretty
#similar to the Brooks et al. Figure

##map_data and ggmap package
install.packages(c("mapdata", "ggmap"))
library(mapdata)
library(ggmap)
#The mapdata package contains data frames that are made for plotting in ggplot
#The ggmap package adds some mapping functionality to ggplot

#load a simple data frame that plots countries from the mapdata package
world<-map_data("world")

#rename countries in world to match ipbes.region.proc
##THIS IS INCOMPLETE##
world$region <- plyr::revalue(world$region, c("Bolivia"= "Bolivia (Plurinational State of)",
                                              "Republic of Congo"= "Congo",
                                              "Ivory Coast"= "Cote d'Ivoire",
                                              "UK"= "United Kingdom of Great Britain and Northern Ireland",
                                              "Greenland"= "Greenland",
                                              "Iran"= "Iran (Islamic Republic of)",
                                              "Laos"= "Lao People’s Democratic Republic",
                                              "South Korea"="Republic of Korea",
                                              "North Korea"= "Democratic People’s Republic of Korea",
                                              "Russia"= "Russian Federation",
                                              "Syria"= "Syrian Arab Republic",
                                              "Tanzania"= "United Republic of Tanzania",
                                              "USA"= "United States of America",
                                              "Venezuela"= "Venezuela (Bolivarian Republic of)",
                                              "Vietnam"= "Viet Nam"))

#merge the protected area, country-region table, and world map data frames
ipbes.region.proc<-merge(ipbes.country.region, ipbes.data, by.x = "ipbes.sub.region", by.y= "subregion")
map.ipbes<-merge(world, ipbes.region.proc, by.x="region", by.y= "country.ipbes", all.x=T)
map.ipbes<-merge(map.ipbes, gdp, by.x= "region", by.y= "country", all.x=T)

#merging reorder our data.frame we need to put it back so that ggplot can plot correctly
map.ipbes<-map.ipbes[order(map.ipbes$order),]

#plot of the world (much simplier than the shapefile and no need to use mapshaper)
ggplot(data = map.ipbes, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = NA) +
  theme_nothing()

#lets add some data on protecte areas (by subregion)
ggplot(data = map.ipbes, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  ggtitle("Proportion of protected area by region") +
  geom_polygon(data=map.ipbes, color = "black", aes(fill = total_proportion_in_protected_areas)) +
  scale_fill_gradient(low = "blue", high = "red", space = "Lab", na.value = "white", guide= "colourbar") +
  theme(text = element_text(size=16),axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(), legend.title = element_blank(),
        panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),
        legend.key = element_rect(fill = "white"))

#Its easy to change this what we plot by
#Now lets use GDP
ggplot(data = map.ipbes, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  ggtitle("GDP by country") +
  geom_polygon(data=map.ipbes, color = "black", aes(fill = gdp)) +
  scale_fill_gradient(low = "blue", high = "red", space = "Lab", na.value = "white", guide= "colourbar") +
  theme(text = element_text(size=16),axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(), legend.title = element_blank(),
        panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),
        legend.key = element_rect(fill = "white"))

# Other resources for learning R -------------------------------------------

#The swirl package: an interface within R for learning R
install.packages("swirl")
library(swirl)
swirl()

#Data carpentry (https://datacarpentry.org/R-ecology-lesson/01-intro-to-r.html)

#Stack exchange: You can often find answers to your questions with a quick
#google search which will often lead you to stack exchange (disclaimer: People there can be jerks)

#Twitter Use the hashtag #rstats someone can usually answer your question quickly
#or point you in the right direction


# Final Exercise ----------------------------------------------------------

## using the loaded datasets, create a novel and informantive figure ##
#own figure: