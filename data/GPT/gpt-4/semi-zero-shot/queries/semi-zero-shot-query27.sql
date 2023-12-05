SELECT
    i_item_id AS item_id,
    s_state AS state,
    ROLLUP(s_state) AS state_rollup,
    AVG(ss_quantity) AS avg_quantity,
    AVG(ss_list_price) AS avg_list_price,
    AVG(ss_sales_price) AS avg_sales_price,
    AVG(ss_coupon_amt) AS avg_coupon_amount
FROM
    store_sales
JOIN
    item ON ss_item_sk = i_item_sk
JOIN
    customer ON ss_customer_sk = c_customer_sk
JOIN
    date_dim ON ss_sold_date_sk = d_date_sk
JOIN
    store ON ss_store_sk = s_store_sk
WHERE
    (d_year = 1999) AND
    (s_state IN ('MO', 'AL', 'MI', 'TN', 'LA', 'SC')) AND
    (c_marital_status = 'D') AND
    (c_education_status = '2nd Cycle')
GROUP BY
    i_item_id, s_state
ORDER BY
    item_id, state
LIMIT 100;
