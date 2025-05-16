-- Q4: Customer Lifetime Value (CLV) Estimation

WITH transaction_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure AS (
    SELECT 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
)
SELECT 
    t.customer_id,
    t.name,
    t.tenure_months,
    ts.total_transactions,
    ROUND((ts.total_transactions / t.tenure_months) * 12 * (ts.total_value / ts.total_transactions / 1000), 2) AS estimated_clv
FROM tenure t
JOIN transaction_summary ts ON t.customer_id = ts.owner_id
WHERE t.tenure_months > 0
ORDER BY estimated_clv DESC;
