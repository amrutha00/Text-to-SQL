SELECT T2.bname FROM loan AS T1 JOIN bank AS T2 ON T1.branch_id  =  T2.branch_id JOIN customer AS T3 ON T1.cust_id  =  T3.cust_id WHERE T3.credit_score  <  100