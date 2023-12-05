WITH ChannelReturns AS (
    SELECT
        cr.item_id,
        SUM(cr.return_quantity) AS catalog_return_quantity,
        SUM(sr.return_quantity) AS store_return_quantity,
        SUM(wr.return_quantity) AS web_return_quantity
    FROM
        catalog_returns cr
    JOIN
        store_returns sr
    ON
        cr.item_id = sr.item_id
    JOIN
        web_returns wr
    ON
        cr.item_id = wr.item_id
    WHERE
        cr.return_date BETWEEN '2001-06-06' AND '2001-11-11'
    GROUP BY
        cr.item_id
)
SELECT
    cr.item_id,
    cr.store_return_quantity
FROM
    ChannelReturns cr
WHERE
    ABS(cr.catalog_return_quantity - cr.store_return_quantity) / NULLIF(cr.catalog_return_quantity, 0) <= 0.1
    AND ABS(cr.store_return_quantity - cr.web_return_quantity) / NULLIF(cr.store_return_quantity, 0) <= 0.1
    AND ABS(cr.catalog_return_quantity - cr.web_return_quantity) / NULLIF(cr.catalog_return_quantity, 0) <= 0.1
ORDER BY
    cr.item_id,
    cr.store_return_quantity DESC
LIMIT 100;
