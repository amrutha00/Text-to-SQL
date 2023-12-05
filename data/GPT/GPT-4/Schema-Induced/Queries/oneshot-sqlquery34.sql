SELECT c_last_name, c_first_name, c_salutation, c_preferred_cust_flag
FROM customer c
JOIN household_demographics hd ON c.c_current_cdemo_sk = hd.hd_demo_sk
JOIN store_sales ss ON c.c_customer_sk = ss.ss_customer_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
WHERE hd.hd_buy_potential = [specific buy potential criteria]
AND hd.hd_dep_count / hd.hd_vehicle_count > 1.2
AND ss.ss_quantity BETWEEN 15 AND 20
AND (
    (d.d_month_seq <= [month1] AND d.d_year = [year1])
    OR (d.d_month_seq >= [month2] AND d.d_year = [year2])
    OR (d.d_month_seq <= [month3] AND d.d_year = [year3])
)
AND s.s_county IN ([county1], [county2], [county3], [county4], [county5], [county6], [county7], [county8])
ORDER BY c_last_name DESC, c_first_name DESC, c_salutation DESC, c_preferred_cust_flag DESC, ss.ss_ticket_number ASC
LIMIT 100;