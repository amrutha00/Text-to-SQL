SELECT t1.party_email FROM parties AS t1 JOIN party_services AS t2 ON t1.party_id  =  t2.customer_id GROUP BY t1.party_email ORDER BY count(*) DESC LIMIT 1