SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age  >  40) EXCEPT SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age  <  30)