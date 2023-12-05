SELECT i.i_item_id,
       i.i_item_desc,
       s.s_store_id,
       s.s_store_name,
       SUM(ss.ss_net_profit) AS total_store_net_profit,
       SUM(sr.sr_net_loss) AS total_store_return_net_loss,
       SUM(cs.cs_net_profit) AS total_catalog_net_profit
FROM store_sales ss
JOIN store_returns sr ON ss.ss_item_sk = sr.sr_item_sk
JOIN catalog_sales cs ON ss.ss_item_sk = cs.cs_item_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
JOIN item i ON ss.ss_item_sk = i.i_item_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
WHERE (d.d_year = 2000 AND d.d_moy = 4)
  AND ((d.d_year = 2000 AND d.d_moy >= 4 AND d.d_moy <= 10) OR (d.d_year = 2000 AND d.d_moy = 4))
GROUP BY i.i_item_id, i.i_item_desc, s.s_store_id, s.s_store_name
ORDER BY i.i_item_id, i.i_item_desc, s.s_store_id, s.s_store_name
LIMIT 100;