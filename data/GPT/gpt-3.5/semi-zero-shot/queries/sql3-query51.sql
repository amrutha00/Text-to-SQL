SELECT TOP 100
    ws.item_sk,
    ws.d_date,
    ws.web_cumulative,
    ss.store_cumulative
FROM
    (
        SELECT
            web.item_sk,
            web.d_date,
            SUM(web.ws_sales_price) OVER (PARTITION BY web.item_sk, web.d_date ORDER BY web.d_date) AS web_cumulative
        FROM
            web_sales web
        WHERE
            web.ws_item_sk IN (SELECT i_item_sk FROM item WHERE i_category IN ('YourCategory1', 'YourCategory2')) -- Specify your categories
            AND web.d_date BETWEEN 'YourStartDate' AND 'YourEndDate' -- Specify your date range
    ) ws
JOIN
    (
        SELECT
            store.item_sk,
            store.d_date,
            SUM(store.ss_sales_price) OVER (PARTITION BY store.item_sk, store.d_date ORDER BY store.d_date) AS store_cumulative
        FROM
            store_sales store
        WHERE
            store.ss_item_sk IN (SELECT i_item_sk FROM item WHERE i_category IN ('YourCategory1', 'YourCategory2')) -- Specify your categories
            AND store.d_date BETWEEN 'YourStartDate' AND 'YourEndDate' -- Specify your date range
    ) ss
ON
    ws.item_sk = ss.item_sk
    AND ws.d_date = ss.d_date
WHERE
    ws.web_cumulative > ss.store_cumulative
ORDER BY
    ws.item_sk,
    ws.d_date;
