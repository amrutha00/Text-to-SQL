SELECT T1.campus ,  sum(T2.degrees) FROM campuses AS T1 JOIN degrees AS T2 ON T1.id  =  T2.campus WHERE T1.county  =  "Orange" AND T2.year  >=  2000 GROUP BY T1.campus