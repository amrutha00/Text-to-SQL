-- Step 1: Calculate sales data for both 1998 and 1999 by brand, class, and category
WITH sales_data AS (
    SELECT
        d_year AS year,
        p_brand AS brand,
        p_class AS class,
        p_category AS category,
        p_manufacturer AS manufacturer,
        SUM(CASE WHEN ss_sold_date_sk IS NOT NULL THEN 1 ELSE 0 END) AS sales_count,
        SUM(CASE WHEN ss_sold_date_sk IS NOT NULL THEN ss_net_paid ELSE 0 END) AS sales_amount
    FROM
        date_dim,
        product,
        store_sales
    WHERE
        d_year IN (1998, 1999)
        AND d_date_sk = ss_sold_date_sk
        AND product.p_product_sk = ss_item_sk
        AND p_category = 'Home'
    GROUP BY
        year, brand, class, category, manufacturer
),
-- Step 2: Compare sales data for 1999 with 1998
sales_comparison AS (
    SELECT
        curr_yr.year AS curr_year,
        curr_yr.brand,
        curr_yr.class,
        curr_yr.category,
        curr_yr.manufacturer,
        curr_yr.sales_count AS curr_yr_sales_count,
        prev_yr.sales_count AS prev_yr_sales_count,
        (curr_yr.sales_count - prev_yr.sales_count) AS sales_count_diff,
        (curr_yr.sales_amount - prev_yr.sales_amount) AS sales_amount_diff
    FROM
        sales_data curr_yr
    JOIN
        sales_data prev_yr ON curr_yr.brand = prev_yr.brand
        AND curr_yr.class = prev_yr.class
        AND curr_yr.category = prev_yr.category
        AND curr_yr.manufacturer = prev_yr.manufacturer
        AND curr_yr.year = 1999
        AND prev_yr.year = 1998
)
-- Step 3: Select and order the results
SELECT
    curr_year,
    brand,
    class,
    category,
    manufacturer,
    curr_yr_sales_count,
    prev_yr_sales_count,
    sales_count_diff,
    sales_amount_diff
FROM
    sales_comparison
WHERE
    CAST(curr_yr_sales_count AS DECIMAL(17, 2)) / CAST(prev_yr_sales_count AS DECIMAL(17, 2)) < 0.9
ORDER BY
    sales_count_diff ASC,
    sales_amount_diff ASC
LIMIT 100;
