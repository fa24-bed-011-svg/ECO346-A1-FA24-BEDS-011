/##Variant 3 — Sindh Urban

## Question 2: Weighted Earnings Histogram

| Statistic | Result |
|---|---:|
| Original observations | 6,687 |
| Valid earners | 2,644 |
| Excluded observations before final sample | 4,043 |
| Unweighted median annual earnings | Rs 252,000 |
| Weighted 10th percentile (P10) | Rs 120,000 |
| Weighted median (P50) | Rs 264,000 |
| Weighted 90th percentile (P90) | Rs 696,000 |
| P90/P10 ratio | 5.80 |
| Earners excluded from histogram range | 2 |

### Interpretation

The weighted median annual earnings of urban earners in Sindh are Rs 264,000, compared with the unweighted median of Rs 252,000. The weighted 10th and 90th percentiles are Rs 120,000 and Rs 696,000, respectively. The P90/P10 ratio of 5.80 indicates a substantial earnings gap between lower- and higher-earning workers. Of the 6,687 original observations, 4,043 did not meet the sample selection criteria, leaving 2,644 valid earners. Of these, two fell outside the histogram's specified earnings range of Rs 10,000 to Rs 10,000,000.


## Question 3: The Relationship Between Age and Earnings

### Figure

**Figure 2: Annual Earnings by Age in Urban Sindh**

![Annual Earnings by Age](figures/q3_age_earnings.svg)

**Figure file:** `figures/q3_age_earnings.svg`

The figure presents individual annual earnings by age, along with weighted mean earnings for each five-year age band. The vertical axis uses a logarithmic scale and is labelled in Pakistani rupees. Individual observations are shown as semi-transparent, horizontally jittered points, while larger markers connected by a line represent weighted mean earnings at each age-band midpoint. Hollow markers indicate age bands with fewer than 30 earners.

### Age-Band Statistics

| Age band (years) | Number of earners | Weighted mean earnings (Rs) |
|:---|---:|---:|
| 15–19 | 160 | 192,523 |
| 20–24 | 296 | 222,948 |
| 25–29 | 398 | 303,154 |
| 30–34 | 396 | 379,254 |
| 35–39 | 359 | 360,221 |
| 40–44 | 344 | 446,533 |
| 45–49 | 250 | 431,697 |
| 50–54 | 212 | 530,773 |
| 55–59 | 157 | 542,400 |
| 60–64 | 72 | 414,262 |

### Required Results

- **Weighted mean earnings for ages 25–29:** Rs 303,154.
- **Weighted mean earnings for ages 45–49:** Rs 431,697.
- **Age band with the highest weighted mean earnings:** Ages 55–59, at Rs 542,400.

### Interpretation

Weighted mean earnings generally increase across age bands, rising from Rs 192,523 for earners aged 15–19 to a peak of Rs 542,400 for those aged 55–59. However, the pattern is not consistently upward: mean earnings decline among ages 35–39 and 45–49, before falling to Rs 414,262 for ages 60–64. The mean for ages 45–49 is Rs 431,697, compared with Rs 303,154 for ages 25–29. From an economic perspective, these differences may reflect experience, occupation, or other factors. However, this cross-sectional figure cannot establish that an individual's earnings rise as they age or prove that age causes higher earnings.

## Question 4: Redesign of the Default Graph

The redesigned graph improves the default scatterplot in three ways. First, transparency makes overlapping individual observations easier to see. Second, the logarithmic y-axis makes earnings across a wide range easier to compare. Third, the weighted age-band means are highlighted with a blue line and markers, making the overall age pattern clearer. Clear axis labels, a descriptive title, and a source caption also improve interpretation. However, the redesign hides some of the raw visual simplicity of the default graph and may make the blue trend appear more prominent than individual variation.

### Q5: Python Reproduction and Comparison

The Python age-band table matches the R results. For ages 25–29, the weighted mean annual earnings are Rs 303,153.9 in both R and Python. Both graphs show the relationship between age and annual earnings using a logarithmic y-axis and weighted age-band means.

Small differences in appearance may occur because R and Python use different default plotting styles, fonts, and formatting settings.


## Figures: Before and After Redesign

### Default Figure
![Default Figure](figures/default.svg)

### Redesigned Figure
![Redesigned Figure](figures/q4_redesign.svg)
