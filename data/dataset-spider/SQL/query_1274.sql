SELECT T1.apt_number FROM Apartments AS T1 JOIN View_Unit_Status AS T2 ON T1.apt_id  =  T2.apt_id WHERE T2.available_yn  =  0 INTERSECT SELECT T1.apt_number FROM Apartments AS T1 JOIN View_Unit_Status AS T2 ON T1.apt_id  =  T2.apt_id WHERE T2.available_yn  =  1