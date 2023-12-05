-- Step 1: Create temporary tables ssci and csci for store and catalog sales data
CREATE TEMP TABLE ssci AS
SELECT
    s.customer_id,
    s.item_id
FROM
    store_sales s
WHERE
    s.sale_date >= '2014-12-01'
    AND s.sale_date <= '2015-11-30';

CREATE TEMP TABLE csci AS
SELECT
    c.customer_id,
    c.item_id
FROM
    catalog_sales c
WHERE
    c.sale_date >= '2014-12-01'
    AND c.sale_date <= '2015-11-30';

-- Step 2: Calculate counts based on different conditions
-- store_only
CREATE TEMP TABLE store_only AS
SELECT
    COUNT(*) AS store_only_count
FROM
    ssci
LEFT JOIN
    csci ON ssci.customer_id = csci.customer_id AND ssci.item_id = csci.item_id
WHERE
    csci.customer_id IS NULL;

-- catalog_only
CREATE TEMP TABLE catalog_only AS
SELECT
    COUNT(*) AS catalog_only_count
FROM
    csci
LEFT JOIN
    ssci ON csci.customer_id = ssci.customer_id AND csci.item_id = ssci.item_id
WHERE
    ssci.customer_id IS NULL;

-- store_and_catalog
CREATE TEMP TABLE store_and_catalog AS
SELECT
    COUNT(*) AS store_and_catalog_count
FROM
    ssci
JOIN
    csci ON ssci.customer_id = csci.customer_id AND ssci.item_id = csci.item_id;

-- Step 3: Perform a full outer join between ssci and csci tables and limit to 100 rows
CREATE TEMP TABLE full_outer_join AS
SELECT
    ssci.customer_id,
    ssci.item_id,
    CASE
        WHEN csci.customer_id IS NULL THEN 'store_only'
        WHEN ssci.customer_id IS NULL THEN 'catalog_only'
        ELSE 'store_and_catalog'
    END AS sale_type
FROM
    ssci
FULL OUTER JOIN
    csci ON ssci.customer_id = csci.customer_id AND ssci.item_id = csci.item_id
LIMIT 100;

-- Step 4: Calculate promotional sales and total sales counts and their ratio
SELECT
    sale_type,
    COUNT(*) AS sales_count,
    SUM(CASE WHEN sale_type = 'store_only' THEN 1 ELSE 0 END) AS promotional_sales_count,
    SUM(CASE WHEN sale_type = 'store_and_catalog' THEN 1 ELSE 0 END) AS total_sales_count,
    CAST(SUM(CASE WHEN sale_type = 'store_only' THEN 1 ELSE 0 END) AS DECIMAL) / CAST(COUNT(*) AS DECIMAL) AS sales_ratio
FROM
    full_outer_join
GROUP BY
    sale_type;
