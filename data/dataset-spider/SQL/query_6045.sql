SELECT gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid  =  T2.gameid GROUP BY T1.gameid ORDER BY sum(hours_played) DESC LIMIT 1