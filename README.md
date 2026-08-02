# Marketing A/B Test: Ad Campaign Effectiveness & Exposure Optimization

## Overview
Analysis of a randomized marketing A/B test involving 588,101 users, split into an
**ad (treatment)** group and a **PSA/control** group, to determine whether ad exposure
drives a statistically significant lift in conversion — and to identify the ad
frequency at which returns start to diminish.

## Dataset
- 588,101 users (564,577 ad group / 23,524 PSA control group)
- Columns: user id, test group, converted (bool), total ads seen, most frequent
  exposure day, most frequent exposure hour
- Source: [Kaggle - Marketing A/B Testing](https://www.kaggle.com/datasets/faviovaz/marketing-ab-testing)
  (not included in this repo due to file size — download `marketing_AB.csv` from the
  link above and place it in the project root before running the queries)
- No missing values

## Methodology
1. **Loaded the dataset into MySQL** and wrote 6 SQL queries (`ab_test_queries.sql`)
   to aggregate conversion rate by test group, build the contingency table needed
   for significance testing, bucket users by ad exposure level, and summarize
   conversion by day/hour.
2. **Built an Excel workbook** (`AB_Test_Analysis.xlsx`) from the SQL query outputs,
   using live formulas to:
   - Calculate expected values and run a **Chi-Square Test of Independence**
     (`CHISQ.TEST`) to confirm the observed lift is statistically significant, not
     random chance
   - Calculate conversion rate and relative lift between groups
   - Build pivot tables and charts for the dose-response curve and day/hour timing
     patterns

## Key Findings

- **Ads drove a statistically significant lift in conversion.** The ad group converted
  at 2.55% vs. 1.79% for the PSA control group — a **43.1% relative lift**
  (Chi-Square Test, p = 1.7 x 10^-13), confirming the effect is real, not noise.

- **Conversion rises sharply with ad exposure, then plateaus and slightly declines
  past ~200 ads.** Conversion climbed from 0.25% (1-5 ads seen) to a peak of **17.7%
  at 101-200 ads**, then dipped to 15.6% beyond 200 - indicating a **saturation point**
  around 100-200 exposures, beyond which additional ad spend yields diminishing (and
  eventually negative) returns.

- **Converters were exposed to far more ads on average** (83.9 ads) than
  non-converters (23.3 ads), reinforcing the exposure-conversion relationship.

- **Monday (3.32%) and the 2-4 PM / 8-9 PM windows converted highest** among ad-exposed
  users, useful for scheduling future campaign delivery.

## Business Recommendation
Given the clear saturation point, campaigns should **cap ad frequency per user around
150-200 exposures** rather than maximizing raw ad volume — this captures nearly all
of the conversion lift while avoiding wasted spend on over-exposure. Scheduling
priority should favor Monday afternoons/evenings, where engagement is highest.

## Files
- `ab_test_queries.sql` — 6 SQL queries used to aggregate and prepare the data
- `AB_Test_Analysis.xlsx` — Excel workbook with live formulas (CHISQ.TEST for
  significance testing), pivot tables, and charts, built from the SQL query outputs

## Tools Used
SQL (MySQL) - Microsoft Excel (formulas, CHISQ.TEST, PivotTables, native charting)
