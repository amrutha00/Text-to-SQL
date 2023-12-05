SELECT
    i_manager_id,
    EXTRACT(YEAR FROM d_date) AS year,
    EXTRACT(MONTH FROM d_date) AS month,
    SUM(s_sales_price) AS sum_sales,
    AVG(SUM(s_sales_price)) OVER (PARTITION BY i_manager_id, EXTRACT(YEAR FROM d_date), EXTRACT(MONTH FROM d_date)) AS avg_monthly_sales
FROM
    store_sales
JOIN
    date_dim ON store_sales.d_date = date_dim.d_date
JOIN
    item ON store_sales.s_item_id = item.i_item_id
WHERE
    i_category IN ('Books', 'Children', 'Electronics', 'Women', 'Music', 'Men')
    AND i_class IN ('personal', 'portable', 'reference', 'self-help', 'accessories', 'classical', 'fragrances', 'pants')
    AND i_brand IN ('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9', 'amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1')
    AND EXTRACT(YEAR FROM d_date) = specific_year
GROUP BY
    i_manager_id,
    EXTRACT(YEAR FROM d_date),
    EXTRACT(MONTH FROM d_date)
HAVING
    AVG(SUM(s_sales_price)) > 0
    AND (SUM(s_sales_price) - AVG(SUM(s_sales_price)) > 0.1 * AVG(SUM(s_sales_price))
ORDER BY
    i_manager_id,
    avg_monthly_sales,
    sum_sales
LIMIT 100;
