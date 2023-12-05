SELECT T1.company_id ,  T1.company_name FROM Third_Party_Companies AS T1 JOIN Maintenance_Engineers AS T2 ON T1.company_id  =  T2.company_id GROUP BY T1.company_id HAVING count(*)  >=  2 UNION SELECT T3.company_id ,  T3.company_name FROM Third_Party_Companies AS T3 JOIN Maintenance_Contracts AS T4 ON T3.company_id  =  T4.maintenance_contract_company_id GROUP BY T3.company_id HAVING count(*)  >=  2