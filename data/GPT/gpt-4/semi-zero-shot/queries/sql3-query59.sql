SELECT
    s_store_name,
    s_store_id,
    dt_week_seq AS week_number,
    SUM(CASE WHEN dt.d_year = 1197 THEN ws.ws_sales ELSE 0 END) -
    SUM(CASE WHEN dt.d_year = 1196 THEN ws.ws_sales ELSE 0 END) AS sales_increase
FROM
    store AS s
JOIN
    web_sales AS ws
ON
    s.s_store_sk = ws.ws_store_sk
JOIN
    date_dim AS dt
ON
    ws.ws_sold_date_sk = dt.d_date_sk
WHERE
    dt.d_year IN (1196, 1197)
GROUP BY
    s.s_store_name,
    s.s_store_id,
    dt.dt_week_seq
HAVING
    sales_increase IS NOT NULL
ORDER BY
    sales_increase DESC
LIMIT 100;
