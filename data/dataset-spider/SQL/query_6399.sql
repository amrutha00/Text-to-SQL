SELECT T1.statement_id ,  T2.statement_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id  =  T2.statement_id GROUP BY T1.statement_id ORDER BY count(*) DESC LIMIT 1