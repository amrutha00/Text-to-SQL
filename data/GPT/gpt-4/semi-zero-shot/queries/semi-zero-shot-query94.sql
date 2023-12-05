SELECT
    COUNT(DISTINCT ws.ws_order_number) AS distinct_web_sales_order_count,
    SUM(ws.ws_ext_ship_cost) AS total_shipping_cost,
    SUM(ws.ws_net_profit) AS total_net_profit
FROM
    web_sales ws
JOIN
    customer c ON ws.ws_bill_customer_sk = c.c_customer_sk
JOIN
    web_site w ON ws.ws_web_site_sk = w.w_web_site_sk
JOIN
    date_dim d ON ws.ws_ship_date_sk = d.d_date_sk
JOIN
    web_returns wr ON ws.ws_order_number = wr.wr_order_number
WHERE
    d.d_date >= TO_DATE('2000-02-01', 'YYYY-MM-DD')
    AND d.d_date <= TO_DATE('2000-04-01', 'YYYY-MM-DD')
    AND c.c_state = 'Oklahoma'
    AND w.w_warehouse_name = 'pri'
    AND ws.ws_ship_addr_sk <> wr.wr_returned_addr_sk
GROUP BY
    ws.ws_order_number
ORDER BY
    distinct_web_sales_order_count DESC
LIMIT 100;
