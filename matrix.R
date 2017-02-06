# Creating my own matrix with rbind (row binding, row by row will be added)
# The counterpart to rbind is cbind where columns by columns will be added

months <- c("JAN 2017","FEB 2017","MAR 2017","APR 2017","MAI 2017","JUN 2017","JUL 2017","AUG 2017","SEP 2017","OCT 2017","NOV 2017","DEC 2017")
employees <- c("Kevin","Burim","Sam")

incomeU1 <- c(3000, 3200, 3400, 2800, 2700, 2900, 3200, 3250, 2850, 3160, 2990, 3600)
incomeU2<- c(4000, 3200, 4400, 3800, 3700, 3900, 4200, 4250, 4850, 4160, 4990, 4600)
incomeU3 <- c(5000, 5200, 5400, 5800, 5700, 5900, 5200, 5250, 5850, 5160, 5990, 6600)

Salaries <- rbind(incomeU1, incomeU2, incomeU3)
rm(incomeU1, incomeU2, incomeU3)
colnames(Salaries) <- months
rownames(Salaries) <- employees

Salaries

Salaries[1,] # salaries of 1st row (first employee)
Salaries["Kevin",] # salaries of 1st row (first employee), using names
Salaries[,2] # salaries of 2nd columns (2nd month)
Salaries[,"FEB 2017"] # salaries of 2nd columns (2nd month), using names
Salaries[1,6] # salary of first employee at 6th month
Salaries["Kevin","JUN 2017"] # salary of first employee at 6th month, using names

# Assigning the names directly to a vector
names(incomeBurim) <- months
names(incomeBurim)
incomeBurim
incomeBurim["JUN 2017"]
# removing the names again
names(incomeBurim) <- NULL
names(incomeBurim)
