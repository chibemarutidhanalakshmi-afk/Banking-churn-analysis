# Bank Customer Churn Analysis

**SQL + Power BI portfolio project — identifying the highest-risk customer segment in a retail bank**

---

## Project Overview

A retail bank with 10,000 customers across France, Germany, and Spain is losing 1 in 5 customers per year. This project answers three questions the executive team needs to know:

1. **Who** is leaving?
2. **Why** are they leaving?
3. **Where** should retention budget be spent first?

The analysis uses SQL to investigate the data and Power BI to communicate the findings to a business audience.

---

## Headline Finding

**Customers aged 50+ who are inactive members churn at 82.23%.**

That is 12 times higher than active customers under 40 (7.04%). A dedicated re-engagement campaign for this segment is the single highest-impact retention opportunity the bank has.

---

## Key Insights

| Metric | Result | Insight |
|--------|--------|---------|
| Overall churn rate | 20.38% | 1 in 5 customers leave |
| Germany churn rate | 32.44% | Twice the rate of France and Spain |
| 50+ age group | 45.48% | 6x higher than under-30s |
| 50+ Inactive segment | 82.23% | Highest-risk segment — focus retention here |
| Avg balance of leavers | £91,108 | 25% higher than stayers (£72,743) |
| Customers with 3+ products | 82-100% | Counter-intuitive — needs investigation |

---

## Tools Used

- **SQL (SQLite)** — data exploration, aggregation, CASE statements, window functions
- **Power BI Desktop** — interactive dashboard with two pages (Executive Summary + Detailed Analysis)
- **DAX** — calculated measures including dynamic churn rate and risk-segment formulas

---

## Repository Contents

| File | Description |
|------|-------------|
| `banking_queries.sql` | All 11 analysis queries, fully commented with business reasoning |
| `Banking_Churn_Dashboard.pbix` | Interactive Power BI dashboard (open in Power BI Desktop) |
| `Banking_Churn_Dashboard.pdf` | PDF export of both dashboard pages |
| `customers.csv` | Source dataset (10,000 rows) |
| `screenshots/` | Dashboard preview images |

---

## Dashboard Preview

**Executive Summary Page** — high-level KPIs and headline finding for senior stakeholders

**Detailed Analysis Page** — five supporting charts showing churn by country, gender, age group, activity status, and number of products

(See PDF export in this repo for full visuals.)

---

## Recommendations to the Bank

1. **Launch a 50+ Inactive re-engagement campaign** — personalised outreach, in-branch appointments, simplified digital onboarding. This single segment has the highest concentration of preventable churn.
2. **Investigate Germany separately** — its 32% churn rate suggests market-specific issues (pricing, competition, or service) that the France/Spain operation does not face.
3. **Audit the 3+ products segment** — 82% of customers with 3 products and 100% with 4 products are leaving. This may indicate over-selling, hidden fees, or failed retention attempts.
4. **Deprioritise credit card promotion as a retention tool** — having a credit card makes no measurable difference to churn (20.18% vs 20.81%).

---

## About Me

**Maruthi Dhanalakshmi Chibe** — MSc Artificial Intelligence and Machine Learning (University of East London, industrial placement year 2025–2027). Available immediately for UK data analyst placements.

- **LinkedIn:** [maruthidhanalakshmi-chibe-528a9a341](https://www.linkedin.com/in/maruthidhanalakshmi-chibe-528a9a341)
- **GitHub:** [chibemarutidhanalakshmi-afk](https://github.com/chibemarutidhanalakshmi-afk)
- **Email:** chibemarutidhanalakshmi@gmail.com

---

*Project completed: May 2026. Dataset: Bank Customer Churn (publicly available on Kaggle).*
