SELECT sum(T2.Killed) FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Height  >  1.84