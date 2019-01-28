#========================================================#
#                                                        #
#     Intro to R                                         #
#     FW5121 Conservation Planning                       #
#     Spring 2019                                        #
#     By: Chad Zirbel, Mike Verhoeven, and Laura Dee     #
#                                                        #
#========================================================#

#####

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


# R setup & tutorial ------------------------------------------------------

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

#two question marks locates all occurences of the word within all base R and loaded package help files
??mean()

#We can also create our own functions. Here is a function the calculates the mean.
#redundant I know but hopefully you can see the utility
my_mean_func<-function(x){
  x_mean<-sum(x)/length(x)
  return(x_mean)
}

b<-c(1,2,3,4)
my_mean_func(b)

#

















