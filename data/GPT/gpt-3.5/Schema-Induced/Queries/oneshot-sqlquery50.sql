SELECT s.s_store_name, s.s_company_id, s.s_street_number, s.s_street_name, s.s_street_type, s.s_suite_number, 
       s.s_city, s.s_county, s.s_state, s.s_zip
FROM store_sales ss
JOIN store_returns sr ON ss.ss_item_sk = sr.sr_item_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
WHERE d.d_year = 2001 AND d.d_moy = 8
GROUP BY s.s_store_sk, s.s_store_name, s.s_company_id, s.s_street_number, s.s_street_name, s.s_street_type, 
         s.s_suite_number, s.s_city, s.s_county, s.s_state, s.s_zip
ORDER BY s.s_store_sk
LIMIT 100;