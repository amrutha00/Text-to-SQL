SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid JOIN band AS T3 ON T1.bandmate  =  T3.id WHERE T3.lastname  =  "Heilo" AND T2.title  =  "Der Kapitan"