SELECT DISTINCT T2.name ,  T2.friend ,  T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.friend WHERE T1.age  >  (SELECT avg(age) FROM person)