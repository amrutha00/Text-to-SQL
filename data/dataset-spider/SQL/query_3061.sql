SELECT sum(amount) ,  T1.bname FROM bank AS T1 JOIN loan AS T2 ON T1.branch_id  =  T2.branch_id GROUP BY T1.bname