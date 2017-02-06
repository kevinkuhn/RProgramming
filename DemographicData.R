# open file by choosing
# data <- read.csv(file.choose())

# getting the working directory
getwd()
# setting working directory
setwd("/src/github.com/kevinkuhn/RProgrammingAZ")
# open file by path
stats <- read.csv("DemographicData.csv", header=T, sep=",")

######### Exploring Data #########

# number of rows and columns
nrow(stats)
ncol(stats)
# show 6 top and 6 bottom entries
head(stats)
tail(stats)
# show data structure
str(stats)
# breakdown of every column
summary(stats)

######### Using th $ sign #########

levels(stats$Income.Group)

######### Basic Operations with a DF #########

stats[1:10,] # subsetting

# adding a new column
stats$myNewColumn <- stats$Birth.rate * stats$Internet.users
head(stats)
# removing column
stats$myNewColumn <- NULL

######### Filtering Data Frames #########

filter <- stats$Internet.users < 2
stats[filter,c(1,4)]

# high birth rates
stats[stats$Birth.rate>40,c(1,3)]

# high birth rates & low internet
stats[stats$Birth.rate>40 & stats$Internet.users < 2,c(1,3,4)]

# shwo high income countries
stats[stats$Income.Group == "High income",]
# or
stats[stats$Income.Group == (levels(stats$Income.Group)[1]),]

# search for a specific country
stats[stats$Country.Name == "Malta",]

######### qplot() #########

library("ggplot2")
# ?qplot

clientColor1 = "#78133d"
clientColor2 = "#171c2f"

qplot(data = stats, x=Income.Group, y=Birth.rate)
qplot(data = stats, x=Income.Group, y=Birth.rate, size=I(3)) # I(3) prevents 10 of being mapped
qplot(data = stats, x=Income.Group, y=Birth.rate, size=I(3), color=I(clientColor1))
# creating a boxplot
qplot(data = stats, x=Income.Group, y=Birth.rate, geom="boxplot") 

qplot(data = stats, x=Internet.users, y=Birth.rate)
qplot(data = stats, x=Internet.users, y=Birth.rate, size=I(1)) 
qplot(data = stats, x=Internet.users, y=Birth.rate, size=I(1), color=I(clientColor1)) 
qplot(data = stats, x=Internet.users, y=Birth.rate, size=I(1), color=Income.Group) 

######### Creating Data Frames #########

mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset, Regions_2012_Dataset)
head(mydf)
# renaming column names
# colnames(mydf) <- c("Country", "Code", "Region")
# rm(mydf)
# this can be done directly when creating the DF
mydf <- data.frame(Country=Countries_2012_Dataset, Code=Codes_2012_Dataset, Region=Regions_2012_Dataset)

######### Merging Data Frames #########

head(stats)
head(mydf)

merged <- merge(stats,mydf, by.x = "Country.Code", by.y = "Code")
merged$Country <- NULL
head(merged)

######### Visualization #########

# Basic Plot
qplot(data=merged, x = Internet.users, y = Birth.rate, color=Region)
# 1. Shapes
qplot(data=merged, x = Internet.users, y = Birth.rate, color=Region, size=I(3), shape=I(17))
# 2. Transparency
qplot(data=merged, x = Internet.users, y = Birth.rate, color=Region, size=I(3), shape=I(19), alpha=I(0.6))
# 3. Title
qplot(data=merged, x = Internet.users, y = Birth.rate, color=Region, size=I(3), shape=I(19), alpha=I(0.6), main="Birth Rate vs. Internet Users")

######### Visualization #########


