WITH first_purchase AS (
    SELECT
        c.customer_unique_id,
        DATE_TRUNC('month', MIN(o.order_purchase_timestamp)) AS cohort_month
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
monthly_activity AS (
    SELECT
        c.customer_unique_id,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS activity_month
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
)
SELECT
    f.cohort_month,
    DATE_PART('month', AGE(m.activity_month, f.cohort_month)) AS months_since_first,
    COUNT(DISTINCT m.customer_unique_id)                        AS active_customers
FROM first_purchase f
JOIN monthly_activity m ON f.customer_unique_id = m.customer_unique_id
GROUP BY f.cohort_month, months_since_first
ORDER BY f.cohort_month, months_since_first;