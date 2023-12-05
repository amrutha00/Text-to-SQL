SELECT 
    i_item_id AS "Item ID",
    i_item_desc AS "Description",
    i_category AS "Category",
    i_class AS "Class",
    i_current_price AS "Current Price",
    SUM(ss_ext_sales_price) AS "Total Sales Revenue",
    SUM(ss_ext_sales_price) / NULLIF(SUM(SUM(ss_ext_sales_price)) OVER (PARTITION BY i_class), 0) AS "Revenue Ratio within Class"
FROM 
    store_sales
JOIN item ON store_sales.ss_item_sk = item.i_item_sk
WHERE 
    store_sales.ss_sold_date_sk BETWEEN '2002-05-20' AND '2002-06-19'
    AND i_category IN ('Sports', 'Music', 'Shoes')
GROUP BY 
    i_item_id, 
    i_item_desc, 
    i_category, 
    i_class, 
    i_current_price
ORDER BY 
    i_category, 
    i_class, 
    i_item_id, 
    i_item_desc, 
    "Revenue Ratio within Class";
