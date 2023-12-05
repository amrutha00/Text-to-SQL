SELECT COUNT(DISTINCT ws.ws_order_number) AS web_sales_count, 
       SUM(ws.ws_ext_ship_cost) AS total_shipping_cost, 
       SUM(ws.ws_net_profit) AS net_profit
FROM web_sales ws
JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
JOIN customer_address ca ON ws.ws_ship_addr_sk = ca.ca_address_sk
JOIN web_site web ON ws.ws_web_site_sk = web.web_site_sk
JOIN ws_wh wh ON ws.ws_order_number = wh.ws_order_number
WHERE ws.ws_order_number IN (
    SELECT DISTINCT ws_ws_order_number
    FROM web_sales
    WHERE ws_ship_date_sk BETWEEN (SELECT d_date_sk
                                   FROM date_dim
                                   WHERE d_date = '2010-01-01') AND (SELECT d_date_sk
                                                                   FROM date_dim
                                                                   WHERE d_date = '2010-03-01')
        AND ws_ext_sales_price > 0
        AND ws_ext_ship_cost > 0
        AND ws_warehouse_sk IN (
            SELECT DISTINCT ws_warehouse_sk
            FROM ws_wh
            WHERE ws_order_number IN (
                SELECT ws_order_number
                FROM web_sales
                WHERE ws_ship_date_sk BETWEEN (SELECT d_date_sk
                                               FROM date_dim
                                               WHERE d_date = '2010-01-01') AND (SELECT d_date_sk
                                                                               FROM date_dim
                                                                               WHERE d_date = '2010-03-01')
                    AND ws_ext_sales_price > 0
                    AND ws_ext_ship_cost > 0
                    AND ws_order_number IN (
                        SELECT ws_order_number
                        FROM web_sales
                        WHERE ws_sold_date_sk BETWEEN (SELECT d_date_sk
                                                       FROM date_dim
                                                       WHERE d_date = '2010-01-01') AND (SELECT d_date_sk
                                                                                       FROM date_dim
                                                                                       WHERE d_date = '2010-03-01')
                            AND ws_ext_sales_price > 0
                            AND ws_ext_ship_cost > 0
            )
        )
)
AND ca.ca_state = 'NC'
AND web.web_name = 'pri'
GROUP BY ws.ws_order_number
ORDER BY web_sales_count DESC
LIMIT 100;