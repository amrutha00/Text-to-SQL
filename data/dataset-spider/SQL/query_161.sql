SELECT date ,  zip_code FROM weather WHERE min_dew_point_f  <  (SELECT min(min_dew_point_f) FROM weather WHERE zip_code  =  94107)