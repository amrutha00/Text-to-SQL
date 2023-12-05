WITH SalesData AS (
    -- Store Sales
    SELECT ss_item_sk AS item_id, SUM(ss_net_paid) AS total_sales
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE d_month_seq = 1135 -- August 2000, assuming the month sequence number for Aug 2000 is 1135
    AND ca_gmt_offset = -7
    AND i_category = 'Children'
    GROUP BY ss_item_sk

    UNION ALL

    -- Catalog Sales
    SELECT cs_item_sk AS item_id, SUM(cs_net_paid) AS total_sales
    FROM catalog_sales
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON catalog_sales.cs_ship_addr_sk = customer_address.ca_address_sk
    JOIN item ON catalog_sales.cs_item_sk = item.i_item_sk
    WHERE d_month_seq = 1135
    AND ca_gmt_offset = -7
    AND i_category = 'Children'
    GROUP BY cs_item_sk

    UNION ALL

    -- Web Sales
    SELECT ws_item_sk AS item_id, SUM(ws_net_paid) AS total_sales
    FROM web_sales
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON web_sales.ws_ship_addr_sk = customer_address.ca_address_sk
    JOIN item ON web_sales.ws_item_sk = item.i_item_sk
    WHERE d_month_seq = 1135
    AND ca_gmt_offset = -7
    AND i_category = 'Children'
    GROUP BY ws_item_sk
)

SELECT item_id, SUM(total_sales) AS total_sales
FROM SalesData
GROUP BY item_id
ORDER BY item_id, total_sales DESC
LIMIT 100;
