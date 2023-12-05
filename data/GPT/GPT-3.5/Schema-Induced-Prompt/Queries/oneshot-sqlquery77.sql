SELECT *
FROM (
  SELECT 'store' AS channel,
         s_store_sk AS location_id,
         SUM(ss_sales_price) AS total_sales,
         SUM(ss_net_profit) AS total_profit,
         0 AS total_returns,
         0 AS total_loss
  FROM store_sales
  WHERE ss_sold_date_sk >= 2451046 AND ss_sold_date_sk <= 2451075
  GROUP BY s_store_sk
  
  UNION ALL
  
  SELECT 'catalog' AS channel,
         c_catalog_order_sk AS location_id,
         SUM(cs_sales_price) AS total_sales,
         SUM(cs_net_profit) AS total_profit,
         SUM(cr_return_quantity) AS total_returns,
         SUM(cr_net_loss) AS total_loss
  FROM catalog_sales
  JOIN catalog_returns ON cs_order_number = cr_order_number
  WHERE cs_sold_date_sk >= 2451046 AND cs_sold_date_sk <= 2451075
  GROUP BY c_catalog_order_sk
  
  UNION ALL
  
  SELECT 'web' AS channel,
         wp_web_page_sk AS location_id,
         SUM(ws_sales_price) AS total_sales,
         SUM(ws_net_profit) AS total_profit,
         SUM(wr_return_quantity) AS total_returns,
         SUM(wr_net_loss) AS total_loss
  FROM web_sales
  JOIN web_page ON ws_web_page_sk = wp_web_page_sk
  JOIN web_returns ON ws_order_number = wr_order_number
  WHERE ws_sold_date_sk >= 2451046 AND ws_sold_date_sk <= 2451075
  GROUP BY wp_web_page_sk
) AS all_sales
ORDER BY channel, location_id
LIMIT 100;