# Movie Ratings

movies <- read.csv("Movie-Ratings.csv", header=T, sep=",")
head(movies)
colnames(movies) <- c("Film","Genre","CriticRating","AudienceRating","BudgetMilions","Year")
head(movies)
tail(movies)
summary(movies)

# convert Year to factor
movies$Year <- factor(movies$Year)
str(movies)

############ Aesthetics aes() ############
library("ggplot2")

# IMPORTANT: the aes fuction should only be used when data has to be mapped
# like for example the Genre to color. Assigning "Red" as color would map
# the string to the plot and therefore not display it correctly.

# basic ggplot (will show nothing, as geometry layer is not defined)
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
# add geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) +
  geom_point()
# add colors
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre)) +
  geom_point()
# add size
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMilions)) +
  geom_point()
# add alpha
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMilions, alpha=0.4)) +
  geom_point()

############ Mapping VS. Setting ############

r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

# add color
# 1. by mapping (hard way)
r + geom_point(aes(color=Genre))
# 2. by setting
r + geom_point(color="DarkGreen")
# ERROR - this way it would try to map the color
# r + geom_point(aes(color="DarkGreen"))

############ Histogram and Density Charts ############

s <- ggplot(data=movies, aes(x = BudgetMilions))
s + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")

# density chart
s + geom_density(aes(fill=Genre), alpha = 0.25)
s + geom_density(aes(fill=Genre), position="stack")

############ Layer ############

t <- ggplot(data=movies, aes(x = AudienceRating))
t + geom_histogram(binwidth = 10,
                   fill = "white", color = "Grey")

############ geom_smooth ############

u <- ggplot(data=movies, aes(x = CriticRating, y = AudienceRating, color=Genre))
u + geom_point() + geom_smooth(fill = NA)

############ geom_smooth ############

u <- ggplot(data=movies, aes(x = Genre, y = AudienceRating, color=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()
# tip / hack
u + geom_boxplot(size=1.2) + geom_jitter()
# even better
u + geom_jitter(color="#171c2f", alpha= 0.5) + geom_boxplot(size=1, color="#78133d", alpha=0.5)

############ Using Facts ############

v <- ggplot(data=movies, aes(x = BudgetMilions))
v + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")

# facets
v + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  facet_grid(Genre~.)
# distribution depending on height of row
v + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  facet_grid(Genre~., scales="free")

# scatterplots
w <- ggplot(data=movies, aes(x = CriticRating, y = AudienceRating, color = Genre))
w + geom_point(alpha=.5) +
  facet_grid(Genre~.)
# By Year
w + geom_point(alpha=.5) +
  facet_grid(.~Year)
# By Genre ~ Year
w + geom_point(alpha=.5) +
  geom_smooth(fill = NA) +
  facet_grid(Genre~Year)
# By Genre ~ Year
w + geom_point(alpha=.5, aes(size=BudgetMilions)) +
  geom_smooth(fill = NA) +
  facet_grid(Genre~Year)

############ Coordinates ############

m <- ggplot(data=movies, aes(x = CriticRating, y = AudienceRating, alpha = .5, color=Genre, size=BudgetMilions))
m + geom_point() +
  xlim (50, 100) +
  ylim (50, 100)

# zoom

n <- ggplot(data=movies, aes(x = BudgetMilions))
n + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  coord_cartesian(ylim= c(0, 50))

w + geom_point(alpha=.5, aes(size=BudgetMilions)) +
  geom_smooth(fill = NA) +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim = c(0, 100))

############ Adding Themes  ############

o <- ggplot(data=movies, aes(x = BudgetMilions))
h <- o + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")

# axis label
h + xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(color = "DarkGreen", size = 20),
        axis.title.y = element_text(color = "DarkBlue", size = 20))
  
# tick mark formatting
h + xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(color = "DarkGreen", size = 20),
        axis.title.y = element_text(color = "DarkBlue", size = 20),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10))

?theme

# legend formatting
h + xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(color = "DarkGreen", size = 20),
        axis.title.y = element_text(color = "DarkBlue", size = 20),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 10),
        legend.position = c(1,1),
        legend.justification = c(1,1))

# title of plot
h + xlab("Money Axis") +
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(color = "DarkGreen", size = 20),
        axis.title.y = element_text(color = "DarkBlue", size = 20),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 10),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(size = 30, color="Orange", family = "Courier"))
# 



