SELECT T1.customer_name FROM customers AS T1 JOIN orders AS T2 JOIN order_items AS T3 JOIN products AS T4 ON T1.customer_id = T2.customer_id AND T2.order_id = T3.order_id AND T3.product_id = T4.product_id WHERE T3.order_item_status = "Cancel" AND T4.product_name = "food" GROUP BY T1.customer_id HAVING count(*)  >=  1