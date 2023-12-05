SELECT
    s.store_id,
    c.customer_id,
    COUNT(s.sale_id) AS sales_count
FROM
    sales s
JOIN
    customers c ON s.customer_id = c.customer_id
JOIN
    stores st ON s.store_id = st.store_id
WHERE
    st.store_name = 'ese'
    AND c.number_of_dependents = 3
    AND EXTRACT(HOUR FROM TO_TIMESTAMP(s.sale_time, 'HH24:MI')) = 8
    AND EXTRACT(MINUTE FROM TO_TIMESTAMP(s.sale_time, 'HH24:MI')) >= 30
GROUP BY
    s.store_id,
    c.customer_id
ORDER BY
    sales_count DESC
LIMIT 100;
