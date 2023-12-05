WITH FirstMonth AS (
    SELECT
        s.warehouse_id,
        s.item_id,
        s.month_id AS first_month,
        AVG(s.sales) AS mean,
        STDDEV_SAMP(s.sales) / NULLIFZERO(AVG(s.sales)) AS coefficient_of_variation
    FROM
        sales s
    WHERE
        s.year_id = 1998
    GROUP BY
        s.warehouse_id,
        s.item_id,
        s.month_id
    HAVING
        MAX(s.month_id) - MIN(s.month_id) = 1
),
SecondMonth AS (
    SELECT
        s.warehouse_id,
        s.item_id,
        s.month_id AS second_month
    FROM
        sales s
    WHERE
        s.year_id = 1998
),
ItemsWithHighCoV AS (
    SELECT
        f.warehouse_id,
        f.item_id,
        f.first_month,
        f.mean,
        f.coefficient_of_variation
    FROM
        FirstMonth f
    WHERE
        f.coefficient_of_variation > 1.5
)
SELECT
    i.warehouse_id,
    i.item_id,
    i.first_month AS month,
    i.mean,
    i.coefficient_of_variation
FROM
    ItemsWithHighCoV i
UNION ALL
SELECT
    s.warehouse_id,
    s.item_id,
    s.second_month AS month,
    0.0 AS mean,
    0.0 AS coefficient_of_variation
FROM
    SecondMonth s
ORDER BY
    i.warehouse_id,
    i.item_id,
    i.first_month,
    i.mean,
    i.coefficient_of_variation;
