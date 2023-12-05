WITH ItemCategoryAvg AS (
    SELECT
        i_category,
        AVG(i_current_price) AS avg_price
    FROM
        item
    GROUP BY
        i_category
),
PurchasesWithHighPrice AS (
    SELECT
        s_state,
        COUNT(DISTINCT ss_customer_sk) AS customer_count
    FROM
        store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    JOIN ItemCategoryAvg ON item.i_category = ItemCategoryAvg.i_category
    WHERE
        date_dim.d_month_seq = (
            SELECT d_month_seq
            FROM date_dim
            WHERE d_year = 2002 AND d_moy = 3
        )
        AND ss_net_paid > ItemCategoryAvg.avg_price * 1.2
    GROUP BY
        s_state
    HAVING
        COUNT(DISTINCT ss_customer_sk) >= 10
)
SELECT
    s_state,
    customer_count
FROM
    PurchasesWithHighPrice
ORDER BY
    customer_count ASC
LIMIT 100;
