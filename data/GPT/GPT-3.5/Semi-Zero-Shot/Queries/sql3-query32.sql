-- Create a temporary table 'ss' to compute total store sales for each county, quarter, and year.
CREATE TEMP TABLE ss AS
SELECT
    c_county AS county,
    s_year AS year,
    s_qtr AS quarter,
    SUM(s_sales_price) AS total_store_sales
FROM
    store_sales
WHERE
    s_year = 2000
    AND s_qtr BETWEEN 1 AND 3
    AND s_sales_price > 0
GROUP BY
    c_county, s_year, s_qtr;

-- Create a temporary table 'ws' to compute total web sales for each county, quarter, and year.
CREATE TEMP TABLE ws AS
SELECT
    c_county AS county,
    w_year AS year,
    w_qtr AS quarter,
    SUM(w_sales_price) AS total_web_sales
FROM
    web_sales
WHERE
    w_year = 2000
    AND w_qtr BETWEEN 1 AND 3
    AND w_sales_price > 0
GROUP BY
    c_county, w_year, w_qtr;

-- Now, join the 'ss' and 'ws' temporary tables to calculate growth ratios.
SELECT
    ws.county,
    ws.year,
    ws.quarter,
    CASE
        WHEN ss.total_store_sales > 0 THEN (ws.total_web_sales - ss.total_store_sales) / ss.total_store_sales
        ELSE NULL
    END AS web_store_growth_ratio
FROM
    ws
JOIN
    ss
ON
    ws.county = ss.county
    AND ws.year = ss.year
    AND ws.quarter = ss.quarter
WHERE
    ws.total_web_sales > 0
ORDER BY
    web_store_growth_ratio DESC;
