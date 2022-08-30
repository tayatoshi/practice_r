library(tidyverse)
set.seed(12345)

setwd("./src")
getwd()

# the number of samples
n1 <- 30
n2 <- 30
n3 <- 30

# intercept
a1 <- 1.8
a2 <- 2.0
a3 <- 2.2

# slope
b1 <- -0.4
b2 <- 0.6
b3 <- 1.4

# error term
e1 <- rnorm(n1, 0, 1)
e2 <- rnorm(n2, 0, 1)
e3 <- rnorm(n3, 0, 1)

x1 <- runif(n1, 1.5, 4)
x2 <- runif(n2, 2, 6)
x3 <- runif(n3, 3, 8)

y1 <- a1 + x1 * b1 + e1
y2 <- a2 + x2 * b2 + e2
y3 <- a3 + x3 * b3 + e3

d1 <- data.frame(X = x1, Y = y1, s = "P")
d2 <- data.frame(X = x2, Y = y2, s = "Q")
d3 <- data.frame(X = x3, Y = y3, s = "R")

d <- rbind(d1, d2)
d <- rbind(d, d3)
nrow <- nrow(d)
rd  <- d[sample(nrow),]# randomize d

readr::write_csv(rd, "../data/sample.csv")
