SELECT DISTINCT c.c_last_name, c.c_first_name, dd.d_date
FROM store_sales ss
JOIN customer c ON c.c_customer_sk = ss.ss_customer_sk
JOIN date_dim dd ON dd.d_date_sk = ss.ss_sold_date_sk
WHERE dd.d_year = <specified_year>
AND dd.d_month_seq >= <specified_month_sequence>
AND dd.d_month_seq < <specified_month_sequence> + 12
AND EXISTS (
    SELECT 1 FROM catalog_sales cs 
    WHERE cs.cs_bill_customer_sk = ss.ss_customer_sk
    AND cs.cs_sold_date_sk = ss.ss_sold_date_sk
)
AND EXISTS (
    SELECT 1 FROM web_sales ws 
    WHERE ws.ws_bill_customer_sk = ss.ss_customer_sk
    AND ws.ws_sold_date_sk = ss.ss_sold_date_sk
)
LIMIT 100;