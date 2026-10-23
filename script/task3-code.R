##QUESTION 03
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

