SELECT T3.Name ,  T2.Name FROM news_report AS T1 JOIN event AS T2 ON T1.Event_ID  =  T2.Event_ID JOIN journalist AS T3 ON T1.journalist_ID  =  T3.journalist_ID ORDER BY T2.Event_Attendance ASC