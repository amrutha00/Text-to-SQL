SELECT T1.theme ,  T2.name FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id  =  T2.artist_id WHERE T1.ticket_price  >  (SELECT avg(ticket_price) FROM exhibition)