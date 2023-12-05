SELECT
    SUM(
        CASE
            WHEN ts.hour >= 8 AND ts.minute >= 30 AND ts.hour < 9 THEN ss.ss_quantity
            ELSE 0
        END
    ) AS h8_30_to_9,
    SUM(
        CASE
            WHEN ts.hour = 9 AND ts.minute < 30 THEN ss.ss_quantity
            ELSE 0
        END
    ) AS h9_to_9_30,
    SUM(
        CASE
            WHEN ts.hour = 9 AND ts.minute >= 30 AND ts.hour < 10 THEN ss.ss_quantity
            ELSE 0
        END
    ) AS h9_30_to_10,
    SUM(
        CASE
            WHEN ts.hour = 10 AND ts.minute < 30 THEN ss.ss_quantity
            ELSE 0
        END
    ) AS h10_to_10_30,
    SUM(
        CASE
            WHEN ts.hour = 10 AND ts.minute >= 30 AND ts.hour < 11 THEN ss.ss_quantity
            ELSE 0
        END
    ) AS h10_30_to_11,
    SUM(
        CASE
            WHEN ts.hour = 11 AND ts.minute < 30 THEN ss.ss_quantity
            ELSE 0
        END
    ) AS h11_to_11_30,
    SUM(
        CASE
            WHEN ts.hour = 11 AND ts.minute >= 30 AND ts.hour < 12 THEN ss.ss_quantity
            ELSE 0
        END
    ) AS h11_30_to_12
FROM store_sales ss
JOIN customer c ON ss.c_customer_id = c.c_customer_id
JOIN time_dim ts ON ss.t_time_id = ts.time_id
WHERE ss.ss_store_sk = (SELECT s.s_store_sk FROM store s WHERE s.s_store_name = 'ese')
    AND (
        (c.c_dep_count = 1 AND c.c_vehicles <= 2)
        OR (c.c_dep_count = 2 AND c.c_vehicles <= 4)
        OR (c.c_dep_count = 3 AND c.c_vehicles <= 5)
    );
