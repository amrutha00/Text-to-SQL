SELECT
    COUNT(DISTINCT ws.ws_order_number) AS web_sales_count,
    SUM(ws.ws_ship_cost) AS total_shipping_cost,
    SUM(ws.ws_net_profit) AS net_profit
FROM
    web_sales ws
JOIN
    web_returns wr ON ws.ws_order_number = wr.wr_order_number
JOIN
    customer c ON ws.ws_ship_customer_sk = c.c_customer_sk
JOIN
    date_dim dd ON ws.ws_ship_date_sk = dd.d_date_sk
JOIN
    warehouse w ON ws.ws_warehouse_sk = w.w_warehouse_sk
WHERE
    c.c_state = 'NC' -- Customers residing in North Carolina
    AND ws.ws_web_site = 'pri' -- Orders from the "pri" website
    AND dd.d_date BETWEEN [start_date] AND [end_date] -- Replace [start_date] and [end_date] with the specific 60-day period
GROUP BY
    ws.ws_order_number
HAVING
    COUNT(DISTINCT w.w_warehouse_sk) > 1 -- Orders associated with more than one warehouse
ORDER BY
    web_sales_count DESC
LIMIT 100; -- Limit to 100 results
