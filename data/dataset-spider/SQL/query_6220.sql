SELECT T1.name ,  T1.area ,  T1.population FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID  =  T2.Country_ID WHERE T2.speed  >  60 INTERSECT SELECT T1.name ,  T1.area ,  T1.population FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID  =  T2.Country_ID WHERE T2.speed  <  55