WITH CustomersFromAllChannels AS (
    SELECT ss.ss_customer_sk AS customer_sk
    FROM store_sales ss
    JOIN date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk
    WHERE dd.d_year = ? AND dd.d_moy BETWEEN ? AND ?
    INTERSECT
    SELECT cs.cs_customer_sk AS customer_sk
    FROM catalog_sales cs
    JOIN date_dim dd ON cs.cs_sold_date_sk = dd.d_date_sk
    WHERE dd.d_year = ? AND dd.d_moy BETWEEN ? AND ?
    INTERSECT
    SELECT ws.ws_customer_sk AS customer_sk
    FROM web_sales ws
    JOIN date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk
    WHERE dd.d_year = ? AND dd.d_moy BETWEEN ? AND ?
)

SELECT DISTINCT c.c_last_name, c.c_first_name, dd.d_date
FROM CustomersFromAllChannels cfac
JOIN customer c ON cfac.customer_sk = c.c_customer_sk
JOIN date_dim dd ON dd.d_year = ? AND dd.d_moy BETWEEN ? AND ?
LIMIT 100;
