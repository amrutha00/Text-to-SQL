SELECT name FROM PersonFriend WHERE friend =  'Alice' AND YEAR  =  (SELECT min(YEAR) FROM PersonFriend WHERE friend =  'Alice')