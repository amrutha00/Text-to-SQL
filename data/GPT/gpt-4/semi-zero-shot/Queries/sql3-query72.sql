SELECT
    i_item_desc AS item_description,
    w_warehouse_name AS warehouse_name,
    dd_week_seq AS week_sequence,
    SUM(CASE WHEN s_promo_id IS NOT NULL THEN 1 ELSE 0 END) AS sales_with_promotions,
    SUM(CASE WHEN s_promo_id IS NULL THEN 1 ELSE 0 END) AS sales_without_promotions
FROM
    store_sales,
    item,
    warehouse,
    date_dim,
    store,
    household_demographics
WHERE
    store_sales.s_item_sk = item.i_item_sk
    AND store_sales.s_warehouse_sk = warehouse.w_warehouse_sk
    AND store_sales.s_sold_date_sk = date_dim.d_date_sk
    AND store_sales.s_store_sk = store.s_store_sk
    AND store_sales.s_hdemo_sk = household_demographics.hd_demo_sk
    AND date_dim.d_year = 2002
    AND date_dim.d_date < DATE_ADD('day', 5, date_dim.d_date)
    AND item.i_current_price < item.i_wholesale_cost
    AND household_demographics.hd_buy_potential = '501-1000'
    AND household_demographics.hd_marital_status = 'W'
GROUP BY
    item_description,
    warehouse_name,
    week_sequence
ORDER BY
    (sales_with_promotions + sales_without_promotions) DESC,
    item_description,
    warehouse_name,
    week_sequence
LIMIT 100;
