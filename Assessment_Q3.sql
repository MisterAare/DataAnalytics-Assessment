WITH savings_activity AS (
    SELECT 
        id AS plan_id,
        owner_id,
        'Savings' AS type,
        MAX(created_on) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY id, owner_id
),
investment_activity AS (
    SELECT 
        id AS plan_id,
        owner_id,
        'Investment' AS type,
        MAX(created_on) AS last_transaction_date
    FROM plans_plan
    GROUP BY id, owner_id
),
all_activity AS (
    SELECT * FROM savings_activity
    UNION
    SELECT * FROM investment_activity
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
FROM all_activity
WHERE last_transaction_date < CURDATE() - INTERVAL 365 DAY;
