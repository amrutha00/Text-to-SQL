SELECT T2.name ,  count(*) FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id GROUP BY T1.track_id