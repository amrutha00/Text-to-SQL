SELECT
    s.s_store_name AS store_name,
    i.i_item_desc AS item_description,
    SUM(ws.ws_ext_sales_price) AS revenue,
    i.i_current_price AS current_price,
    i.i_wholesale_cost AS wholesale_cost,
    i.i_brand AS brand,
    ws.ws_sold_date_sk AS month_sequence
FROM
    store_sales AS ws
JOIN
    store AS s ON ws.ws_store_sk = s.s_store_sk
JOIN
    item AS i ON ws.ws_item_sk = i.i_item_sk
WHERE
    ws.ws_sold_date_sk BETWEEN 1221 AND (1221 + 11)
GROUP BY
    s.s_store_name,
    i.i_item_desc,
    i.i_current_price,
    i.i_wholesale_cost,
    i.i_brand,
    ws.ws_sold_date_sk
HAVING
    SUM(ws.ws_ext_sales_price) < 0.1 * AVG(ws.ws_ext_sales_price)
ORDER BY
    s.s_store_name,
    i.i_item_desc
LIMIT 100;
