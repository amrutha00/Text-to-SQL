SELECT product_id FROM order_items GROUP BY product_id ORDER BY count(*) DESC LIMIT 1