SELECT T3.venue FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city JOIN MATCH AS T3 ON T2.match_id = T3.match_id WHERE T1.city = "Nanjing ( Jiangsu )" AND T3.competition = "1994 FIFA World Cup qualification"