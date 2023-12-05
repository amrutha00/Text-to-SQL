SELECT w_state, i_item_id, SUM(cs_sales_price) AS total_sales
FROM catalog_sales
JOIN item ON catalog_sales.cs_item_sk = item.i_item_sk
JOIN warehouse ON catalog_sales.cs_warehouse_sk = warehouse.w_warehouse_sk
WHERE catalog_sales.cs_sold_date_sk BETWEEN (SELECT MAX(d_date_sk) - 30 FROM date_dim) AND (SELECT MAX(d_date_sk) FROM date_dim)
GROUP BY w_state, i_item_id
ORDER BY w_state, i_item_id
LIMIT 100;