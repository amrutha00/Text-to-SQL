SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Le Pop"