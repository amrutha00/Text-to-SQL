SELECT T2.party_name ,  count(*) FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id