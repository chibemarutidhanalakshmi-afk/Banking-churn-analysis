-- =====================================================================
-- BANK CUSTOMER CHURN ANALYSIS
-- =====================================================================
-- Project: Identifying high-risk customer segments in a retail bank
-- Dataset: 10,000 bank customers across France, Germany, and Spain
-- Author:  Maruthi Dhanalakshmi Chibe
-- Date:    May 2026
-- Tools:   SQLite, Power BI
-- 
-- Business Problem:
-- The bank wants to understand WHY customers are leaving and WHICH
-- segments are at highest risk, so retention efforts can be targeted
-- at the customers who matter most.
--
-- Key Finding:
-- Customers aged 50+ who are inactive members churn at 82% - that is
-- 12 times higher than active customers under 40. This single segment
-- should be the focus of any retention programme.
-- =====================================================================


-- =====================================================================
-- Q1: How many customers do we have in total?
-- =====================================================================
-- Business reason: Establish the size of our customer base before
-- calculating any percentages.

SELECT COUNT(CustomerId) AS total_customers
FROM Customers;

-- Result: 10,000 customers


-- =====================================================================
-- Q2: How many customers have churned (Exited = 1)?
-- =====================================================================
-- Business reason: Understand the absolute scale of the churn problem.

SELECT SUM(Exited) AS churned_customers
FROM Customers;

-- Result: 2,038 customers have left


-- =====================================================================
-- Q3: What is the overall churn rate?
-- =====================================================================
-- Business reason: A single headline metric the executive team can use
-- to benchmark performance over time.

SELECT 
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) AS overall_churn_rate_pct
FROM Customers;

-- Result: 20.38% - roughly 1 in 5 customers leave


-- =====================================================================
-- Q4: Which country has the highest churn rate?
-- =====================================================================
-- Business reason: Geographic patterns reveal whether the problem is
-- universal or specific to one market.

SELECT 
    Geography,
    COUNT(CustomerId) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) AS churn_rate_pct
FROM Customers
GROUP BY Geography
ORDER BY churn_rate_pct DESC;

-- Result:
-- Germany: 32.44% (twice the rate of France and Spain)
-- Spain:   16.67%
-- France:  16.17%
-- Insight: Germany needs a dedicated retention strategy


-- =====================================================================
-- Q5: Does churn differ by gender?
-- =====================================================================
-- Business reason: Identify whether marketing or product offerings need
-- to be tailored to a specific demographic.

SELECT 
    Gender,
    COUNT(CustomerId) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) AS churn_rate_pct
FROM Customers
GROUP BY Gender
ORDER BY churn_rate_pct DESC;

-- Result:
-- Female: 25.07%
-- Male:   16.47%
-- Insight: Female customers leave at 1.5x the rate of male customers


-- =====================================================================
-- Q6: Which age group has the highest churn? (HEADLINE FINDING)
-- =====================================================================
-- Business reason: Age is one of the strongest predictors in banking.
-- Knowing which age group is leaving lets us design targeted retention.

SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age < 40 THEN '30-40'
        WHEN Age < 50 THEN '40-50'
        ELSE '50+'
    END AS age_group,
    COUNT(CustomerId) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) AS churn_rate_pct
FROM Customers
GROUP BY age_group
ORDER BY churn_rate_pct DESC;

-- Result:
-- 50+:      45.48%
-- 40-50:    30.83%
-- 30-40:    10.88%
-- Under 30:  7.56%
-- Insight: Churn rises sharply with age - 50+ customers leave at 6x the
-- rate of under-30s. The bank is failing older customers.


-- =====================================================================
-- Q7: Are inactive members more likely to leave?
-- =====================================================================
-- Business reason: Activity is something the bank CAN influence -
-- if inactive customers leave more, engagement campaigns make sense.

SELECT 
    CASE 
        WHEN IsActiveMember = 1 THEN 'Active' 
        ELSE 'Inactive' 
    END AS activity_status,
    COUNT(CustomerId) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) AS churn_rate_pct
FROM Customers
GROUP BY IsActiveMember
ORDER BY churn_rate_pct DESC;

-- Result:
-- Inactive: 26.87%
-- Active:   14.27%
-- Insight: Inactive customers churn at nearly 2x the rate. Engagement
-- programmes (notifications, offers, check-ins) could reduce churn.


-- =====================================================================
-- Q8: Does the number of products affect churn? (SHOCK FINDING)
-- =====================================================================
-- Business reason: Cross-selling is supposed to increase retention.
-- Testing whether more products actually keep customers.

SELECT 
    NumOfProducts,
    COUNT(CustomerId) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) AS churn_rate_pct
FROM Customers
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- Result:
-- 1 product:  27.71%
-- 2 products:  7.60%  (sweet spot)
-- 3 products: 82.71%
-- 4 products: 100.00% (all 60 customers with 4 products left)
-- Insight: Counter-intuitive - customers with 3+ products are far more
-- likely to leave. Possible reasons: over-selling, complexity, hidden
-- fees, or these are dissatisfied customers given products as retention
-- attempts that didn't work. Requires deeper investigation.


-- =====================================================================
-- Q9: Does having a credit card reduce churn?
-- =====================================================================
-- Business reason: Tests whether the credit card product is actually
-- a "sticky" product that improves retention.

SELECT 
    CASE 
        WHEN HasCrCard = 1 THEN 'Has Credit Card' 
        ELSE 'No Credit Card' 
    END AS card_status,
    COUNT(CustomerId) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) AS churn_rate_pct
FROM Customers
GROUP BY HasCrCard;

-- Result:
-- Has Credit Card: 20.18%
-- No Credit Card:  20.81%
-- Insight: Credit cards make almost no difference to churn (negative
-- finding - still valuable, saves the bank from investing in card
-- promotions as a retention tactic).


-- =====================================================================
-- Q10: Are we losing high-value customers?
-- =====================================================================
-- Business reason: Churn is much worse if the leavers are the wealthy
-- customers. Compare average balance of leavers vs stayers.

SELECT 
    CASE 
        WHEN Exited = 1 THEN 'Left the bank' 
        ELSE 'Stayed' 
    END AS customer_status,
    COUNT(CustomerId) AS total_customers,
    ROUND(AVG(Balance), 2) AS average_balance
FROM Customers
GROUP BY Exited;

-- Result:
-- Left the bank: £91,108 average balance
-- Stayed:        £72,743 average balance
-- Insight: Customers who LEFT had 25% higher balances on average.
-- The bank is losing its most valuable customers - urgent priority.


-- =====================================================================
-- Q11: COMBINED RISK SEGMENT - the headline finding
-- =====================================================================
-- Business reason: Single variables show patterns, but combining
-- Age + Activity reveals the bank's actual high-risk segment.
-- This is the segment retention budget should target.

SELECT 
    CASE 
        WHEN Age >= 50 AND IsActiveMember = 0 THEN '50+ Inactive'
        WHEN Age >= 50 AND IsActiveMember = 1 THEN '50+ Active'
        WHEN Age < 40 AND IsActiveMember = 0 THEN 'Under 40 Inactive'
        WHEN Age < 40 AND IsActiveMember = 1 THEN 'Under 40 Active'
        ELSE '40-50'
    END AS risk_segment,
    COUNT(CustomerId) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) AS churn_rate_pct
FROM Customers
GROUP BY risk_segment
ORDER BY churn_rate_pct DESC;

-- Result:
-- 50+ Inactive:       82.23%  <-- HIGHEST RISK SEGMENT
-- 50+ Active:         42.31%
-- 40-50:              30.83%
-- Under 40 Inactive:  11.97%
-- Under 40 Active:     7.04%

-- KEY INSIGHT:
-- The bank's high-risk segment is customers aged 50+ who are inactive
-- members - they churn at 82% (12x the rate of active under-40s).
-- 
-- Recommendation: A dedicated re-engagement campaign for inactive 50+
-- customers (personalised outreach, in-branch appointments, simplified
-- digital onboarding) could meaningfully reduce overall churn.


-- =====================================================================
-- BONUS: Window function - customer ranking by balance within country
-- =====================================================================
-- Business reason: Identifies the top customers per country, useful
-- for relationship management and tailored retention offers.

SELECT 
    CustomerId,
    Geography,
    Balance,
    RANK() OVER (PARTITION BY Geography ORDER BY Balance DESC) AS balance_rank_in_country
FROM Customers
WHERE Balance > 0
ORDER BY Geography, balance_rank_in_country
LIMIT 30;


-- =====================================================================
-- END OF ANALYSIS
-- =====================================================================
-- All findings visualised in: Banking_Churn_Dashboard.pbix
-- Dashboard pages: Executive Summary, Detailed Analysis
-- =====================================================================
