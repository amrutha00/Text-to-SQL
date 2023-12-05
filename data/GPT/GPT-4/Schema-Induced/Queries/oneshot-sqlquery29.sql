SELECT i.i_item_id, i.i_item_desc, s.s_store_id, s.s_store_name,
    AVG(ss.ss_quantity) AS store_sales_quantity,
    AVG(sr.sr_return_quantity) AS store_returns_quantity,
    AVG(cs.cs_quantity) AS catalog_sales_quantity
FROM item AS i
JOIN store AS s ON i.i_item_sk = s.s_store_sk
JOIN store_sales AS ss ON i.i_item_sk = ss.i_item_id AND s.s_store_sk = ss.s_store_id
JOIN store_returns AS sr ON sr.sr_item_sk = i.i_item_sk AND sr.sr_customer_sk = s.s_store_sk
JOIN catalog_sales AS cs ON cs.cs_item_sk = i.i_item_sk AND cs.cs_bill_customer_sk = s.s_store_sk
JOIN date_dim AS d1 ON ss.ss_sold_date_sk = d1.d_date_sk
JOIN date_dim AS d2 ON sr.sr_returned_date_sk = d2.d_date_sk
WHERE d1.d_moy = 4 AND d1.d_year = 1999
    AND d2.d_year = d1.d_year AND d2.d_moy BETWEEN d1.d_moy + 1 AND d1.d_moy + 6
    AND cs.cs_sold_date_sk BETWEEN d2.d_date_sk + 365 AND d2.d_date_sk + 1095
GROUP BY i.i_item_id, i.i_item_desc, s.s_store_id, s.s_store_name
ORDER BY i.i_item_id, i.i_item_desc, s.s_store_id, s.s_store_name
LIMIT 100;