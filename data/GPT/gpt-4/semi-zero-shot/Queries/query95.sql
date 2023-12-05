SELECT 
    COUNT(DISTINCT ws_order_number) AS num_web_sales,
    SUM(ws_ship_cost) AS total_shipping_cost,
    SUM(ws_net_profit) AS net_profit
FROM web_sales
JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
JOIN web_returns ON web_sales.ws_order_number = web_returns.wr_order_number
JOIN web_site ON web_sales.ws_web_site_sk = web_site.ws_web_site_sk
JOIN customer_address ON web_sales.ws_bill_addr_sk = customer_address.ca_address_sk
WHERE 
    date_dim.d_date BETWEEN 'start_date' AND 'end_date' -- Replace 'start_date' and 'end_date' with the actual dates
    AND customer_address.ca_state = 'NC'
    AND web_site.ws_web_site_name = 'pri'
    AND web_sales.ws_order_number IN (
        SELECT wr_order_number
        FROM web_returns
        GROUP BY wr_order_number
        HAVING COUNT(DISTINCT wr_warehouse_sk) > 1
    )
GROUP BY ws_order_number
ORDER BY num_web_sales DESC
LIMIT 100;
