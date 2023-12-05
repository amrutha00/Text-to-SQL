SELECT i.i_item_id, i.i_item_desc, i.i_category, i.i_class, i.i_current_price,
       SUM(ws.ws_sales_price) / total_class_sales.total_sales AS revenueratio
FROM web_sales ws
JOIN item i ON ws.ws_item_sk = i.i_item_sk
JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
JOIN (
    SELECT i_class, SUM(ws_sales_price) AS total_sales
    FROM web_sales ws
    JOIN item i ON ws.ws_item_sk = i.i_item_sk
    JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
    WHERE d.d_date BETWEEN '1998-04-06' AND '1998-05-06'
    GROUP BY i_class
) total_class_sales ON i.i_class = total_class_sales.i_class
WHERE i.i_category IN ('Books', 'Sports', 'Men')
  AND d.d_date BETWEEN '1998-04-06' AND '1998-05-06'
GROUP BY i.i_item_id, i.i_item_desc, i.i_category, i.i_class, i.i_current_price, total_class_sales.total_sales
ORDER BY i.i_category, i.i_class, i.i_item_id, i.i_item_desc, revenueratio
LIMIT 100;