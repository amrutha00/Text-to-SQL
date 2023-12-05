SELECT
    i.item_id,
    SUM(s.sales_amount) AS total_sales_amount
FROM
    date_dim d
    JOIN store_sales s ON d.date_sk = s.date_sk
    JOIN customer_address ca ON s.cust_id = ca.cust_id
    JOIN item i ON s.item_id = i.i_item_id
WHERE
    d.d_year = 2000
    AND d.d_month = 8
    AND ca.ca_gmt_offset = -7
    AND i.i_category = 'Children'
GROUP BY
    i.item_id
ORDER BY
    i.item_id,
    total_sales_amount DESC
LIMIT 100;
