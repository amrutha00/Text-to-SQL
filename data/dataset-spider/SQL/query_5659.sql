SELECT product_type_code FROM products GROUP BY product_type_code HAVING count(*)  >=  2