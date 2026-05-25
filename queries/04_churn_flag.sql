WITH orders_2017 AS (
    SELECT DISTINCT c.customer_unique_id
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE DATE_PART('year', o.order_purchase_timestamp) = 2017
      AND o.order_status = 'delivered'
),
orders_2018 AS (
    SELECT DISTINCT c.customer_unique_id
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE DATE_PART('year', o.order_purchase_timestamp) = 2018
      AND o.order_status = 'delivered'
)
SELECT
    a.customer_unique_id,
    'Churned' AS customer_status
FROM orders_2017 a
LEFT JOIN orders_2018 b ON a.customer_unique_id = b.customer_unique_id
WHERE b.customer_unique_id IS NULL;