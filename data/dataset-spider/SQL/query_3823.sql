SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name HAVING COUNT(*)  =  1