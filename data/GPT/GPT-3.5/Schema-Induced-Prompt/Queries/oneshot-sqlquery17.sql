SELECT i_item_id, i_item_desc, s_state,
       COUNT(ss_quantity) AS store_sales_count,
       AVG(ss_quantity) AS store_sales_avg,
       STDDEV(ss_quantity) AS store_sales_stddev,
       COUNT(sr_return_quantity) AS store_returns_count,
       AVG(sr_return_quantity) AS store_returns_avg,
       STDDEV(sr_return_quantity) AS store_returns_stddev,
       COUNT(cs_quantity) AS catalog_sales_count,
       AVG(cs_quantity) AS catalog_sales_avg,
       STDDEV(cs_quantity) AS catalog_sales_stddev
FROM store_sales
JOIN store_returns ON ss_item_sk = sr_item_sk
JOIN catalog_sales ON cs_item_sk = ss_item_sk
JOIN store ON ss_store_sk = s_store_sk
JOIN item ON ss_item_sk = i_item_sk
WHERE ss_sold_date_sk BETWEEN 2451911 AND 2452055
  AND sr_returned_date_sk BETWEEN 2452056 AND 2452199
  AND cs_sold_date_sk BETWEEN 2452200 AND 2452343
GROUP BY i_item_id, i_item_desc, s_state
ORDER BY i_item_id, i_item_desc, s_state
LIMIT 100;