WITH rfm_base AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp)              AS last_order_date,
        COUNT(DISTINCT o.order_id)                   AS frequency,
        ROUND(SUM(p.payment_value)::NUMERIC, 2)      AS monetary
    FROM customers c
    JOIN orders o         ON c.customer_id = o.customer_id
    JOIN order_payments p ON o.order_id    = p.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    SELECT *,
        DATE_PART('day',
            (SELECT MAX(order_purchase_timestamp) FROM orders) - last_order_date
        )                                               AS recency_days,
        NTILE(4) OVER (ORDER BY last_order_date DESC)   AS r_score,
        NTILE(4) OVER (ORDER BY frequency ASC)          AS f_score,
        NTILE(4) OVER (ORDER BY monetary ASC)           AS m_score
    FROM rfm_base
)
SELECT
    customer_unique_id,
    recency_days,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    CASE
        WHEN r_score = 4 AND f_score >= 3 AND m_score >= 3 THEN 'Gold'
        WHEN r_score >= 3 AND f_score >= 2                  THEN 'Silver'
        WHEN r_score = 1 OR  f_score = 1                    THEN 'At-Risk'
        ELSE                                                     'Bronze'
    END AS rfm_segment
FROM rfm_scores
ORDER BY monetary DESC;