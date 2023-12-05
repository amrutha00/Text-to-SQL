SELECT
    ch.channel,
    col.column_name,
    EXTRACT(year FROM dt.d_date) AS year,
    EXTRACT(quarter FROM dt.d_date) AS quarter,
    itm.i_category,
    COUNT(*) AS sales_count,
    SUM(ss.ss_sales_price + ws.ws_sales_price + cs.cs_sales_price) AS sales_amount
FROM
    (
    	SELECT 'store' AS channel, ss.ss_hdemo_sk AS hdemo_sk, ss.ss_sold_date_sk AS sold_date_sk
        FROM store_sales ss
        WHERE ss.ss_hdemo_sk IS NOT NULL
        	AND ss.ss_bill_addr_sk IS NULL
           	AND ss.ss_catalog_page_sk IS NULL
            AND ss.ss_ship_mode_sk IS NULL
            AND ss.ss_warehouse_sk IS NULL
    	UNION ALL
        SELECT 'web' AS channel, ws.ws_bill_addr_sk AS hdemo_sk, ws.ws_sold_date_sk AS sold_date_sk
        FROM web_sales ws
        WHERE ws.ws_bill_addr_sk IS NOT NULL
        	AND ws.ws_hdemo_sk IS NULL
           	AND ws.ws_catalog_page_sk IS NULL
            AND ws.ws_ship_mode_sk IS NULL
            AND ws.ws_warehouse_sk IS NULL
    	UNION ALL
        SELECT 'catalog' AS channel, cs.cs_warehouse_sk AS hdemo_sk, cs.cs_sold_date_sk AS sold_date_sk
        FROM catalog_sales cs
        WHERE cs.cs_warehouse_sk IS NOT NULL
        	AND cs.cs_hdemo_sk IS NULL
           	AND cs.cs_catalog_page_sk IS NULL
            AND cs.cs_ship_mode_sk IS NULL
            AND cs.cs_bill_addr_sk IS NULL
    ) ch
    INNER JOIN date_dim dt ON ch.sold_date_sk = dt.d_date_sk
    INNER JOIN item itm ON (
    	(itm.i_item_sk = ss.ss_item_sk AND ch.channel = 'store') OR
    	(itm.i_item_sk = ws.ws_item_sk AND ch.channel = 'web') OR
    	(itm.i_item_sk = cs.cs_item_sk AND ch.channel = 'catalog')
    )
GROUP BY
    ch.channel,
    col.column_name,
    year,
    quarter,
    itm.i_category
ORDER BY
    ch.channel,
    col.column_name,
    year,
    quarter,
    itm.i_category
LIMIT 100;