SELECT product_name FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id  =  t2.product_id JOIN CHARACTERISTICS AS t3 ON t2.characteristic_id  =  t3.characteristic_id JOIN ref_colors AS t4 ON t1.color_code  =  t4.color_code WHERE t4.color_description  =  "red" AND t3.characteristic_name  =  "fast"