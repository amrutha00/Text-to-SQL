SELECT T3.Player_name ,  T3.gender FROM player_coach AS T1 JOIN coach AS T2 ON T1.Coach_ID  =  T2.Coach_ID JOIN player AS T3 ON T1.Player_ID  =  T3.Player_ID WHERE T1.Starting_year  >  2011