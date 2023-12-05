SELECT T2.customer_name FROM mailshot_customers AS T1 JOIN customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE outcome_code  =  'Order' GROUP BY T1.customer_id HAVING count(*)  >=  2