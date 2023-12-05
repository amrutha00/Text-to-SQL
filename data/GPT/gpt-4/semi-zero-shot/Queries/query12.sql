WITH TotalSales AS (
    SELECT 
        i.i_class,
        SUM(ws.ws_sales_price) AS class_total_sales
    FROM 
        web_sales ws
    JOIN item i ON ws.ws_item_sk = i.i_item_sk
    JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
    WHERE 
        i.i_category IN ('Books', 'Sports', 'Men') 
        AND d.d_date BETWEEN '1998-04-06' AND '1998-05-05' 
    GROUP BY 
        i.i_class
)

SELECT 
    i.i_item_id,
    i.i_item_desc,
    i.i_category,
    i.i_class,
    i.i_current_price,
    SUM(ws.ws_sales_price) / ts.class_total_sales AS revenueratio
FROM 
    web_sales ws
JOIN item i ON ws.ws_item_sk = i.i_item_sk
JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
JOIN TotalSales ts ON i.i_class = ts.i_class
WHERE 
    i.i_category IN ('Books', 'Sports', 'Men') 
    AND d.d_date BETWEEN '1998-04-06' AND '1998-05-05' 
GROUP BY 
    i.i_item_id, i.i_item_desc, i.i_category, i.i_class, i.i_current_price, ts.class_total_sales
ORDER BY 
    i.i_category ASC, i.i_class ASC, i.i_item_id ASC, i.i_item_desc ASC, revenueratio DESC
LIMIT 100;
