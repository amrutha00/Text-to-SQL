SELECT item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price,
       SUM(catalog_sales.cs_sales_price) AS total_revenue,
       SUM(catalog_sales.cs_sales_price) / SUM(SUM(catalog_sales.cs_sales_price)) OVER (PARTITION BY item.i_class) AS revenue_ratio
FROM catalog_sales
JOIN item ON catalog_sales.cs_item_sk = item.i_item_sk
JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
WHERE item.i_category IN ('Shoes', 'Books', 'Women')
  AND date_dim.d_date >= '2002-01-26' AND date_dim.d_date <= '2002-02-25'
GROUP BY item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price
ORDER BY item.i_category ASC, item.i_class ASC, item.i_item_id ASC, item.i_item_desc ASC, revenue_ratio ASC
LIMIT 100;