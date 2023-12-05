WITH RankedStores AS (
    SELECT
        i.i_category AS item_category,
        i.i_class AS item_class,
        i.i_brand AS item_brand,
        i.i_product_name AS product_name,
        EXTRACT(YEAR FROM s.ws_sold_date_sk) AS year,
        EXTRACT(QUARTER FROM s.ws_sold_date_sk) AS quarter,
        EXTRACT(MONTH FROM s.ws_sold_date_sk) AS month,
        s.ws_store_sk AS store_id,
        SUM(s.ws_sales_price) AS total_sales,
        RANK() OVER (PARTITION BY i.i_category ORDER BY SUM(s.ws_sales_price) DESC) AS category_rank
    FROM
        store_sales AS s
    JOIN
        item AS i ON s.ws_item_sk = i.i_item_sk
    WHERE
        EXTRACT(YEAR FROM s.ws_sold_date_sk) = 1206
    GROUP BY
        i.i_category,
        i.i_class,
        i.i_brand,
        i.i_product_name,
        year,
        quarter,
        month,
        s.ws_store_sk
)
SELECT
    item_category,
    item_class,
    item_brand,
    product_name,
    year,
    quarter,
    month,
    store_id,
    total_sales,
    category_rank
FROM
    RankedStores
WHERE
    category_rank <= 100
ORDER BY
    item_category,
    total_sales DESC;
