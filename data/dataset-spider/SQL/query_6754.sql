SELECT T2.fname ,  T2.lname FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor WHERE T1.fname  =  "Michael" AND T1.lname  =  "Goodrich"