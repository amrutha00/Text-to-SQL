SELECT T2.first_name ,  T2.last_name FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T1.city = "Damianfort";