SELECT name FROM building EXCEPT SELECT T1.name FROM building AS T1 JOIN institution AS T2 ON T1.building_id  =  T2.building_id WHERE T2.founded  =  2003