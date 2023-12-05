SELECT 
    COUNT(DISTINCT ws_order_number) AS distinct_order_count,
    SUM(ws_ship_cost) AS total_shipping_cost,
    SUM(ws_net_profit) AS total_net_profit
FROM 
    web_sales
JOIN 
    date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
JOIN 
    web_site ON web_sales.ws_web_site_sk = web_site.web_site_sk
JOIN 
    customer_address ON web_sales.ws_bill_addr_sk = customer_address.ca_address_sk
WHERE 
    date_dim.d_date BETWEEN '2000-02-01' AND '2000-04-01'
    AND customer_address.ca_state = 'OK'
    AND web_site.web_site_name = 'pri'
    AND web_sales.ws_order_status <> 'returned'
    AND web_sales.ws_warehouse_sk <> web_sales.ws_fulfill_center_sk
ORDER BY 
    distinct_order_count DESC
LIMIT 
    100;
