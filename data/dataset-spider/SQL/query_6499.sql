SELECT count(*) ,  T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code  =  T2.project WHERE T1.hours  >  300 GROUP BY T1.name