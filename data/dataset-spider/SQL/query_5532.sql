SELECT T1.product_name ,  T2.color_description ,  T1.product_description FROM products AS T1 JOIN Ref_colors AS T2 ON T1.color_code  =  T2.color_code WHERE product_category_code  =  "Herbs"