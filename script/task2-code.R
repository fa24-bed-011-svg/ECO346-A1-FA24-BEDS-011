##QUESTION:02
nrow(data)
summary(data$earn_annual)
summary(data$hhweight)
data <- data[
  !is.na(data$earn_annual) &
    !is.na(data$hhweight) &
    data$earn_annual > 0 &
    data$hhweight > 0,
]

nrow(data)

weighted_quantile <- function(x, w, probs) {
  ord <- order(x)
  x <- x[ord]
  w <- w[ord]
  
  cum_w <- cumsum(w) / sum(w)
  
  sapply(probs, function(p) {
    x[which(cum_w >= p)[1]]
  })
}

weighted_results <- weighted_quantile(
  data$earn_annual,
  data$hhweight,
  c(0.10, 0.50, 0.90)
)

weighted_results

p10 <- weighted_results[1]
p50 <- weighted_results[2]
p90 <- weighted_results[3]

p90_p10_ratio <- p90 / p10

p90_p10_ratio

library(ggplot2)
library(svglite)
library(scales)

p_hist <- ggplot(data, aes(x = log10(earn_annual), weight = hhweight)) +
  geom_histogram(
    breaks = seq(4.0, 7.0, by = 0.1),
    aes(y = after_stat(count / sum(count) / 0.1)),
    fill = "steelblue",
    color = "white"
  ) +
  geom_vline(
    xintercept = log10(p50),
    linetype = "dashed",
    color = "red"
  ) +
  geom_vline(
    xintercept = log10(p90),
    linetype = "dashed",
    color = "darkgreen"
  ) +
  labs(
    title = "Annual Earnings Distribution: Sindh Urban",
    subtitle = "Weighted median (red) and 90th percentile (green)",
    x = "Annual earnings (Rs, log10 scale)",
    y = "Weighted density per log10 unit",
    caption = "Source: PSLM | Ages 15–64 | Positive annual earners | Weighted by household survey weight"
  ) +
  scale_x_continuous(
    breaks = 4:7,
    labels = c("10,000", "100,000", "1,000,000", "10,000,000")
  ) +
  theme_minimal()

p_hist

dir.create("figures", showWarnings = FALSE)

ggsave(
  "figures/q2_weighted_histogram.svg",
  plot = p_hist,
  width = 9,
  height = 6
)

file.exists("figures/q2_weighted_histogram.svg")
# Number of valid earners
n_earners <- nrow(data)

# Unweighted median
unweighted_median <- median(data$earn_annual)

# Weighted median and percentiles
p10 <- weighted_results[1]
p50 <- weighted_results[2]
p90 <- weighted_results[3]

# Display results
n_earners
unweighted_median
p10
p50
p90
p90 / p10

original_n <- 6687
valid_n <- nrow(data)

excluded_n <- original_n - valid_n
excluded_n
