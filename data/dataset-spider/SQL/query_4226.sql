SELECT T1.date_in_location_from ,  T1.date_in_locaton_to FROM Document_locations AS T1 JOIN All_documents AS T2 ON T1.document_id  =  T2.document_id WHERE T2.document_name  =  "Robin CV"