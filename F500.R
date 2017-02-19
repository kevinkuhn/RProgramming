# getwd()
# setting working directory
setwd("/Users/jaywalkerdigital/goworkspace/src/github.com/kevinkuhn/RProgramming")
# Basic import
# fin <- read.csv("F500/Future-500.csv", header=T, sep=",")
# import that replaces empty values with NA
fin <- read.csv("F500/Future-500.csv", header=T, sep=",", na.strings = c(""))
fin

head(fin)
tail(fin, 10)
str(fin)
summary(fin)

# Changing from non-factor to factor
fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)

###### CLEANUP ######
# sub() & gsub()
# sub replaces only the first instance, gsub all the instances
fin$Expenses <- gsub(" Dollars","", fin$Expenses)
fin$Expenses <- gsub(",","", fin$Expenses)
head(fin)

fin$Revenue <- gsub("\\$","", fin$Revenue)
fin$Revenue <- gsub(",","", fin$Revenue)
head(fin)

fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Profit <- as.numeric(fin$Profit)

fin$Growth <- gsub("\\%","", fin$Growth)
str(fin$Growth)
fin$Growth <- as.numeric(fin$Growth)
fin$Growth <- fin$Growth/100
head(fin)

# removing NA
# show all cases/rows where a NA occures and returns a FALSE
complete.cases(fin)
# output all the negatives
fin[!complete.cases(fin),]
# <NA> represents a NA for a factor. Without <> it is an non-factor

# Filtering: using which() for non-missing data
# which() ignores the NA
# fin[fin$Revenue == 9254614,]
fin[which(fin$Revenue == 9254614),]
# fin[fin$Employees == 45,]
fin[which(fin$Employees == 45),]

# is.na() for missing data
fin[is.na(fin$Revenue),]
fin[is.na(fin$Employees),]
fin[is.na(fin$Expenses),]

# removing records with missing data
fin_backup <- fin
# fin <- fin_backup
# show incomplete cases
fin[!complete.cases(fin),]
fin[is.na(fin$Industry),]
fin[!is.na(fin$Industry),]
fin <- fin[!is.na(fin$Industry),]

# Reseting the dataframe index
rownames(fin) <- NULL
tail(fin)

# Replacing missing data_ Factual Analysis
fin[!complete.cases(fin),]
fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "New York",]
fin[is.na(fin$State) & fin$City == "New York","State"] <- "NY"
# check:
# fin[c(11,377),]

fin[which(is.na(fin$State)), "City"]
fin[which(is.na(fin$State)),]

fin[is.na(fin$State),]
fin[fin$City == "San Francisco",]
fin[fin$City == "San Francisco" & is.na(fin$State),]
fin[fin$City == "San Francisco" & !is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "San Francisco","State"] <- "CA"

####### Replacing Missing Data: Median Imputation Method (Part 1) #######
fin[!complete.cases(fin),]

med_emp_retail <- median(fin[fin$Industry == "Retail", "Employees"], na.rm = T)
med_emp_retail
fin[is.na(fin$Employees & fin$Industry == "Retail"),"Employees"] <- med_emp_retail
# check
# fin[3,]
med_emp_financial_services <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm = T)
med_emp_financial_services
fin[is.na(fin$Employees & fin$Industry == "Financial Services"),"Employees"] <- med_emp_financial_services
# check
# fin[330,]

####### Replacing Missing Data: Median Imputation Method (Part 2) #######
med_growth_const <- median(fin[fin$Industry == "Construction", "Growth"], na.rm = T)
med_growth_const
fin[is.na(fin$Growth & fin$Industry == "Construction"),"Growth"] <- med_growth_const

# Revenue Construction
med_rev_constr <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm = T)
med_rev_constr
fin[is.na(fin$Revenue) & fin$Industry == "Construction",]
fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- med_rev_constr

med_exp_constr <- median(fin[fin$Industry == "Construction", "Expenses"], na.rm = T)
med_exp_constr
fin[is.na(fin$Expenses) & fin$Industry == "Construction" & is.na(fin$Profit),]
fin[is.na(fin$Expenses) & fin$Industry == "Construction" & is.na(fin$Profit),"Expenses"] <- med_exp_constr

fin[!complete.cases(fin),]

### Replacing Missing Data: Deriving Values ###
# Revenue - Expenses = Profit
# Expenses = Revenue - Profit
fin[is.na(fin$Profit),"Profit"] <- fin[is.na(fin$Profit),"Revenue"] - fin[is.na(fin$Profit),"Expenses"]
fin[is.na(fin$Expenses),"Expenses"] <- fin[is.na(fin$Expenses),"Revenue"] - fin[is.na(fin$Expenses),"Profit"]
fin[!complete.cases(fin),]

# Visualize
library(ggplot2)

# Scatterplot
p <- ggplot(data = fin)
p + geom_point(aes(x=Revenue, y=Expenses, color=Industry, size = Profit, alpha = 0.4))

# Boxplot
d <- ggplot(data = fin, aes(x=Revenue, y=Expenses, color=Industry))
d + geom_point() + geom_smooth(fill = NA, size= 1.2)

# Extra
f <- ggplot(data = fin, aes(x=Industry, y = Growth, color = Industry))
f + geom_jitter(alpha = 0.3) + geom_boxplot(alpha=0.7, outlier.colour = NA)
