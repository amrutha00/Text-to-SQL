SELECT sum(hoursperweek) ,  sum(gamesplayed) FROM Sportsinfo AS T1 JOIN Student AS T2 ON T1.StuID  =  T2.StuID WHERE T2.age  <  20