SELECT avg(room_count) FROM Apartment_Bookings AS T1 JOIN Apartments AS T2 ON T1.apt_id  =  T2.apt_id WHERE T1.booking_status_code  =  "Provisional"