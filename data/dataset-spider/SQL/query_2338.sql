SELECT campusfee FROM campuses AS T1 JOIN csu_fees AS T2 ON T1.id  =  t2.campus WHERE t1.campus  =  "San Jose State University" AND T2.year  =  1996