WITH ss AS (
    SELECT ca.ca_county, SUBSTRING(d.d_quarter_name, 1, INSTR(d.d_quarter_name, ' ')-1) AS quarter, d.d_year,
           SUM(s.ss_ext_sales_price) AS store_sales
    FROM store_sales s
    JOIN customer_address ca ON s.ss_addr_sk = ca.ca_address_sk
    JOIN date_dim d ON s.ss_sold_date_sk = d.d_date_sk
    WHERE d.d_year = 2000
    GROUP BY ca.ca_county, quarter, d_year
), ws AS (
    SELECT ca.ca_county, SUBSTRING(d.d_quarter_name, 1, INSTR(d.d_quarter_name, ' ')-1) AS quarter, d.d_year,
           SUM(w.ws_ext_sales_price) AS web_sales
    FROM web_sales w
    JOIN customer_address ca ON w.ws_bill_addr_sk = ca.ca_address_sk
    JOIN date_dim d ON w.ws_sold_date_sk = d.d_date_sk
    WHERE d.d_year = 2000
    GROUP BY ca.ca_county, quarter, d_year
)
SELECT ws.ca_county, ws.d_year, ws.quarter,
       CASE 
           WHEN ss.store_sales > 0 AND ws.web_sales > 0 THEN (ws.web_sales - ss.store_sales) / ss.store_sales
           ELSE NULL
       END AS web_q1_q2_increase
FROM ws
JOIN ss ON ws.ca_county = ss.ca_county AND ws.quarter = ss.quarter AND ws.d_year = ss.d_year
WHERE ws.quarter IN ('Q1', 'Q2', 'Q3')
ORDER BY web_q1_q2_increase DESC
LIMIT 100;