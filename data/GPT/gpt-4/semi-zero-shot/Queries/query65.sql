WITH StoreAvgRevenue AS (
    SELECT
        ss_store_sk,
        AVG(ss_net_paid) AS avg_revenue
    FROM
        store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    WHERE
        d_month_seq BETWEEN 1221 AND 1232
    GROUP BY
        ss_store_sk
)

SELECT
    s.s_store_name,
    i.i_description,
    SUM(ss.ss_net_paid) AS revenue,
    i.i_current_price,
    i.i_wholesale_cost,
    i.i_brand,
    d.d_month_seq
FROM
    store_sales ss
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN item i ON ss.ss_item_sk = i.i_item_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
JOIN StoreAvgRevenue sar ON ss.ss_store_sk = sar.ss_store_sk
WHERE
    d_month_seq BETWEEN 1221 AND 1232
    AND ss.ss_net_paid < 0.1 * sar.avg_revenue
GROUP BY
    s.s_store_name, i.i_description, i.i_current_price, i.i_wholesale_cost, i.i_brand, d.d_month_seq
ORDER BY
    s.s_store_name, i.i_description
LIMIT 100;
