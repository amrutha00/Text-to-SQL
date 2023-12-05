SELECT T1.asset_id ,  T1.asset_details FROM Assets AS T1 JOIN Asset_Parts AS T2 ON T1.asset_id  =  T2.asset_id GROUP BY T1.asset_id HAVING count(*)  =  2 INTERSECT SELECT T1.asset_id ,  T1.asset_details FROM Assets AS T1 JOIN Fault_Log AS T2 ON T1.asset_id  =  T2.asset_id GROUP BY T1.asset_id HAVING count(*)  <  2