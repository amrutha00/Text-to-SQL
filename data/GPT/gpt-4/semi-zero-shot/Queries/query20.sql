WITH Total_Revenue AS (
    SELECT 
        SUM(ss.ss_sales_price) AS total_revenue
    FROM 
        store_sales ss
    JOIN 
        date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk
    WHERE 
        dd.d_date BETWEEN '2002-01-26' AND '2002-02-25'
),

Revenue_By_Item_Class AS (
    SELECT 
        i.i_item_sk,
        i.i_item_desc,
        i.i_category,
        i.i_class,
        i.i_current_price,
        SUM(ss.ss_sales_price) AS item_class_revenue
    FROM 
        store_sales ss
    JOIN 
        item i ON ss.ss_item_sk = i.i_item_sk
    JOIN 
        date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk
    WHERE 
        i.i_category IN ('Shoes', 'Books', 'Women')
        AND dd.d_date BETWEEN '2002-01-26' AND '2002-02-25'
    GROUP BY 
        i.i_item_sk, i.i_item_desc, i.i_category, i.i_class, i.i_current_price
)

SELECT 
    rbi.i_item_sk,
    rbi.i_item_desc,
    rbi.i_category,
    rbi.i_class,
    rbi.i_current_price,
    rbi.item_class_revenue,
    tr.total_revenue,
    rbi.item_class_revenue / NULLIF(tr.total_revenue, 0) AS revenue_ratio
FROM 
    Revenue_By_Item_Class rbi, Total_Revenue tr
ORDER BY 
    rbi.i_category ASC,
    rbi.i_class ASC,
    rbi.i_item_sk ASC,
    rbi.i_item_desc ASC,
    revenue_ratio ASC
LIMIT 100;
