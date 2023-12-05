SELECT count(*) ,  T1.fault_log_entry_id FROM Fault_Log AS T1 JOIN Engineer_Visits AS T2 ON T1.fault_log_entry_id  =  T2.fault_log_entry_id GROUP BY T1.fault_log_entry_id ORDER BY count(*) DESC LIMIT 1