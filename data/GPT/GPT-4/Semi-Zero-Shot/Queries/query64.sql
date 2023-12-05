WITH CrossSales AS (
    SELECT
        s_store_name,
        s_zip,
        s_street_number,
        s_street_name,
        s_city,
        i_item_id,
        i_product_name,
        ss_sold_date_sk,
        COUNT(*) AS item_count,
        SUM(ss_wholesale_cost) AS total_wholesale_cost,
        SUM(ss_list_price) AS total_list_price,
        SUM(ss_coupon_amt) AS total_coupon_amount
    FROM store_sales
    JOIN store ON ss_store_sk = s_store_sk
    JOIN item ON ss_item_sk = i_item_sk
    WHERE ss_sold_date_sk BETWEEN 2001 AND 2002 
          AND i_sold_time_sk IN ('Internet', 'Catalog', 'In Store') -- Assuming there's a field indicating the sales method
    GROUP BY s_store_name, s_zip, s_street_number, s_street_name, s_city, i_item_id, i_product_name, ss_sold_date_sk
)

SELECT 
    s_store_name,
    s_zip,
    s_street_number,
    s_street_name,
    s_city,
    i_product_name,
    ss_sold_date_sk AS sales_year,
    item_count,
    total_wholesale_cost,
    total_list_price,
    total_coupon_amount
FROM CrossSales
WHERE ss_sold_date_sk = 2001 AND item_count > (
    SELECT item_count 
    FROM CrossSales AS cs2
    WHERE cs2.i_item_id = CrossSales.i_item_id AND cs2.ss_sold_date_sk = 2002
)
ORDER BY i_product_name, s_store_name, item_count DESC, total_wholesale_cost DESC;
