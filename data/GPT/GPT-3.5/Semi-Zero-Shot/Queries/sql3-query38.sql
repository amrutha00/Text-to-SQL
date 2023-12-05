SELECT DISTINCT c.c_last_name, c.c_first_name, d.d_date
FROM customer c
JOIN store_sales ss ON c.c_customer_sk = ss.ss_customer_sk
JOIN catalog_sales cs ON c.c_customer_sk = cs.cs_bill_customer_sk
JOIN web_sales ws ON c.c_customer_sk = ws.ws_bill_customer_sk
JOIN date_dim d ON (ss.ss_sold_date_sk = d.d_date_sk
                    OR cs.cs_sold_date_sk = d.d_date_sk
                    OR ws.ws_sold_date_sk = d.d_date_sk)
WHERE d.d_year = specified_year
  AND d.d_moy BETWEEN specified_month_start AND specified_month_end
LIMIT 100;
