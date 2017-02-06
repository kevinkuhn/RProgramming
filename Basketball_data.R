Games
Games["LeBronJames", "2011"]

FieldGoals
round(FieldGoals / Games,1)

round(MinutesPlayed / Games, 1)

# transpose table
t(FieldGoals)

matplot(t(FieldGoals), type="b", pch=15:18, col = c(1,4,6) )
# add a legend
legend("bottomleft", inset=0.0, legend=Players, col = c(1,4,6), pch=15:18, horiz = F)

# Splitting up matrix to just one part
Games[1:3,6:10]
# Comparing only the 1st and the 10th entry
Games[c(1,10),]
# or
Games[c("KobeBryant","DwayneWade"),]

# one dimensional matrix like for example Games[1,] are not a Matrix anymore
# as they are only one dimensional they get transformed to a vector
# 
# is.matrix(Games[1,])
# is.vector(Games[1,])
#
# to undo this you can set the drop function to False
Games[1,,drop=F]

# drop = F has to be added to this example if only one player has to be shown
Data <- MinutesPlayed[1,,drop=F]
matplot(t(Data), type="b", pch=15:18, col = c(1,4,6) )
legend("bottomleft", inset=0.0, legend=Players[1], col = c(1:4,6), pch=15:18, horiz = F)

# Now making a function out of it

myplot <- function(dataset, rows=1:10){
  Data <- dataset[rows,,drop=F]
  matplot(t(Data), type="b", pch=15:18, col = c(1,4,6) )
  legend("bottomleft", inset=0.0, legend=Players[rows], col = c(1:4,6), pch=15:18, horiz = F)
}

myplot(Salary) # with defualt param of rows = 1:10
myplot(Salary, 1:2) # looking at player 1 and 2
myplot(MinutesPlayed/Games, 3)


v1 <- c(1, 22, 33)

v2 <- c("Hi", "there", "friend")

v3 <- c(11, 3, 2016)

D <- rbind(v1,v2,v3)
D

D[3,2]