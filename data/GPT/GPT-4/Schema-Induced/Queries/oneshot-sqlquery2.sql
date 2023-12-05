SELECT 
    d_week_seq AS week_sequence,
    d_day_name AS day_of_week,
    (SUM(ws_sales_price) / SUM(LAG(ws_sales_price) OVER (PARTITION BY d_day_name ORDER BY d_week_seq))) AS sales_increase_ratio
FROM 
    web_sales
JOIN date_dim ON ws_sold_date_sk = d_date_sk
WHERE 
    d_year = (SELECT MAX(d_year) FROM date_dim) - 1
GROUP BY 
    week_sequence, day_of_week
ORDER BY 
    week_sequence ASC;