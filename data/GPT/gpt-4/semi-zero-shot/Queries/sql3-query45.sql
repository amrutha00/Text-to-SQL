SELECT
    c_customer_id,
    c_first_name,
    c_current_addr_sk,
    SUM(ws_sales_price) AS total_web_sales
FROM
    customer c
INNER JOIN
    web_sales ws ON c.c_customer_sk = ws.c_customer_sk
INNER JOIN
    date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
WHERE
    (d.d_year = 2000 AND d.d_qoy = 2)
    AND (c_current_addr_sk IN (SELECT ca_address_sk
                               FROM customer_address
                               WHERE ca_address_sk IN (85669, 86197, 88274, 83405, 86475, 85392, 85460, 80348, 81792)))
GROUP BY
    c_current_addr_sk, c_customer_id, c_first_name
ORDER BY
    c_current_addr_sk, c_first_name
LIMIT 100;
