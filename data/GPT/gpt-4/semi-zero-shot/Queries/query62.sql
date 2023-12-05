WITH Time_Categorized AS (
    SELECT 
        w_warehouse_name, 
        ws_ship_mode_sk, 
        ws_web_site_sk, 
        CASE 
            WHEN datediff(day, ws_sold_date_sk, ws_ship_date_sk) <= 30 THEN '0-30 days'
            WHEN datediff(day, ws_sold_date_sk, ws_ship_date_sk) BETWEEN 31 AND 60 THEN '31-60 days'
            WHEN datediff(day, ws_sold_date_sk, ws_ship_date_sk) BETWEEN 61 AND 90 THEN '61-90 days'
            WHEN datediff(day, ws_sold_date_sk, ws_ship_date_sk) BETWEEN 91 AND 120 THEN '91-120 days'
            ELSE 'Over 120 days'
        END AS shipping_time_category
    FROM web_sales
    JOIN warehouse ON ws_warehouse_sk = w_warehouse_sk
    WHERE ws_sold_year = 1194
)

SELECT 
    w_warehouse_name,
    sm.sm_type AS shipping_mode,
    ws.web_site_name,
    shipping_time_category,
    COUNT(*) AS order_count
FROM Time_Categorized tc
JOIN ship_mode sm ON tc.ws_ship_mode_sk = sm.sm_ship_mode_sk
JOIN web_site ws ON tc.ws_web_site_sk = ws.web_site_sk
GROUP BY 
    w_warehouse_name, 
    sm.sm_type, 
    ws.web_site_name, 
    shipping_time_category
ORDER BY 
    w_warehouse_name ASC, 
    sm.sm_type ASC, 
    ws.web_site_name ASC
LIMIT 100;
