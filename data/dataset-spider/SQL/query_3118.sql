SELECT T2.cell_mobile_number FROM Student_Addresses AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id ORDER BY T1.monthly_rental ASC LIMIT 1