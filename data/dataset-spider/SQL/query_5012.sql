SELECT avg(T1.HS) ,  max(T1.HS) FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'yes'