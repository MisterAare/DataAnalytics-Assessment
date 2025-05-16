-- Q2: Transaction Frequency Analysis
-- NOTE: Replace `transaction_date` with the actual date column in savings_savingsaccount

WITH monthly_transactions AS (
    SELECT 
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS month,
        COUNT(*) AS monthly_txn_count
    FROM savings_savingsaccount
    WHERE transaction_date IS NOT NULL
    GROUP BY owner_id, month
),
avg_txn_per_customer AS (
    SELECT 
        owner_id,
        AVG(monthly_txn_count) AS avg_transactions_per_month
    FROM monthly_transactions
    GROUP BY owner_id
)
SELECT 
    CASE
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM avg_txn_per_customer
GROUP BY frequency_category;