library(tidyverse)

setwd("./src")

ls_est <- function(xdata, ydata) {
    x <- as.matrix(xdata)
    y <- as.matrix(ydata)
    n <- nrow(y)
    numerator <- 0
    denominator <- 0
    for (i in 1:n) {
        numerator <- numerator + (x[i] - mean(x)) * (y[i] - mean(y))
        denominator <- denominator + (x[i] - mean(x))^2
    }
    beta_hat <- numerator / denominator
    alpha_hat <- mean(y) - mean(x) * beta_hat
    return(list(alpha = alpha_hat, beta = beta_hat))
}

nsamples <- 120
sigma_e <- 1
alpha <- 1
beta <- 2
ntrials <- 1000
set.seed(1234)
x <- runif(nsamples, -5, 5)

simulation_results <-
    data.frame(a = array(0, ntrials), b = array(0, ntrials))
for (t in 1:ntrials) {
    e <- rnorm(nsamples, 0, sigma_e)
    y <- alpha + x * beta + e
    results <- ls_est(x, y)
    simulation_results[t, "a"] <- results$alpha
    simulation_results[t, "b"] <- results$beta
}
filename <-
    sprintf("../results/s_results_N%d_a%d_b%d.csv", nsamples, alpha, beta)
readr::write_csv(simulation_results, filename)

# plot histogram
p4_a <- ggplot(data = simulation_results["a"], aes(x = a)) +
    theme_classic() +
    geom_histogram(
        bins = 40,
        fill = "gray",
        alpha = 0.3,
        colour = "black"
    ) +
    geom_vline(xintercept = alpha, colour = "red") +
    labs(title = "histogram of a")
ggsave(
    filename = "../fig/p4_a.png",
    plot = p4_a,
    width = 4,
    height = 3
)

p4_b <- ggplot(data = simulation_results["b"], aes(x = b)) +
    theme_classic() +
    geom_histogram(
        bins = 40,
        fill = "gray",
        alpha = 0.3,
        colour = "black"
    ) +
    geom_vline(xintercept = beta, colour = "red") +
    labs(title = "histogram of b")
ggsave(
    filename = "../fig/p4_b.png",
    plot = p4_b,
    width = 4,
    height = 3
)

abin <- 0.01
amin <- alpha - 0.5
amax <- alpha + 0.5
axseq <- seq(amin, amax, abin)
am <- as.matrix(simulation_results["a"])
sxx <- sum((x - mean(x))^2)
v <- mean(x^2) / sxx
alpha_asy_dist <- dnorm(axseq, alpha, sqrt(v))
p5_a <- ggplot() +
    theme_classic() +
    geom_histogram(
        aes(x = am, y = ..density..),
        bins = 40,
        fill = "gray",
        alpha = 0.3,
        colour = "black"
    ) +
    geom_density(aes(x = am, y = ..density.., colour = "Density")) +
    geom_line(aes(x = axseq, y = alpha_asy_dist, colour = "Asy.Dist")) +
    scale_colour_manual("color", values = c("Density" = "red", "Asy.Dist" = "blue")) +
    labs(title = "Histogram and Asy.Dist of alpha", x = "alpha")
ggsave(
    filename = "../fig/p5_a.png",
    plot = p5_a,
    width = 4,
    height = 3
)

bbin <- 0.01
bmin <- beta - 0.3
bmax <- beta + 0.3
bxseq <- seq(bmin, bmax, bbin)
am <- as.matrix(simulation_results["b"])
sxx <- sum((x - mean(x))^2)
v <- 1 / sxx
beta_asy_dist <- dnorm(bxseq, beta, sqrt(v))
p5_b <- ggplot() +
    theme_classic() +
    geom_histogram(
        aes(x = am, y = ..density..),
        bins = 40,
        fill = "gray",
        alpha = 0.3,
        colour = "black"
    ) +
    geom_density(aes(x = am, y = ..density.., colour = "Density")) +
    geom_line(aes(x = bxseq, y = beta_asy_dist, colour = "Asy.Dist")) +
    scale_colour_manual("color", values = c("Density" = "red", "Asy.Dist" = "blue")) +
    labs(title = "Histogram and Asy.Dist of alpha", x = "beta")
ggsave(
    filename = "../fig/p5_b.png",
    plot = p5_b,
    width = 4,
    height = 3
)
