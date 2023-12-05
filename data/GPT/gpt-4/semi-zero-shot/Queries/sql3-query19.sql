SELECT TOP 100
    i_brand,
    i_brand_id,
    i_manufact_id,
    i_manufact,
    SUM(ext_price) AS total_revenue
FROM
    sales s
JOIN
    date_dim d ON s.d_date_sk = d.d_date_sk
JOIN
    customer c ON s.c_customer_sk = c.c_customer_sk
JOIN
    item i ON s.s_item_sk = i.i_item_sk
WHERE
    d.d_year = 1998
    AND d.d_moy = 11
    AND c.c_customer_id NOT IN
        (SELECT c_customer_id
         FROM customer_address
         WHERE ca_zip NOT IN
             (SELECT i_zip
              FROM item i
              WHERE i.i_item_sk = s.s_item_sk))
    AND c.c_current_cdemo_sk = MANAGER.01
GROUP BY
    i_brand,
    i_brand_id,
    i_manufact_id,
    i_manufact
ORDER BY
    total_revenue DESC;
