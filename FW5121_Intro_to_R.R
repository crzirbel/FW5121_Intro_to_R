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
#'    b. R projects?
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

##R basics##

# The different parts of R
#' 1. The script
#' 2. The Console
#' 3. Environment
#' 4. Files/Plots/Packages/Help

#Run code by pressing ctrl+enter (cmd+enter on a mac) on a line of code within an R script
7*2*2

##assigning variables
x<-3
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
mean(w)

##getting help##
##a question mark before a function pulls up the help file asociated with said function
?mean() 

#on each line, everything after a pound sign will not be calculated, but instead will run as a comment
?mean() #F1 while cursor is in the function is a shortcut for this

#two question marks locates all occurences of the word within all base R and loaded package help files
??mean()

#We can also create our own functions. Here is a function the calculates the mean.
#redundant I know but hopefully you can see the utility

my_mean_func<-function(x){ # my_mean_function[names the function] <- function(x[names arguments you'll use in maikng fn]){[starts function]
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

library(janitor)

## Loops
#We can use loops to complete repetitive calculations and tasks:

for (i in 1:length(b)){
  print(b[i]^2)
}

## Exercise: Write a function that will calculate the standard deviation of a 
#population from a sample of the pop (sample SD - 
# https://statistics.laerd.com/statistical-guides/measures-of-spread-standard-deviation.php).
# Then use your function to caclulate sd from this sample: 

sd <- function(x){
  a <- c() # make an empty variable "a" to store intermediate calculations
  for (i in 1:length(x)){ # for numbers 1-length of our sample, 
    a[i] <- (x[i] - mean(x))^2 # for each position (1 through length(sample)) in "a", calculate for that same position in "x", the dif of each value from mean of "x", and square that value; 
  }
  return(sqrt((sum(a)/(length(x)-1)))) # calculate & return the square root of the sum of all the values in "a" divided by the size of our sample minus 1.
}

#test the function using a known sample
# R has built in stats including a nice set of distributions: dnorm(), dpois(), etc.
# The prefix "r" will select a random set from the distribution chosed, like "rnorm(n, mean, sd)"
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

##loading data##
#exercise goes here (HW data)

#cleaning messy data

# Workiong with datasets -------------------------------------------------
#load data
ipbes.data<-read.csv("https://datadryad.org/bitstream/handle/10255/dryad.107691/PAs_IPBES.csv?sequence=5")

#Veiw(), summary(), str()
View(ipbes.data)

#reloading data with na.strings and clean_names to fix problems in the df
ipbes.data<-read.csv("https://datadryad.org/bitstream/handle/10255/dryad.107691/PAs_IPBES.csv?sequence=5",
                     na.strings = "n/a")
ipbes.data<-clean_names(ipbes.data)


#calculations on ipbes.data (excel comparison)

#manipulate ipbes.data (subsetting) plotting raw data

#calculations on data

##merging datasets (economic, tourism)

##plotting
library(ggplot2)

#mapping

#cut em loose
#own figure

# Other resources for learning R -------------------------------------------

#The swirl package




