WITH StoreSalesByCategory AS (
    SELECT
        i.i_category,
        i.i_class,
        i.i_brand,
        i.i_product_name,
        d.d_year,
        d.d_qoy AS quarter_of_year,
        d.d_moy AS month_of_year,
        ss.ss_store_sk AS store_id,
        SUM(ss.ss_sales_price) AS total_sales
    FROM
        store_sales ss
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    WHERE
        d.d_year = 1206
    GROUP BY
        i.i_category,
        i.i_class,
        i.i_brand,
        i.i_product_name,
        d.d_year,
        d.d_qoy,
        d.d_moy,
        ss.ss_store_sk
)
, RankedStoreSales AS (
    SELECT
        i_category,
        i_class,
        i_brand,
        i_product_name,
        d_year,
        quarter_of_year,
        month_of_year,
        store_id,
        total_sales,
        ROW_NUMBER() OVER(PARTITION BY i_category ORDER BY total_sales DESC) AS store_rank
    FROM
        StoreSalesByCategory
)
SELECT
    i_category,
    i_class,
    i_brand,
    i_product_name,
    d_year,
    quarter_of_year,
    month_of_year,
    store_id,
    total_sales,
    store_rank
FROM
    RankedStoreSales
WHERE
    store_rank <= 100
ORDER BY
    i_category,
    store_rank;
