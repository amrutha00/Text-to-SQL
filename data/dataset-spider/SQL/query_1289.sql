SELECT T2.name FROM game AS T1 JOIN stadium AS T2 ON T1.stadium_id  =  T2.id JOIN injury_accident AS T3 ON T1.id  =  T3.game_id WHERE T3.player  =  'Walter Samuel' INTERSECT SELECT T2.name FROM game AS T1 JOIN stadium AS T2 ON T1.stadium_id  =  T2.id JOIN injury_accident AS T3 ON T1.id  =  T3.game_id WHERE T3.player  =  'Thiago Motta'