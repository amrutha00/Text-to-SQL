SELECT T1.address_line_1 FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id WHERE T2.course_name  =  "operating system" OR T2.course_name  =  "data structure"