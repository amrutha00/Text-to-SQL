WITH WebSalesCounts AS (
    SELECT
        ws.c_customer_id,
        ws.ws_item_sk,
        SUM(CASE
            WHEN tw.hour = 10 THEN 1
            ELSE 0
        END) AS morning_sales,
        SUM(CASE
            WHEN tw.hour = 16 THEN 1
            ELSE 0
        END) AS evening_sales
    FROM
        web_sales ws
    JOIN
        time_dim tw ON ws.ws_sold_time_sk = tw.time_id
    WHERE
        tw.hour IN (10, 16) -- 10 AM and 4 PM
    GROUP BY
        ws.c_customer_id, ws.ws_item_sk
),
FilteredWebSales AS (
    SELECT
        wcs.c_customer_id,
        wcs.ws_item_sk,
        SUM(CASE
            WHEN wschar.ws_web_site_char_count >= 5000 AND wschar.ws_web_site_char_count <= 5200 THEN 1
            ELSE 0
        END) AS content_filtered_sales
    FROM
        WebSalesCounts wcs
    JOIN
        web_sales wschar ON wcs.ws_item_sk = wschar.ws_item_sk
    WHERE
        wschar.ws_sold_time_sk IN (SELECT time_id FROM time_dim WHERE hour IN (10, 16))
    GROUP BY
        wcs.c_customer_id, wcs.ws_item_sk
),
CustomerDependentCounts AS (
    SELECT
        fws.c_customer_id,
        c.c_dep_count AS dependents,
        fws.content_filtered_sales
    FROM
        FilteredWebSales fws
    JOIN
        customer c ON fws.c_customer_id = c.c_customer_sk
),
Ratios AS (
    SELECT
        dependents,
        SUM(CASE
            WHEN tw.hour = 10 THEN content_filtered_sales
            ELSE 0
        END) AS morning_sales,
        SUM(CASE
            WHEN tw.hour = 16 THEN content_filtered_sales
            ELSE 0
        END) AS evening_sales
    FROM
        CustomerDependentCounts
    JOIN
        time_dim tw ON tw.time_id IN (SELECT time_id FROM time_dim WHERE hour IN (10, 16))
    GROUP BY
        dependents
)
SELECT
    dependents,
    morning_sales,
    evening_sales,
    CASE
        WHEN evening_sales = 0 THEN NULL
        ELSE CAST(morning_sales AS DECIMAL) / evening_sales
    END AS sales_ratio
FROM
    Ratios
ORDER BY
    sales_ratio DESC
LIMIT 100;
