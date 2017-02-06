# install.packages("testthat")
library(testthat)

source("/Unit-Testing/fibo.R")

test_results <- test_dir("/Unit-Testing/", reporter="summary")