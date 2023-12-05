SELECT
    i_item_id AS item_id,
    i_item_desc AS item_description,
    s_state AS state,
    SUM(CASE WHEN d_year = 2001 AND d_qoy = 1 THEN ss_quantity ELSE 0 END) AS first_quarter_store_sales,
    SUM(CASE WHEN d_year = 2001 AND d_qoy BETWEEN 2 AND 4 THEN ss_quantity ELSE 0 END) AS subsequent_quarters_store_returns,
    SUM(CASE WHEN d_year = 2001 AND d_qoy BETWEEN 5 AND 7 THEN cs_quantity ELSE 0 END) AS following_quarters_catalog_sales,
    COUNT(*) AS records_count,
    AVG(ss_quantity) AS avg_store_sales_quantity,
    AVG(cs_quantity) AS avg_catalog_sales_quantity,
    AVG(ss_quantity - cs_quantity) AS avg_sales_difference,
    STDDEV_SAMP(ss_quantity) AS std_dev_store_sales_quantity,
    STDDEV_SAMP(cs_quantity) AS std_dev_catalog_sales_quantity
FROM
    store_sales
JOIN
    item ON (ss_item_sk = i_item_sk)
JOIN
    store ON (ss_store_sk = s_store_sk)
JOIN
    date_dim ON (ss_sold_date_sk = d_date_sk)
JOIN
    catalog_sales ON (cs_item_sk = i_item_sk)
WHERE
    (d_year = 2001 AND d_qoy = 1)
    AND ss_quantity > 0
    AND cs_quantity > 0
GROUP BY
    i_item_id, i_item_desc, s_state
ORDER BY
    item_id, item_description, state
LIMIT 100;
