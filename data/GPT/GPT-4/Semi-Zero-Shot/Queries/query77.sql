WITH StoreAggregates AS (
    SELECT
        s.s_store_name AS channel_location,
        'store' AS channel,
        SUM(ss.ss_sales_price) AS total_sales,
        SUM(ss.ss_net_profit) AS profit,
        SUM(sr.ss_net_loss) AS returns_loss
    FROM store_sales ss
    LEFT JOIN store_returns sr ON ss.ss_item_sk = sr.sr_item_sk
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk AND d.d_date BETWEEN '1998-08-05' AND '1998-09-04'
    JOIN store s ON ss.ss_store_sk = s.s_store_sk
    GROUP BY s.s_store_name
),
CatalogAggregates AS (
    SELECT
        cs_item_sk AS channel_location,
        'catalog' AS channel,
        SUM(cs.cs_sales_price) AS total_sales,
        SUM(cs.cs_net_profit) AS profit,
        SUM(cr.cs_net_loss) AS returns_loss
    FROM catalog_sales cs
    LEFT JOIN catalog_returns cr ON cs.cs_item_sk = cr.cr_item_sk
    JOIN date_dim d ON cs.cs_sold_date_sk = d.d_date_sk AND d.d_date BETWEEN '1998-08-05' AND '1998-09-04'
    GROUP BY cs_item_sk
),
WebAggregates AS (
    SELECT
        wp.web_page_description AS channel_location,
        'web' AS channel,
        SUM(ws.ws_sales_price) AS total_sales,
        SUM(ws.ws_net_profit) AS profit,
        SUM(wr.ws_net_loss) AS returns_loss
    FROM web_sales ws
    LEFT JOIN web_returns wr ON ws.ws_item_sk = wr.wr_item_sk
    JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk AND d.d_date BETWEEN '1998-08-05' AND '1998-09-04'
    JOIN web_page wp ON ws.ws_web_page_sk = wp.web_page_sk
    GROUP BY wp.web_page_description
)

SELECT channel_location, channel, SUM(total_sales) AS total_sales, SUM(profit) AS profit, SUM(returns_loss) AS returns_loss
FROM (
    SELECT * FROM StoreAggregates
    UNION ALL
    SELECT * FROM CatalogAggregates
    UNION ALL
    SELECT * FROM WebAggregates
) AS CombinedData
GROUP BY ROLLUP (channel_location, channel)
ORDER BY channel, channel_location
LIMIT 100;
