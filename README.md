## Question 2: Weighted Earnings Histogram

| Statistic | Result |
|---|---:|
| Original observations | 6,687 |
| Valid earners | 2,644 |
| Excluded observations | 4,043 |
| Unweighted median annual earnings | Rs 252,000 |
| Weighted 10th percentile (P10) | Rs 120,000 |
| Weighted median (P50) | Rs 264,000 |
| Weighted 90th percentile (P90) | Rs 696,000 |
| P90/P10 ratio | 5.8 |

The weighted median annual earnings of urban earners in Sindh are Rs 264,000, compared with an unweighted median of Rs 252,000. The weighted 10th and 90th percentiles are Rs 120,000 and Rs 696,000, respectively. The P90/P10 ratio is 5.8, indicating substantial earnings inequality within the selected sample. Out of 6,687 original observations, 4,043 were excluded because earnings or household weights were missing or did not meet the selection criteria, leaving 2,644 valid earners.                                      



##Question 3: Annual Earnings by Age

##Weighted Mean Earnings by Age Band

| Age Band | Midpoint | Unweighted Observations | Weighted Mean Earnings (Rs) |
|---|---:|---:|---:|
| 15–19 | 17 | 160 | 192,523.1 |
| 20–24 | 22 | 296 | 222,947.6 |
| 25–29 | 27 | 398 | 303,153.9 |
| 30–34 | 32 | 396 | 379,254.0 |
| 35–39 | 37 | 359 | 360,221.2 |
| 40–44 | 42 | 344 | 446,533.3 |
| 45–49 | 47 | 250 | 431,696.7 |
| 50–54 | 52 | 212 | 530,772.9 |
| 55–59 | 57 | 157 | 542,400.0 |
| 60–64 | 62 | 72 | 414,262.5 |

All age bands contain at least 30 unweighted observations.

 ##Economic Interpretation

Weighted mean earnings generally increase with age, rising from Rs 192,523 for ages 15–19 to a peak of Rs 542,400 for ages 55–59. However, earnings do not increase continuously: the 35–39 and 45–49 groups show declines compared with the preceding bands, and earnings fall to Rs 414,263 for ages 60–64. The mean for ages 45–49 is Rs 431,697, compared with Rs 303,154 for ages 25–29. One limitation is that these are cross-sectional age-group comparisons, so they do not prove that an individual's earnings rise as they grow older.


## Question 4: Redesign of the Default Graph

The redesigned graph improves the default scatterplot in three ways. First, transparency makes overlapping individual observations easier to see. Second, the logarithmic y-axis makes earnings across a wide range easier to compare. Third, the weighted age-band means are highlighted with a blue line and markers, making the overall age pattern clearer. Clear axis labels, a descriptive title, and a source caption also improve interpretation. However, the redesign hides some of the raw visual simplicity of the default graph and may make the blue trend appear more prominent than individual variation.

### Q5: Python Reproduction and Comparison

The Python age-band table matches the R results. For ages 25–29, the weighted mean annual earnings are Rs 303,153.9 in both R and Python. Both graphs show the relationship between age and annual earnings using a logarithmic y-axis and weighted age-band means.

Small differences in appearance may occur because R and Python use different default plotting styles, fonts, and formatting settings.
