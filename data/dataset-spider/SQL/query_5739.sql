SELECT count(*) ,  T1.dormid FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid WHERE T1.student_capacity  >  100 GROUP BY T1.dormid