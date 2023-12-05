SELECT 
    i.i_item_id,
    i.i_item_desc,
    SUM(ss.ss_ext_sales_price) AS total_sales_amount
FROM 
    store_sales ss
JOIN 
    item i ON ss.ss_item_sk = i.i_item_sk
JOIN 
    date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN 
    customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
WHERE 
    i.i_color IN ('color1', 'color2', 'color3')  -- Replace with the specific colors
AND 
    d.d_month_seq = 14  -- Month of February 2000
AND 
    ca.ca_gmt_offset = -6
GROUP BY 
    i.i_item_id,
    i.i_item_desc
ORDER BY 
    total_sales_amount DESC
LIMIT 100;
