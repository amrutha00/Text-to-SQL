SELECT transaction_type_code ,  max(share_count) ,  min(share_count) FROM TRANSACTIONS GROUP BY transaction_type_code