-- Q1: High-Value Customers with Multiple Products

WITH savings_customers AS (
    SELECT 
        owner_id,
        COUNT(*) AS savings_count,
        SUM(confirmed_amount) AS total_savings
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
investment_customers AS (
    SELECT 
        owner_id,
        COUNT(*) AS investment_count
    FROM plans_plan
    WHERE is_a_fund = 1
    GROUP BY owner_id
)
SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    s.savings_count,
    i.investment_count,
    ROUND(s.total_savings / 100, 2) AS total_deposits
FROM users_customuser u
JOIN savings_customers s ON u.id = s.owner_id
JOIN investment_customers i ON u.id = i.owner_id
ORDER BY total_deposits DESC;
