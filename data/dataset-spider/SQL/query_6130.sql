SELECT t2.product_details FROM order_items AS t1 JOIN products AS t2 ON t1.product_id  =  t2.product_id GROUP BY t1.product_id ORDER BY count(*) DESC LIMIT 1