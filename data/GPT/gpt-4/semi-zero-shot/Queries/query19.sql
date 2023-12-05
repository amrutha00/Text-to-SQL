WITH RankedProducts AS (
    SELECT 
        i.i_brand,
        i.i_brand_id,
        i.i_manufact_id,
        i.i_manufact,
        SUM(ss.ss_ext_sales_price) AS ext_price
    FROM store_sales ss
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
    -- Placeholder for the MANAGER.01 = 8 condition:
    -- JOIN some_table st ON ss.some_field = st.some_field
    WHERE d.d_year = 1998 AND d.d_month = 11
    AND c.c_current_addr_sk <> c.c_first_shipto_date_sk -- assuming this condition determines out-of-zip code customers
    -- AND st.MANAGER.01 = 8
    GROUP BY i.i_brand, i.i_brand_id, i.i_manufact_id, i.i_manufact
)
SELECT 
    i_brand,
    i_brand_id,
    i_manufact_id,
    i_manufact,
    ext_price
FROM RankedProducts
ORDER BY ext_price DESC
LIMIT 100;
