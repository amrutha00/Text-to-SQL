SELECT DISTINCT YEAR FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID  =  T2.mID WHERE T2.stars  >=  4 ORDER BY T1.year