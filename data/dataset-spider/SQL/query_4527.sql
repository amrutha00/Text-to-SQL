SELECT document_name FROM documents EXCEPT SELECT t1.document_name FROM documents AS t1 JOIN document_sections AS t2 ON t1.document_code  =  t2.document_code JOIN document_sections_images AS t3 ON t2.section_id  =  t3.section_id