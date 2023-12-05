SELECT 
    SUM(ws_net_paid) AS total_net_paid,
    RANK() OVER (
        PARTITION BY i_category, i_class
        ORDER BY SUM(ws_net_paid) DESC
    ) AS sales_rank,
    CASE 
        WHEN i_category IS NOT NULL AND i_class IS NOT NULL THEN 'Category -> Class'
        WHEN i_category IS NOT NULL THEN 'Category'
        ELSE 'Unknown'
    END AS location_hierarchy
FROM
    web_sales
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    JOIN item ON ws_item_sk = i_item_sk
WHERE 
    d_year = 1224
GROUP BY 
    i_category, i_class
ORDER BY 
    CASE 
        WHEN location_hierarchy = 'Category -> Class' THEN 1
        ELSE 0
    END DESC,
    i_category DESC,
    total_net_paid DESC
LIMIT 100;