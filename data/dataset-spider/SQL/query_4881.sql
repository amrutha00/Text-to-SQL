SELECT T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID  =  T2.School_ID GROUP BY T1.School_ID HAVING COUNT(*)  >  1