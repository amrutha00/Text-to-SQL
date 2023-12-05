WITH PromotionalSales AS (
    SELECT SUM(ss_sales_price) AS promo_sales
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
    WHERE date_dim.d_month_seq BETWEEN 1193 AND 1193 + 30 -- November 1999
    AND item.i_category = 'Jewelry'
    AND customer_address.ca_gmt_offset = -7
    AND store_sales.ss_promo_sk IS NOT NULL
),

TotalSales AS (
    SELECT SUM(ss_sales_price) AS total_sales
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
    WHERE date_dim.d_month_seq BETWEEN 1193 AND 1193 + 30 -- November 1999
    AND item.i_category = 'Jewelry'
    AND customer_address.ca_gmt_offset = -7
)

SELECT 
    (promo_sales / NULLIF(total_sales, 0)) * 100 AS sales_percentage,
    promo_sales,
    total_sales
FROM PromotionalSales, TotalSales
ORDER BY promo_sales ASC, total_sales ASC
LIMIT 100;
