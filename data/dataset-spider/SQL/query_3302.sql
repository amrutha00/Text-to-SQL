SELECT stu_fname ,  stu_gpa FROM student WHERE stu_gpa  <  (SELECT avg(stu_gpa) FROM student)