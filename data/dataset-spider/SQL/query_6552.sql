SELECT T2.Name FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation WHERE T1.County  =  "Monterey" AND T2.price  <  50