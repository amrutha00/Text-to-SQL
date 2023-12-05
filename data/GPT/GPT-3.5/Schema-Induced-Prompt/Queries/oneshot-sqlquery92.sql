SELECT 
    ws_order_number, 
    ws_ext_discount_amt - (0.3 * AVG(ws_ext_discount_amt) OVER (PARTITION BY i_manufact_id ORDER BY d_date)) AS excess_discount_amount
FROM 
    web_sales
JOIN 
    item ON ws_item_sk = i_item_sk
JOIN 
    date_dim ON ws_sold_date_sk = d_date_sk
WHERE 
    i_manufact_id = 320
    AND d_date >= '2002-02-26' 
    AND d_date < DATEADD(day, 90, '2002-02-26')
ORDER BY 
    excess_discount_amount DESC
LIMIT 100;