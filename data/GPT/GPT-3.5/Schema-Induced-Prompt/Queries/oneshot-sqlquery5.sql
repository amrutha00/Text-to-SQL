SELECT 
    CASE
        WHEN ss_sold_date >= '2000-08-19' AND ss_sold_date <= '2000-09-01' THEN 'store'
        WHEN ss_sold_date >= '2000-08-19' AND ss_sold_date <= '2000-09-01' THEN 'catalog'
        WHEN ss_sold_date >= '2000-08-19' AND ss_sold_date <= '2000-09-01' THEN 'web site'
    END AS sales_channel, 
    CASE
        WHEN ss_sold_date >= '2000-08-19' AND ss_sold_date <= '2000-09-01' THEN 'store'
        WHEN ss_sold_date >= '2000-08-19' AND ss_sold_date <= '2000-09-01' THEN 'catalog page'
        WHEN ss_sold_date >= '2000-08-19' AND ss_sold_date <= '2000-09-01' THEN 'web site'
    END AS specific_method, 
    SUM(ss_sales_price) AS sales,
    SUM(ss_net_profit) AS profit,
    SUM(sr_return_amt) AS return_amount,
    SUM(sr_net_loss) AS net_loss
FROM 
    store_sales
    JOIN store_returns ON store_sales.ss_ticket_number = store_returns.sr_ticket_number
WHERE 
    ss_sold_date >= '2000-08-19' AND ss_sold_date <= '2000-09-01'
GROUP BY 
    sales_channel, specific_method
ORDER BY 
    sales_channel, specific_method
LIMIT 100;