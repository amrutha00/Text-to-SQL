SELECT
    c_last_name AS customer_last_name,
    c_first_name AS customer_first_name,
    COUNT(i_item_sk) AS item_count
FROM
    customer,
    store_sales,
    date_dim,
    store,
    item,
    household_demographics,
    household_demographics hd2,
    household_demographics hd3
WHERE
    customer.c_customer_sk = store_sales.ss_customer_sk
    AND store_sales.ss_sold_date_sk = date_dim.d_date_sk
    AND store_sales.ss_store_sk = store.s_store_sk
    AND store_sales.ss_item_sk = item.i_item_sk
    AND customer.c_current_hdemo_sk = household_demographics.hd_demo_sk
    AND customer.c_current_hdemo_sk = hd2.hd_demo_sk
    AND customer.c_current_hdemo_sk = hd3.hd_demo_sk
    AND date_dim.d_year IN (2000, 2001, 2002)
    AND date_dim.d_moy BETWEEN 1 AND 5
    AND date_dim.d_dom BETWEEN 1 AND 2
    AND household_demographics.hd_buy_potential IN ('501-1000', '1001-1500', '1501-2000')
    AND (hd2.hd_vehicle_count / hd3.hd_dep_count) > 1
    AND store.s_county IN ('Fairfield County', 'Walker County', 'Daviess County', 'Barrow County')
GROUP BY
    customer_last_name,
    customer_first_name
ORDER BY
    item_count DESC,
    customer_last_name ASC;
