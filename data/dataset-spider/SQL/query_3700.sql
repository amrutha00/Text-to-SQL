SELECT sum(T1.games) FROM home_game AS T1 JOIN team AS T2 ON T1.team_id = T2.team_id_br WHERE T2.name = 'Boston Red Stockings' AND T1.year BETWEEN 1990 AND 2000;