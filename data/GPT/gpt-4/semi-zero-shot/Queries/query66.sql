WITH MonthlySales AS (
    SELECT 
        ws_warehouse_sk,
        EXTRACT(MONTH FROM ws_sold_date_sk) AS sale_month,
        SUM(ws_net_profit) AS monthly_net_profit,
        SUM(ws_ext_sales_price) AS monthly_sales
    FROM web_sales
    WHERE ws_sold_time_sk BETWEEN 48821 AND 51621
        AND ws_ship_carrier_sk IN (SELECT sc_ship_carrier_sk FROM ship_carrier WHERE sc_carrier_name IN ('GREAT EASTERN', 'LATVIAN'))
    GROUP BY ws_warehouse_sk, EXTRACT(MONTH FROM ws_sold_date_sk)

    UNION ALL

    SELECT 
        cs_warehouse_sk,
        EXTRACT(MONTH FROM cs_sold_date_sk) AS sale_month,
        SUM(cs_net_profit) AS monthly_net_profit,
        SUM(cs_ext_sales_price) AS monthly_sales
    FROM catalog_sales
    WHERE cs_sold_time_sk BETWEEN 48821 AND 51621
        AND cs_ship_carrier_sk IN (SELECT sc_ship_carrier_sk FROM ship_carrier WHERE sc_carrier_name IN ('GREAT EASTERN', 'LATVIAN'))
    GROUP BY cs_warehouse_sk, EXTRACT(MONTH FROM cs_sold_date_sk)
)

SELECT 
    w.w_warehouse_name,
    w.w_warehouse_sq_ft,
    w.w_city,
    w.w_county,
    w.w_state,
    w.w_country,
    COALESCE(SUM(CASE WHEN ms.sale_month = 1 THEN ms.monthly_sales ELSE 0 END), 0) AS "January Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 1 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "January Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 2 THEN ms.monthly_sales ELSE 0 END), 0) AS "February Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 2 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "February Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 3 THEN ms.monthly_sales ELSE 0 END), 0) AS "March Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 3 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "March Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 4 THEN ms.monthly_sales ELSE 0 END), 0) AS "April Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 4 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "April Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 5 THEN ms.monthly_sales ELSE 0 END), 0) AS "May Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 5 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "May Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 6 THEN ms.monthly_sales ELSE 0 END), 0) AS "June Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 6 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "June Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 7 THEN ms.monthly_sales ELSE 0 END), 0) AS "July Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 7 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "July Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 8 THEN ms.monthly_sales ELSE 0 END), 0) AS "August Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 8 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "August Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 9 THEN ms.monthly_sales ELSE 0 END), 0) AS "September Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 9 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "September Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 10 THEN ms.monthly_sales ELSE 0 END), 0) AS "October Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 10 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "October Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 11 THEN ms.monthly_sales ELSE 0 END), 0) AS "November Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 11 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "November Net Profit",
    COALESCE(SUM(CASE WHEN ms.sale_month = 12 THEN ms.monthly_sales ELSE 0 END), 0) AS "December Sales",
    COALESCE(SUM(CASE WHEN ms.sale_month = 12 THEN ms.monthly_net_profit ELSE 0 END), 0) AS "December Net Profit"
FROM warehouse w
LEFT JOIN MonthlySales ms ON w.w_warehouse_sk = ms.ws_warehouse_sk
GROUP BY 
    w.w_warehouse_name,
    w.w_warehouse_sq_ft,
    w.w_city,
    w.w_county,
    w.w_state,
    w.w_country
ORDER BY w.w_warehouse_name
LIMIT 100;
