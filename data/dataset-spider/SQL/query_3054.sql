SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id  =  T2.cust_id GROUP BY T1.cust_name ORDER BY sum(T2.amount) DESC LIMIT 1