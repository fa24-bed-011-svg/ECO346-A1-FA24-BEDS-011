
# Task 1: Default graph for Question 4

# 1. Set repository folder
setwd("E:/AMNARASHEED-ECO346-Data-Visualization-Assignment")

# 2. Load required packages
library(ggplot2)
library(svglite)

# 3. Read local data files
person <- read.csv("data/pslm_person_subset.csv")
household <- read.csv("data/pslm_hh_subset.csv")

# 4. Attach household information to person data
data <- merge(
  person,
  household[, c("hhid", "hhweight", "prov_code", "urban_rural")],
  by = "hhid"
)

# 5. Select Variant 3: Sindh Urban earners
data <- data[
  data$prov_code == 3 &
    data$urban_rural == 2 &
    data$age >= 15 &
    data$age <= 64 &
    data$earn_annual > 0,
]

# 6. Create figures folder if it does not exist
dir.create("figures", showWarnings = FALSE)

# 7. Create the untouched default graph
p_default <- ggplot(data, aes(age, earn_annual)) +
  geom_point()

# 8. Save graph as SVG
ggsave(
  "figures/default.svg",
  plot = p_default,
  width = 8,
  height = 5
)
ggsave("figures/default.svg", plot = p_default, width = 8, height = 5)
file.exists("figures/default.svg")

#question2
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

#question3
names(data)
# Create 5-year age bands
data$age_band <- cut(
  data$age,
  breaks = seq(15, 65, by = 5),
  right = FALSE,
  labels = paste(seq(15, 60, by = 5),
                 seq(19, 64, by = 5),
                 sep = "-")
)

# Calculate weighted mean earnings for each age band
band_means <- aggregate(
  cbind(weighted_earnings = data$earn_annual * data$hhweight,
        weight = data$hhweight),
  by = list(age_band = data$age_band),
  FUN = sum
)

band_means$weighted_mean <- 
  band_means$weighted_earnings / band_means$weight

band_means

band_counts <- as.data.frame(table(data$age_band))

names(band_counts) <- c("age_band", "n_observations")

band_means <- merge(
  band_means,
  band_counts,
  by = "age_band",
  all.x = TRUE,
  sort = FALSE
)

band_means$midpoint <- seq(17, 62, by = 5)

band_means$thin <- band_means$n_observations < 30

band_means[, c(
  "age_band",
  "midpoint",
  "n_observations",
  "weighted_mean",
  "thin"
)]

p_q3 <- ggplot(data, aes(x = age, y = earn_annual)) +
  geom_point(
    position = position_jitter(width = 0.4, height = 0),
    alpha = 0.25
  ) +
  geom_line(
    data = band_means,
    aes(x = midpoint, y = weighted_mean, group = 1),
    color = "blue",
    linewidth = 1
  ) +
  geom_point(
    data = band_means,
    aes(x = midpoint, y = weighted_mean),
    color = "blue",
    size = 3
  ) +
  geom_text(
    data = band_means[which.max(band_means$weighted_mean), ],
    aes(
      x = midpoint,
      y = weighted_mean,
      label = paste("Highest:", age_band)
    ),
    vjust = -1,
    color = "red"
  ) +
  scale_x_continuous(
    breaks = seq(15, 65, by = 5),
    limits = c(15, 65)
  ) +
  scale_y_log10(
    limits = c(10000, 10000000),
    labels = scales::label_comma()
  ) +
  labs(
    title = "Annual Earnings by Age: Sindh Urban",
    x = "Age (years)",
    y = "Annual earnings (Rs, log scale)",
    caption = "Source: PSLM | Ages 15–64 | Positive earners | Weighted age-band means"
  ) +
  theme_minimal()

p_q3

ggsave(
  "figures/q3_age_earnings.svg",
  plot = p_q3,
  width = 9,
  height = 6
)

file.exists("figures/q3_age_earnings.svg")

p_redesign <- ggplot(data, aes(x = age, y = earn_annual)) +
  geom_point(
    alpha = 0.15,
    color = "grey40",
    position = position_jitter(width = 0.25, height = 0)
  ) +
  geom_line(
    data = band_means,
    aes(x = midpoint, y = weighted_mean, group = 1),
    color = "blue",
    linewidth = 1
  ) +
  geom_point(
    data = band_means,
    aes(x = midpoint, y = weighted_mean),
    color = "blue",
    size = 3
  ) +
  scale_x_continuous(
    breaks = seq(15, 65, 5),
    limits = c(15, 65)
  ) +
  scale_y_log10(
    limits = c(10000, 10000000),
    labels = scales::label_comma()
  ) +
  labs(
    title = "How Earnings Vary with Age",
    subtitle = "Sindh urban earners, ages 15–64",
    x = "Age (years)",
    y = "Annual earnings (Rs, log scale)",
    caption = "Source: PSLM | Points show individuals; blue line shows weighted age-band means"
  ) +
  theme_minimal(base_size = 12)

p_redesign

ggsave(
  "figures/q4_redesign.svg",
  plot = p_redesign,
  width = 9,
  height = 6
)

file.exists("figures/q4_redesign.svg")