SELECT T3.staff_first_name ,  T3.staff_last_name FROM problems AS T1 JOIN product AS T2 JOIN staff AS T3 ON T1.product_id = T2.product_id AND T1.reported_by_staff_id = T3.staff_id WHERE T2.product_name = "rem" EXCEPT SELECT T3.staff_first_name ,  T3.staff_last_name FROM problems AS T1 JOIN product AS T2 JOIN staff AS T3 ON T1.product_id = T2.product_id AND T1.reported_by_staff_id = T3.staff_id WHERE T2.product_name = "aut"