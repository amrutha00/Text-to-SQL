SELECT T1.name_first , T1.name_last FROM player AS T1 JOIN player_award AS T2 WHERE T2.year  =  1960 INTERSECT SELECT T1.name_first , T1.name_last FROM player AS T1 JOIN player_award AS T2 WHERE T2.year  =  1961