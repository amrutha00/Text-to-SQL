SELECT count(*) ,  T2.product_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id GROUP BY T2.product_id