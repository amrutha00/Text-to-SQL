SELECT T1.name_first ,  T1.name_last ,  T2.player_id FROM player AS T1 JOIN manager_award AS T2 ON T1.player_id  =  T2.player_id GROUP BY T2.player_id ORDER BY count(*) DESC LIMIT 1;