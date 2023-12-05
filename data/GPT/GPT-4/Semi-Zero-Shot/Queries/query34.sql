SELECT c.customer_last_name,
       c.customer_first_name,
       c.customer_salutation,
       c.customer_preferred_flag,
       ss.ss_ticket_number
FROM customer c
JOIN store_sales ss ON c.customer_sk = ss.ss_customer_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
WHERE (c.customer_dependent_count / NULLIF(c.customer_vehicle_count, 0)) > 1.2
      AND (d.d_day_of_month BETWEEN 1 AND 5 OR d.d_day_of_month BETWEEN 26 AND 31)
      AND d.d_year BETWEEN (EXTRACT(YEAR FROM CURRENT_DATE) - 3) AND EXTRACT(YEAR FROM CURRENT_DATE)
      AND s.s_county_sk IN ( /* Replace with IDs or names of the eight specific counties */ )
      AND ss.ss_quantity BETWEEN 15 AND 20
GROUP BY c.customer_sk, ss.ss_ticket_number
HAVING COUNT(DISTINCT EXTRACT(MONTH FROM d.d_date)) = 3
ORDER BY c.customer_last_name DESC,
         c.customer_first_name DESC,
         c.customer_salutation DESC,
         c.customer_preferred_flag DESC,
         ss.ss_ticket_number;
