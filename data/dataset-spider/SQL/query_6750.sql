SELECT T1.fname ,  T1.lname FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor WHERE T2.fname  =  "Linda" AND T2.lname  =  "Smith"