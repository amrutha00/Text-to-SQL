WITH AvgDiscount AS (
    SELECT AVG(ws.ws_ext_discount_amt) AS avg_discount
    FROM web_sales ws
    JOIN item i ON ws.ws_item_sk = i.i_item_sk
    WHERE i.i_manufacturer_id = 320
    AND ws.ws_sold_date_sk BETWEEN '2002-02-26' AND DATEADD(DAY, 89, '2002-02-26')
)

SELECT ws.ws_order_number, ws.ws_item_sk, ws.ws_ext_discount_amt, 
       (ws.ws_ext_discount_amt - ad.avg_discount) AS excess_discount
FROM web_sales ws
JOIN item i ON ws.ws_item_sk = i.i_item_sk, AvgDiscount ad
WHERE i.i_manufacturer_id = 320
AND ws.ws_sold_date_sk BETWEEN '2002-02-26' AND DATEADD(DAY, 89, '2002-02-26')
AND ws.ws_ext_discount_amt > 1.30 * ad.avg_discount
ORDER BY excess_discount DESC
LIMIT 100;
