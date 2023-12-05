SELECT
    CASE
        WHEN c.cp_type = 'store' THEN 'store'
        WHEN c.cp_type = 'catalog page' THEN 'catalog page'
        WHEN c.cp_type = 'web site' THEN 'web site'
    END AS sales_channel,
    c.cp_catalog_page_id AS channel_id,
    SUM(CASE
            WHEN c.cp_type = 'store' THEN cs.cs_ext_sales_price
            ELSE 0
        END) AS store_sales,
    SUM(CASE
            WHEN c.cp_type = 'store' THEN cs.cs_net_profit
            ELSE 0
        END) AS store_net_profit,
    SUM(CASE
            WHEN c.cp_type = 'catalog page' THEN cs.cs_ext_sales_price
            ELSE 0
        END) AS catalog_sales,
    SUM(CASE
            WHEN c.cp_type = 'catalog page' THEN cs.cs_net_profit
            ELSE 0
        END) AS catalog_net_profit,
    SUM(CASE
            WHEN c.cp_type = 'web site' THEN cs.cs_ext_sales_price
            ELSE 0
        END) AS web_sales,
    SUM(CASE
            WHEN c.cp_type = 'web site' THEN cs.cs_net_profit
            ELSE 0
        END) AS web_net_profit
FROM
    catalog_sales AS cs
JOIN catalog_page AS c ON cs.cs_catalog_page_sk = c.cp_catalog_page_sk
JOIN item AS i ON cs.cs_item_sk = i.i_item_sk
WHERE
    i.i_current_price > 50
    AND c.cp_start_date_sk >= 98168 AND c.cp_start_date_sk <= 98298
    AND i.i_brand NOT IN (
        SELECT p.p_promo_name FROM promotion AS p WHERE p.p_channel_tv = 'Y'
    )
GROUP BY ROLLUP(sales_channel, channel_id)
ORDER BY sales_channel, channel_id
LIMIT 100;