SELECT count(*) FROM department_stores AS T1 JOIN department_store_chain AS T2 ON T1.dept_store_chain_id  =  T2.dept_store_chain_id WHERE T2.dept_store_chain_name  =  "South"