SELECT count(*) FROM routes WHERE dst_apid IN (SELECT apid FROM airports WHERE country  =  'Canada') AND src_apid IN (SELECT apid FROM airports WHERE country  =  'United States')