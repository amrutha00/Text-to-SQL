SELECT T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid WHERE T2.balance  <  (SELECT avg(balance) FROM checking)