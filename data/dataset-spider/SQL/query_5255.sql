SELECT TYPE FROM vocals AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id WHERE firstname  =  "Solveig" GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1