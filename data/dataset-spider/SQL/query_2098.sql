SELECT Pilot_name FROM pilot WHERE Pilot_ID NOT IN (SELECT Pilot_ID FROM pilot_record)