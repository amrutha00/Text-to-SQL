SELECT
    ROUND(SUM(ws_ext_sales_price) / 50) * 50 AS revenue_segment,
    COUNT(DISTINCT c_customer_sk) AS num_customers
FROM
    customer AS c
    JOIN web_sales AS ws ON c.c_customer_sk = ws.ws_bill_customer_sk
    JOIN date_dim AS dd ON ws.ws_sold_date_sk = dd.d_date_sk
    JOIN item AS i ON ws.ws_item_sk = i.i_item_sk
    JOIN <tableName>customer_address</tableName> AS ca ON c.c_current_addr_sk = ca.ca_address_sk
    JOIN store AS s ON (ca.ca_city = s.s_city AND ca.ca_state = s.s_state)
WHERE
    i.i_category = 'Women'
    AND i.i_class = 'maternity'
    AND dd.d_year = 1998
    AND dd.d_month_seq >= (SELECT d_month_seq FROM date_dim WHERE d_year = 1998 AND d_month_name = 'May')
    AND dd.d_month_seq <= (SELECT d_month_seq + 2 FROM date_dim WHERE d_year = 1998 AND d_month_name = 'May')
GROUP BY
    revenue_segment
ORDER BY
    revenue_segment;