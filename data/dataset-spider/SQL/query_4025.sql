SELECT Name FROM ship WHERE Ship_ID NOT IN (SELECT Ship_ID FROM mission)