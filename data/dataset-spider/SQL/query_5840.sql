SELECT T2.Author FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID  =  T2.Submission_ID GROUP BY T2.Author HAVING COUNT(DISTINCT T1.workshop_id)  >  1