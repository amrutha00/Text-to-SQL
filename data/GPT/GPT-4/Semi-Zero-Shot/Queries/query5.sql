WITH ChannelSales AS (
    SELECT 
        'store' AS channel,
        s_store_name AS method,
        SUM(ss_sales_price) AS sales,
        SUM(ss_sales_price - ss_net_profit) AS profit,
        SUM(ss_net_profit) AS net_loss,
        0 AS return_amount
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    WHERE d_date BETWEEN '2000-08-19' AND '2000-09-02'
    GROUP BY s_store_name

    UNION ALL

    SELECT 
        'catalog' AS channel,
        cp_catalog_page_desc AS method,
        SUM(cs_sales_price) AS sales,
        SUM(cs_sales_price - cs_net_profit) AS profit,
        SUM(cs_net_profit) AS net_loss,
        0 AS return_amount
    FROM catalog_sales
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    JOIN catalog_page ON catalog_sales.cs_catalog_page_sk = catalog_page.cp_catalog_page_sk
    WHERE d_date BETWEEN '2000-08-19' AND '2000-09-02'
    GROUP BY cp_catalog_page_desc

    UNION ALL

    SELECT 
        'web' AS channel,
        web_site_name AS method,
        SUM(ws_sales_price) AS sales,
        SUM(ws_sales_price - ws_net_profit) AS profit,
        SUM(ws_net_profit) AS net_loss,
        0 AS return_amount
    FROM web_sales
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    JOIN web_site ON web_sales.ws_web_site_sk = web_site.web_site_sk
    WHERE d_date BETWEEN '2000-08-19' AND '2000-09-02'
    GROUP BY web_site_name
)

SELECT channel, method, sales, profit, return_amount, net_loss
FROM ChannelSales
ORDER BY channel, method
LIMIT 100;
