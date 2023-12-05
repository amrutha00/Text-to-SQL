WITH sales_data AS (
    SELECT
        cat.cat_description AS category,
        cl.class_description AS class,
        SUM(ws.ws_net_paid) AS net_paid_sales,
        CASE
            WHEN cat.cat_description IS NOT NULL AND cl.class_description IS NOT NULL THEN 2 -- Both category and class are present
            WHEN cat.cat_description IS NOT NULL THEN 1 -- Only category is present
            ELSE 0 -- Neither is present
        END AS hierarchy_level
    FROM web_sales ws
    JOIN date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk
    JOIN item i ON ws.ws_item_sk = i.i_item_sk
    JOIN category cat ON i.i_category_sk = cat.cat_category_sk
    JOIN class cl ON i.i_class_sk = cl.class_class_sk
    WHERE dd.d_year = 1224
    GROUP BY 
        ROLLUP (cat.cat_description, cl.class_description)
)

SELECT 
    category,
    class,
    net_paid_sales,
    hierarchy_level,
    RANK() OVER (PARTITION BY hierarchy_level, category ORDER BY net_paid_sales DESC) AS sales_rank
FROM sales_data
ORDER BY hierarchy_level DESC, 
    CASE WHEN hierarchy_level = 0 THEN category END DESC, 
    sales_rank
LIMIT 100;
