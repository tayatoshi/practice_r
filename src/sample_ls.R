library(tidyverse)
library(estimatr)


setwd("./src")
getwd()

df <- readr::read_csv("../data/sample.csv")

p0 <- ggplot(data = df, mapping = aes(x = X, y = Y)) +
  geom_point()
ggsave(
  filename = "../fig/p0.png",
  plot = p0,
  width = 4,
  height = 3
)
p0

n <- nrow(df)
x <- as.matrix(df["X"])
y <- as.matrix(df["Y"])

numerator <- 0
denominator <- 0
for (i in 1:n) {
  numerator <- numerator + (x[i] - mean(x)) * (y[i] - mean(y))
  denominator <- denominator + (x[i] - mean(x)) ^ 2
}
beta_hat <- numerator / denominator
alpha_hat <- mean(y) - mean(x) * beta_hat
print(alpha_hat)
print(beta_hat)

lm_result <- estimatr::lm_robust(y ~ x)
print(lm_result)

p1 <- ggplot(data = df, mapping = aes(x = X, y = Y)) +
  geom_point() +
  geom_abline(intercept = alpha_hat,
              slope = beta_hat,
              colour = "red")
ggsave(
  filename = "../fig/p1.png",
  plot = p1,
  width = 4,
  height = 3
)
p1

p2 <- ggplot(data = df, mapping = aes(x = X, y = Y)) +
  geom_point(aes(colour = s))
ggsave(
  filename = "../fig/p2.png",
  plot = p2,
  width = 4,
  height = 3
)
p2

df_p <- df %>%
  filter(s == "P") %>%
  select(X, Y)
df_q <- df %>%
  filter(s == "Q") %>%
  select(X, Y)
df_r <- df %>%
  filter(s == "R") %>%
  select(X, Y)

ls_est <- function(xdata, ydata) {
  x <- as.matrix(xdata)
  y <- as.matrix(ydata)
  n <- nrow(y)
  numerator <- 0
  denominator <- 0
  for (i in 1:n) {
    numerator <- numerator + (x[i] - mean(x)) * (y[i] - mean(y))
    denominator <- denominator + (x[i] - mean(x)) ^ 2
  }
  beta_hat <- numerator / denominator
  alpha_hat <- mean(y) - mean(x) * beta_hat
  return(list(alpha = alpha_hat, beta = beta_hat))
}

all_results <- ls_est(df["X"], df["Y"])
p_results <- ls_est(df_p["X"], df_p["Y"])
q_results <- ls_est(df_q["X"], df_q["Y"])
r_results <- ls_est(df_r["X"], df_r["Y"])

p3 <- ggplot(data = df, mapping = aes(x = X, y = Y)) +
  geom_point(aes(colour = s)) +
  geom_abline(
    intercept = all_results$alpha,
    slope = all_results$beta,
    colour = "black",
    linetype = "dashed"
  ) +
  geom_abline(intercept = p_results$alpha,
              slope = p_results$beta,
              colour = "red") +
  geom_abline(intercept = q_results$alpha,
              slope = q_results$beta,
              colour = "green") +
  geom_abline(intercept = r_results$alpha,
              slope = r_results$beta,
              colour = "blue")
ggsave(
  filename = "../fig/p3.png",
  plot = p3,
  width = 4,
  height = 3
)
p3

