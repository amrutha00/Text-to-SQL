SELECT c_last_name,
       COUNT(*) AS item_count
FROM customer AS c
JOIN store_sales AS ss ON c.c_customer_sk = ss.ss_customer_sk
JOIN household_demographics AS hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
JOIN store AS s ON ss.ss_store_sk = s.s_store_sk
JOIN date_dim AS dd ON ss.ss_sold_date_sk = dd.d_date_sk
WHERE hd.hd_buy_potential = 'specific'
  AND hd.hd_dep_count / hd.hd_vehicle_count > 1
  AND ss.ss_quantity BETWEEN 1 AND 5
  AND (dd.d_year = 2000 OR dd.d_year = 2001 OR dd.d_year = 2002)
  AND s.s_county = 'Fairfield County'
    OR s.s_county = 'Walker County'
    OR s.s_county = 'Daviess County'
    OR s.s_county = 'Barrow County'
  AND dd.d_dom <= 2
GROUP BY c_last_name
ORDER BY item_count DESC, c_last_name ASC
LIMIT 100;