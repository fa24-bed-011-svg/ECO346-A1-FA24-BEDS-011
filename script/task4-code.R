# STEP 3: REDESIGNED GRAPH

p_redesign <- ggplot(data, aes(x = age, y = earn_annual)) +
  geom_point(
    alpha = 0.15,
    position = position_jitter(width = 0.4, height = 0),
    color = "grey40",
    size = 1.5
  ) +
  geom_line(
    data = band_means,
    aes(x = midpoint, y = weighted_mean),
    inherit.aes = FALSE,
    color = "blue",
    linewidth = 1
  ) +
  geom_point(
    data = band_means,
    aes(x = midpoint, y = weighted_mean),
    inherit.aes = FALSE,
    shape = 21,
    fill = "white",
    color = "blue",
    size = 3
  ) +
  geom_text(
    data = band_means[which.max(band_means$weighted_mean), ],
    aes(
      x = midpoint,
      y = weighted_mean,
      label = paste0(
        age_band,
        ": Rs ",
        round(weighted_mean)
      )
    ),
    inherit.aes = FALSE,
    vjust = -1,
    color = "blue",
    size = 3.5
  ) +
  scale_x_continuous(
    breaks = seq(15, 65, by = 5)
  ) +
  scale_y_log10(
    labels = scales::label_comma()
  ) +
  coord_cartesian(
    ylim = c(10000, 10000000)
  ) +
  labs(
    title = "Annual Earnings by Age: Individual Observations and Weighted Means",
    subtitle = "Sindh urban working earners, ages 15–64",
    x = "Age (years)",
    y = "Annual earnings (Rs, log scale)",
    caption = paste(
      "Source: PSLM 2019–20.",
      "Sample: earners aged 15–64 with positive annual earnings.",
      "Weighted means use household weights (hhweight).",
      "Hollow markers show five-year age-band weighted means."
    )
  ) +
  theme_minimal()

# Display redesigned graph
p_redesign

# Save redesigned graph
ggsave(
  filename = "figures/redesign.svg",
  plot = p_redesign,
  width = 10,
  height = 6
)

# Verify both files
file.exists("figures/default.svg")
file.exists("figures/q4_redesign.svg")