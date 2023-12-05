WITH ChannelSales AS (
    -- Store Sales
    SELECT 'store' AS sales_channel,
           ss_store_sk AS channel_id,
           SUM(ss_ext_sales_price) AS extended_sales,
           SUM(ss_net_profit) AS extended_net_profit,
           SUM(ss_ext_sales_price - ss_net_paid) AS returns
    FROM store_sales, item, promotion
    WHERE ss_sold_date_sk BETWEEN 
           (SELECT d_date_sk FROM date_dim WHERE d_date = '1998-08-28') AND
           (SELECT d_date_sk + 29 FROM date_dim WHERE d_date = '1998-08-28')
      AND ss_item_sk = i_item_sk
      AND i_current_price > 50
      AND ss_promo_sk = p_promo_sk
      AND p_channel_tv = 'N'
    GROUP BY ss_store_sk
    
    UNION ALL
    
    -- Catalog Sales
    SELECT 'catalog' AS sales_channel,
           cs_catalog_page_sk AS channel_id,
           SUM(cs_ext_sales_price) AS extended_sales,
           SUM(cs_net_profit) AS extended_net_profit,
           SUM(cs_ext_sales_price - cs_net_paid) AS returns
    FROM catalog_sales, item, promotion
    WHERE cs_sold_date_sk BETWEEN 
           (SELECT d_date_sk FROM date_dim WHERE d_date = '1998-08-28') AND
           (SELECT d_date_sk + 29 FROM date_dim WHERE d_date = '1998-08-28')
      AND cs_item_sk = i_item_sk
      AND i_current_price > 50
      AND cs_promo_sk = p_promo_sk
      AND p_channel_tv = 'N'
    GROUP BY cs_catalog_page_sk
    
    UNION ALL
    
    -- Web Sales
    SELECT 'web' AS sales_channel,
           ws_web_site_sk AS channel_id,
           SUM(ws_ext_sales_price) AS extended_sales,
           SUM(ws_net_profit) AS extended_net_profit,
           SUM(ws_ext_sales_price - ws_net_paid) AS returns
    FROM web_sales, item, promotion
    WHERE ws_sold_date_sk BETWEEN 
           (SELECT d_date_sk FROM date_dim WHERE d_date = '1998-08-28') AND
           (SELECT d_date_sk + 29 FROM date_dim WHERE d_date = '1998-08-28')
      AND ws_item_sk = i_item_sk
      AND i_current_price > 50
      AND ws_promo_sk = p_promo_sk
      AND p_channel_tv = 'N'
    GROUP BY ws_web_site_sk
)

SELECT sales_channel, 
       channel_id, 
       SUM(extended_sales) AS total_extended_sales, 
       SUM(extended_net_profit) AS total_extended_net_profit, 
       SUM(returns) AS total_returns
FROM ChannelSales
GROUP BY ROLLUP(sales_channel, channel_id)
ORDER BY sales_channel, channel_id
LIMIT 100;
