SELECT T1.staff_name FROM staff AS T1 JOIN staff_department_assignments AS T2 ON T1.staff_id  =  T2.staff_id GROUP BY T2.staff_id HAVING COUNT (*)  >  1