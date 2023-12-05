SELECT i_product_name, ss_net_profit
FROM store_sales
JOIN item ON ss_item_sk = i_item_sk
WHERE ss_store_sk = 146
ORDER BY ss_net_profit ASC
LIMIT 100