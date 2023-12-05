WITH RankedData AS (
    SELECT 
        i.i_category, 
        i.i_class,
        COALESCE(i.i_category, 'NO CATEGORY') AS hierarchy_category,
        COALESCE(i.i_class, 'NO CLASS') AS hierarchy_class,
        SUM(ss_sales_price - ss_net_profit) AS gross_profit_margin,
        ROW_NUMBER() OVER (PARTITION BY COALESCE(i.i_category, 'NO CATEGORY'), COALESCE(i.i_class, 'NO CLASS')
                           ORDER BY SUM(ss_sales_price - ss_net_profit) DESC) AS rank
    FROM 
        store_sales ss 
        JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        JOIN item i ON ss.ss_item_sk = i.i_item_sk
        JOIN store s ON ss.ss_store_sk = s.s_store_sk
    WHERE 
        d.d_year = 2002
        AND s.s_state IN ('SD', 'TN', 'GA', 'SC', 'MO', 'AL', 'MI', 'OH')
    GROUP BY 
        i.i_category, 
        i.i_class
)
SELECT 
    i_category, 
    i_class, 
    hierarchy_category,
    hierarchy_class,
    gross_profit_margin,
    rank
FROM 
    RankedData
WHERE 
    rank <= 100
ORDER BY 
    hierarchy_category DESC, 
    hierarchy_class DESC;
