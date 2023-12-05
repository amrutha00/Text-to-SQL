SELECT item_sk, d_date, web_cumulative, store_cumulative
FROM (
  SELECT ws.ws_item_sk AS item_sk, dd.d_date AS d_date, 
    SUM(ws.ws_sales_price) OVER (PARTITION BY ws.ws_item_sk, dd.d_date 
    ORDER BY ws.ws_sold_date_sk, ws.ws_sold_time_sk) AS web_cumulative,
    SUM(ss.ss_sales_price) OVER (PARTITION BY ss.ss_item_sk, dd.d_date 
    ORDER BY ss.ss_sold_date_sk, ss.ss_sold_time_sk) AS store_cumulative
  FROM web_sales ws
  JOIN date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk
  JOIN store_sales ss ON ws.ws_item_sk = ss.ss_item_sk
  WHERE ws.ws_sold_date_sk BETWEEN start_date_sk AND end_date_sk
    AND ws.ws_quantity > 0
    AND ss.ss_quantit > 0
) t
WHERE web_cumulative > store_cumulative
ORDER BY item_sk, d_date
LIMIT 100;