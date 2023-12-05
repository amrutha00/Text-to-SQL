SELECT
    i_item_id,
    i_item_desc,
    s_store_id,
    s_store_name,
    AVG(sales_quantity) AS avg_sold_quantity,
    AVG(returned_quantity) AS avg_returned_quantity,
    AVG(catalog_quantity) AS avg_catalog_quantity
FROM
    item i
JOIN
    store_sales s_sales
    ON i.i_item_sk = s_sales.ss_item_sk
JOIN
    store_returns s_returns
    ON s_sales.ss_sold_date_sk = s_returns.sr_returned_date_sk
JOIN
    catalog_sales c_sales
    ON s_returns.sr_customer_sk = c_sales.cs_bill_customer_sk
WHERE
    s_sales.ss_sold_date_sk BETWEEN
        (SELECT d_date_sk FROM date_dim WHERE d_year = 1999 AND d_moy = 4)
        AND
        (SELECT d_date_sk FROM date_dim WHERE d_year = 1999 AND d_moy = 10)
    AND
    c_sales.cs_sold_date_sk BETWEEN
        (SELECT d_date_sk FROM date_dim WHERE d_year = 1999 AND d_moy = 10)
        AND
        (SELECT d_date_sk FROM date_dim WHERE d_year = 2002 AND d_moy = 10)
GROUP BY
    i_item_id,
    i_item_desc,
    s_store_id,
    s_store_name
ORDER BY
    i_item_id ASC,
    i_item_desc ASC,
    s_store_id ASC,
    s_store_name ASC
LIMIT 100;
