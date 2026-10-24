-- Maven B2B CRM Sales Pipeline Analytics
-- Relational Queries by Vansh Tanwar

-- 1. Product Win/Loss Rates & Closed Revenue

SELECT 
    product,
    COUNT(opportunity_id) AS total_deals,
    SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS won_deals,
    SUM(CASE WHEN deal_stage = 'Lost' THEN 1 ELSE 0 END) AS lost_deals,
    ROUND(SUM(close_value), 2) AS total_revenue
FROM sales_pipeline
GROUP BY product
ORDER BY total_revenue DESC;


-- 2. Top Sales Rep Leaderboard using DENSE_RANK() Window Function

SELECT 
    sales_agent,
    COUNT(opportunity_id) AS deals_handled,
    SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS deals_won,
    ROUND(SUM(close_value), 2) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(close_value) DESC) AS rank
FROM sales_pipeline
GROUP BY sales_agent
ORDER BY rank
LIMIT 10;

