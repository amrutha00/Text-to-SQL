SELECT Date_Claim_Made FROM Claims WHERE Amount_Settled  <=  ( SELECT avg(Amount_Settled) FROM Claims )