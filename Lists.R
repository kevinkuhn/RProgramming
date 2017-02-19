setwd("/Users/jaywalkerdigital/goworkspace/src/github.com/kevinkuhn/RProgramming")

util <- read.csv("Machine-Utilization.csv")

head(util, 12)
str(util)
summary(util)
# Derive utilization column
util$Utilization <- 1 - util$Percent.Idle
head(util, 12)

# Handling Date-Times
# ?POSIXct
util$Timestamp
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util, 12)

# TIP: How to rearrange columns in a df
util$Timestamp <- NULL
util <- util[c(4,1,2,3)]

# Making a subset for RL1
RL1 <- util[util$Machine == "RL1",]
RL1$Machine <- factor(RL1$Machine)
summary(RL1)
# Construct List
# Character: Machine Name
# Vector
util_stats_rl1 <- c(min(RL1$Utilization, na.rm = T),
                    mean(RL1$Utilization, na.rm = T),
                    max(RL1$Utilization, na.rm = T))
util_stats_rl1
# Logical
util_under_90_flag <- length(which(RL1$Utilization < .9)) > 0
util_under_90_flag

list_rl1 <- list("RL1", util_stats_rl1, util_under_90_flag)
list_rl1

# Naming components of list
names(list_rl1)
names(list_rl1) <- c("Machine","Stats", "LowThreshold")
names(list_rl1)
# Another way to name components
rm(list_rl1)
list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowThreshold=util_under_90_flag)
names(list_rl1)

# Extracting Components of a List
# Three ways:
# [] - will always return a list
# [[]] - will always return the actual object
# $ - same [[]] but prettier
list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

list_rl1[2]
list_rl1[[2]]
list_rl1$Stats

typeof(list_rl1[2])
typeof(list_rl1[[2]])
typeof(list_rl1$Stats)

list_rl1[[2]][3]
list_rl1$Stats[3]

# Adding and deleting list components
list_rl1
list_rl1[4] <- "New Information"

# another way to add a component - via the $
# we will add:
# Vector: All the hours where utilization is unknown (NA's)

list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1

# remove a component
list_rl1[4] <- NULL
# Important, the numeration has now shifted

# add another component
# Dataframe: For this machine
list_rl1$Data <- RL1
list_rl1

summary(list_rl1)

# Subsetting a list
list_rl1
list_rl1[1:3]
list_rl1[c(1,4)]
sublist_rl1 <- list_rl1[c("Machine", "Stats")]
sublist_rl1
sublist_rl1[[2]][2]

# [[]] is used to access element, like [[1]]
# [] is used for subsetting, like [1:3]

# Time series plot
library("ggplot2")

p <- ggplot(data=util)
myplot <- p + geom_line(aes(x=PosixTime, y=Utilization, color=Machine), size=0.7) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.9,
             color="Grey", size = 0.7, linetype=3)

# adding the plot to the list
list_rl1$Plot <- myplot
list_rl1
summary(list_rl1)
str(list_rl1)

# 
