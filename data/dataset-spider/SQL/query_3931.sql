SELECT T1.name FROM physician AS T1 JOIN patient AS T2 ON T1.employeeid  =  T2.PCP GROUP BY T1.employeeid HAVING count(*)  >  1