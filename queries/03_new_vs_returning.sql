WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_purchase_timestamp,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        ) AS order_rank
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
)
SELECT
    order_month,
    COUNT(CASE WHEN order_rank = 1 THEN 1 END)  AS new_customers,
    COUNT(CASE WHEN order_rank > 1 THEN 1 END)  AS returning_customers
FROM customer_orders
GROUP BY order_month
ORDER BY order_month;