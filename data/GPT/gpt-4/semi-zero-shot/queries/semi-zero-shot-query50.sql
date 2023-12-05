SELECT
    s.store_name,
    s.company_id,
    s.address_details,
    s.zip_code,
    SUM(CASE
        WHEN sr.returned_date_sk - ss.date_sk <= 30 THEN 1
        ELSE 0
    END) AS "30 days",
    SUM(CASE
        WHEN sr.returned_date_sk - ss.date_sk > 30
             AND sr.returned_date_sk - ss.date_sk <= 60 THEN 1
        ELSE 0
    END) AS "31-60 days",
    SUM(CASE
        WHEN sr.returned_date_sk - ss.date_sk > 60
             AND sr.returned_date_sk - ss.date_sk <= 90 THEN 1
        ELSE 0
    END) AS "61-90 days",
    SUM(CASE
        WHEN sr.returned_date_sk - ss.date_sk > 90
             AND sr.returned_date_sk - ss.date_sk <= 120 THEN 1
        ELSE 0
    END) AS "91-120 days",
    SUM(CASE
        WHEN sr.returned_date_sk - ss.date_sk > 120 THEN 1
        ELSE 0
    END) AS ">120 days"
FROM
    store_sales ss
JOIN
    store_returns sr
ON
    ss.ss_item_sk = sr.sr_item_sk
JOIN
    store s
ON
    ss.ss_store_sk = s.s_store_sk
JOIN
    date_dim d
ON
    ss.ss_sold_date_sk = d.d_date_sk
WHERE
    d.d_year = 2001
    AND d.d_moy = 8
GROUP BY
    s.store_name,
    s.company_id,
    s.address_details,
    s.zip_code
ORDER BY
    s.store_name,
    s.company_id,
    s.address_details,
    s.zip_code
LIMIT 100;
