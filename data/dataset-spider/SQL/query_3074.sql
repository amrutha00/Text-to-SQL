SELECT DISTINCT T1.cust_name ,  T1.credit_score FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id  =  T2.cust_id