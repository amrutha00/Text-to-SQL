SELECT name FROM physician EXCEPT SELECT T2.name FROM appointment AS T1 JOIN physician AS T2 ON T1.Physician  =  T2.EmployeeID