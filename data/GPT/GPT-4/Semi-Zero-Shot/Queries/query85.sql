SELECT 
    r.r_reason_desc,
    AVG(wr.wr_return_quantity) AS avg_sales_quantity,
    AVG(wr.wr_refunded_cash) AS avg_refunded_cash,
    AVG(wr.wr_return_amt) AS avg_return_fee
FROM 
    web_returns wr 
JOIN 
    customer c ON wr.wr_refunded_customer_sk = c.c_customer_sk
JOIN 
    store_sales ss ON wr.wr_item_sk = ss.ss_item_sk
JOIN 
    reason r ON wr.wr_return_reason_sk = r.r_reason_sk
WHERE 
    c.c_marital_status IN ('M', 'S', 'W') 
AND 
    c.c_education_status IN ('4 yr Degree', 'Secondary', 'Advanced Degree')
AND 
    c.c_current_addr_sk IN ('FL', 'TX', 'DE', 'IN', 'ND', 'ID', 'MT', 'IL', 'OH')
AND 
    (   
        (ss.ss_net_profit BETWEEN 100 AND 200)
    OR 
        (ss.ss_net_profit BETWEEN 150 AND 300)
    OR 
        (ss.ss_net_profit BETWEEN 50 AND 250)
    )
GROUP BY 
    r.r_reason_desc
ORDER BY 
    LEFT(r.r_reason_desc, 20), avg_sales_quantity, avg_refunded_cash, avg_return_fee
LIMIT 100;
