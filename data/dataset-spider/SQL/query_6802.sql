SELECT T1.stuid FROM participates_in AS T1 JOIN activity AS T2 ON T2.actid  =  T2.actid WHERE T2.activity_name  =  'Canoeing' INTERSECT SELECT T1.stuid FROM participates_in AS T1 JOIN activity AS T2 ON T2.actid  =  T2.actid WHERE T2.activity_name  =  'Kayaking'