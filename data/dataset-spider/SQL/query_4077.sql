SELECT DISTINCT T1.firstname ,  T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.grade  =  1 EXCEPT SELECT T1.firstname ,  T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "OTHA" AND T2.lastname  =  "MOYER"