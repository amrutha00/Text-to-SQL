WITH sales_data AS (
    SELECT i_manufact_id, 
           COALESCE(ss_ext_sales_price, 0) + COALESCE(cs_ext_sales_price, 0) + COALESCE(ws_ext_sales_price, 0) AS total_sales_price
    FROM item
    JOIN date_dim ON date_dim.d_date_sk = COALESCE(store_sales.ss_sold_date_sk, catalog_sales.cs_sold_date_sk, web_sales.ws_sold_date_sk)
    LEFT JOIN store_sales ON item.i_item_sk = store_sales.ss_item_sk
    LEFT JOIN catalog_sales ON item.i_item_sk = catalog_sales.cs_item_sk
    LEFT JOIN web_sales ON item.i_item_sk = web_sales.ws_item_sk
    WHERE item.i_category = 'Home'
    AND date_dim.d_year = 2002
    AND date_dim.d_moy = 1
    -- assuming a date offset for the time zone
    AND date_dim.d_date BETWEEN '2002-01-01' AND '2002-01-31' -- adjust this if necessary based on the timezone offset
)
SELECT i_manufact_id, SUM(total_sales_price) AS total_sales
FROM sales_data
GROUP BY i_manufact_id
ORDER BY total_sales DESC
LIMIT 100;
