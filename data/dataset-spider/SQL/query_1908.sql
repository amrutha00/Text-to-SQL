SELECT T2.School_name FROM endowment AS T1 JOIN school AS T2 ON T1.school_id  =  T2.school_id WHERE T1.amount  >  8.5 GROUP BY T1.school_id HAVING count(*)  >  1