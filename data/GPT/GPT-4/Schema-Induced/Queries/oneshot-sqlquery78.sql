SELECT 
    ss_item_sk AS item_sk,
    (SUM(ss_sales_price) / NULLIF(SUM(cs_sales_price), 0)) AS ratio,
    SUM(ss_quantity) AS store_quantity,
    SUM(ss_wholesale_cost) AS store_wholesale_cost,
    SUM(ss_sales_price) AS store_sales_price,
    SUM(cs_quantity) AS other_channel_quantity,
    SUM(cs_wholesale_cost) AS other_channel_wholesale_cost,
    SUM(cs_sales_price) AS other_channel_sales_price
FROM 
    store_sales
JOIN 
    catalog_sales ON store_sales.ss_item_sk = catalog_sales.cs_item_sk
WHERE 
    YEAR(catalog_sales.cs_sold_date_sk) = 2000
GROUP BY 
    ss_item_sk
HAVING 
    SUM(ss_quantity) > 0
    AND SUM(cs_quantity) > 0
    AND (SUM(ss_sales_price) / NULLIF(SUM(cs_sales_price), 0)) >= 2
ORDER BY 
    ratio DESC
LIMIT 100;