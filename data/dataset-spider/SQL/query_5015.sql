SELECT max(T1.HS) ,  pPos FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T1.HS  >  1000 GROUP BY T2.pPos