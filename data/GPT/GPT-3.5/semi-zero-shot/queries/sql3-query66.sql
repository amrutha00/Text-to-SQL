SELECT
    w.w_warehouse_name AS warehouse_name,
    w.w_square_feet AS square_footage,
    w.w_city AS city,
    w.w_county AS county,
    w.w_state AS state,
    w.w_country AS country,
    EXTRACT(MONTH FROM s.ws_sold_date_sk) AS month,
    SUM(CASE WHEN s.ws_ship_carrier IN ('GREAT EASTERN', 'LATVIAN') THEN s.ws_net_profit ELSE 0 END) AS profit,
    SUM(CASE WHEN s.ws_ship_carrier IN ('GREAT EASTERN', 'LATVIAN') THEN s.ws_sales_price ELSE 0 END) AS sales
FROM
    store_sales AS s
JOIN
    warehouse AS w ON s.ws_warehouse_sk = w.w_warehouse_sk
WHERE
    s.ws_sold_date_sk BETWEEN 48821 AND (48821 + 28800)
    AND EXTRACT(YEAR FROM s.ws_sold_date_sk) = 1998
GROUP BY
    w.w_warehouse_name,
    w.w_square_feet,
    w.w_city,
    w.w_county,
    w.w_state,
    w.w_country,
    EXTRACT(MONTH FROM s.ws_sold_date_sk)
ORDER BY
    w.w_warehouse_name,
    EXTRACT(MONTH FROM s.ws_sold_date_sk)
LIMIT 100;
