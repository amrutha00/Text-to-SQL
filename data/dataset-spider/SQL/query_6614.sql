SELECT T2.name ,  T3.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id  =  T2.station_id JOIN train AS T3 ON T3.train_id  =  T1.train_id