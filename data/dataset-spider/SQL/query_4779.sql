SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN order_items AS T3 ON T2.order_id  =  T3.order_id JOIN products AS T4 ON T3.product_id  =  T4.product_id WHERE T4.product_name  =  "keyboard"