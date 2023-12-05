WITH year_total AS (
  SELECT
    c_customer_id,
    STDDEV_POP(ss_net_paid) AS store_sales_std_dev,
    STDDEV_POP(ws_net_paid) AS web_sales_std_dev
  FROM
    customer c
    JOIN store_sales ss ON ss.ss_customer_sk = c.c_customer_sk
    JOIN web_sales ws ON ws.ws_bill_customer_sk = c.c_customer_sk
    JOIN date_dim d ON d.d_date_sk = ss.ss_sold_date_sk
      AND d.d_date_sk = ws.ws_sold_date_sk
  WHERE
    d.d_year IN (1999, 2000)
  GROUP BY
    c_customer_id
)
SELECT
  c.c_customer_id,
  c.c_first_name,
  c.c_last_name
FROM
  customer c
  JOIN year_total yt ON yt.c_customer_id = c.c_customer_id
WHERE
  EXISTS (
    SELECT 1
    FROM year_total yt2
    WHERE yt2.c_customer_id = yt.c_customer_id
      AND yt2.store_sales_std_dev > 0
      AND yt2.web_sales_std_dev > 0
      AND yt2.store_sales_std_dev > yt.store_sales_std_dev
      AND yt2.web_sales_std_dev > yt.web_sales_std_dev
  )
ORDER BY
  c.c_first_name,
  c.c_customer_id,
  c.c_last_name
LIMIT 100;