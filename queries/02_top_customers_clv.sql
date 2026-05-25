SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id)                   AS total_orders,
    ROUND(SUM(p.payment_value)::NUMERIC, 2)      AS lifetime_value,
    ROUND(AVG(p.payment_value)::NUMERIC, 2)      AS avg_order_value
FROM customers c
JOIN orders o         ON c.customer_id = o.customer_id
JOIN order_payments p ON o.order_id    = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY lifetime_value DESC
LIMIT 20;