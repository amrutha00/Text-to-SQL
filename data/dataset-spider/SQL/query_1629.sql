SELECT count(*) FROM products WHERE product_id NOT IN ( SELECT product_id FROM Order_items )