###QUESTION 04
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