SELECT LName FROM Student WHERE age  =  (SELECT min(age) FROM Student)