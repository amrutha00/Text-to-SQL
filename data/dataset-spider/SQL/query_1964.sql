SELECT T1.booking_id ,  T1.amount_of_refund FROM Bookings AS T1 JOIN Payments AS T2 ON T1.booking_id  =  T2.booking_id GROUP BY T1.booking_id ORDER BY count(*) DESC LIMIT 1