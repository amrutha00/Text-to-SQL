SELECT T1.response_received_date FROM Documents AS T1 JOIN Document_Types AS T2 ON T1.document_type_code  =  T2.document_type_code JOIN Grants AS T3 ON T1.grant_id  =  T3.grant_id WHERE T2.document_description  =  'Regular' OR T3.grant_amount  >  100