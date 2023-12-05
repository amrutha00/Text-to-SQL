SELECT 
    w.w_warehouse_name AS warehouse_name,
    w.w_warehouse_sq_ft AS warehouse_sq_ft,
    w.w_city AS city,
    w.w_county AS county,
    w.w_state AS state,
    w.w_country AS country,
    SUM(CASE WHEN MONTH(ws_sold_date) = 1 THEN ws_sales_price ELSE 0 END) AS january_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 1 THEN ws_net_profit ELSE 0 END) AS january_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 2 THEN ws_sales_price ELSE 0 END) AS february_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 2 THEN ws_net_profit ELSE 0 END) AS february_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 3 THEN ws_sales_price ELSE 0 END) AS march_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 3 THEN ws_net_profit ELSE 0 END) AS march_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 4 THEN ws_sales_price ELSE 0 END) AS april_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 4 THEN ws_net_profit ELSE 0 END) AS april_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 5 THEN ws_sales_price ELSE 0 END) AS may_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 5 THEN ws_net_profit ELSE 0 END) AS may_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 6 THEN ws_sales_price ELSE 0 END) AS june_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 6 THEN ws_net_profit ELSE 0 END) AS june_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 7 THEN ws_sales_price ELSE 0 END) AS july_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 7 THEN ws_net_profit ELSE 0 END) AS july_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 8 THEN ws_sales_price ELSE 0 END) AS august_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 8 THEN ws_net_profit ELSE 0 END) AS august_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 9 THEN ws_sales_price ELSE 0 END) AS september_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 9 THEN ws_net_profit ELSE 0 END) AS september_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 10 THEN ws_sales_price ELSE 0 END) AS october_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 10 THEN ws_net_profit ELSE 0 END) AS october_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 11 THEN ws_sales_price ELSE 0 END) AS november_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 11 THEN ws_net_profit ELSE 0 END) AS november_net_profit,
    SUM(CASE WHEN MONTH(ws_sold_date) = 12 THEN ws_sales_price ELSE 0 END) AS december_sales,
    SUM(CASE WHEN MONTH(ws_sold_date) = 12 THEN ws_net_profit ELSE 0 END) AS december_net_profit
FROM 
    web_sales AS ws
JOIN 
    warehouse AS w ON ws.ws_warehouse_sk = w.w_warehouse_sk
JOIN 
    ship_mode AS sm ON ws.ws_ship_mode_sk = sm.sm_ship_mode_sk
JOIN 
    date_dim AS d ON ws.ws_sold_date_sk = d.d_date_sk
WHERE 
    d.d_year = 1998 
    AND ws_sold_time_sk >= 48821 
    AND ws_sold_time_sk <= (48821 + 28800)
    AND (sm.sm_carrier = 'GREAT EASTERN' OR sm.sm_carrier = 'LATVIAN')
GROUP BY 
    w.w_warehouse_name,
    w.w_warehouse_sq_ft,
    w.w_city,
    w.w_county,
    w.w_state,
    w.w_country
ORDER BY 
    w.w_warehouse_name
LIMIT 100;