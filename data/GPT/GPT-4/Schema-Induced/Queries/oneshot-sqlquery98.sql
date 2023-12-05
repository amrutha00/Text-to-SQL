SELECT 
    item.i_item_id,
    item.i_item_desc,
    item.i_category,
    item.i_class,
    item.i_current_price,
    SUM(store_sales.ss_sales_price) AS total_sales_revenue,
    SUM(store_sales.ss_sales_price) / SUM(CASE WHEN item.i_class = store_sales.i_class THEN store_sales.ss_sales_price ELSE 0 END) AS revenue_ratio
FROM 
    item
JOIN 
    store_sales ON item.i_item_sk = store_sales.ss_item_sk
WHERE 
    store_sales.ss_sold_date_sk BETWEEN (SELECT d_date_sk FROM date_dim WHERE d_date = '2002-05-20') AND (SELECT d_date_sk FROM date_dim WHERE d_date = '2002-06-19')
    AND item.i_category IN ('Sports', 'Music', 'Shoes')
GROUP BY 
    item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price
ORDER BY 
    item.i_category, item.i_class, item.i_item_id, item.i_item_desc, revenue_ratio