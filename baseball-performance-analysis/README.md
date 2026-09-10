# Baseball Performance Analysis

## Project Overview

This project analyzes historical Major League Baseball team data to
investigate relationships between offensive performance and team success.

The analysis focuses on two questions:

1. Is team on-base percentage (OBP) associated with the number of wins?
2. Is team batting average associated with playoff appearance?

## Tools

- R
- ggplot2
- dplyr
- Linear Regression
- Statistical Hypothesis Testing
- Data Visualization

## Dataset

The dataset contains team-level baseball statistics from 1962–2012,
including wins, batting average, on-base percentage, runs scored,
runs allowed, and playoff appearance.

## Analysis

### OBP and Wins

I created visualizations and a linear regression model to examine the
relationship between team on-base percentage and wins.

The model indicated a statistically significant positive relationship
between OBP and wins. The model's R-squared value was approximately
23%, indicating that OBP explains some, but not all, of the variation
in team wins.

### Batting Average and Playoff Appearance

I compared the batting averages of playoff and non-playoff teams.

After checking the assumptions of an ANOVA model, I found that the
homogeneity of variance assumption was violated. I therefore used
nonparametric and correlation-based methods to further examine the
relationship.

## Key Takeaways

- Higher team OBP was associated with more wins.
- OBP alone does not explain most of the variation in team wins.
- Playoff and non-playoff teams showed differences in batting average.
- Additional variables could be incorporated into a multiple regression
  model to better explain team success.

## Files

- `baseball_analysis.R` — R code used for the analysis
- `baseball_analysis_report.pdf` — Full written analysis and results
- `data/` — Dataset used for the project
