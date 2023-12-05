SELECT
    SUBSTR(w_warehouse_name, 1, 20) AS warehouse_name,
    s_ship_mode AS shipping_mode,
    c_call_center_name AS call_center_name,
    SUM(CASE
        WHEN DATEDIFF(DAY, o_order_date, s_ship_date) <= 30 THEN 1
        ELSE 0
    END) AS within_30_days,
    SUM(CASE
        WHEN DATEDIFF(DAY, o_order_date, s_ship_date) BETWEEN 31 AND 60 THEN 1
        ELSE 0
    END) AS between_31_and_60_days,
    SUM(CASE
        WHEN DATEDIFF(DAY, o_order_date, s_ship_date) BETWEEN 61 AND 90 THEN 1
        ELSE 0
    END) AS between_61_and_90_days,
    SUM(CASE
        WHEN DATEDIFF(DAY, o_order_date, s_ship_date) BETWEEN 91 AND 120 THEN 1
        ELSE 0
    END) AS between_91_and_120_days,
    SUM(CASE
        WHEN DATEDIFF(DAY, o_order_date, s_ship_date) > 120 THEN 1
        ELSE 0
    END) AS over_120_days
FROM
    catalog_sales
    JOIN warehouse ON cs_warehouse_sk = w_warehouse_sk
    JOIN ship_mode ON cs_ship_mode_sk = sm_ship_mode_sk
    JOIN call_center ON cs_call_center_sk = cc_call_center_sk
    JOIN date_dim ON cs_ship_date_sk = d_date_sk
    JOIN order_date ON cs_order_date_sk = od_order_date_sk
WHERE
    d_year = 1224
GROUP BY
    SUBSTR(w_warehouse_name, 1, 20),
    s_ship_mode,
    c_call_center_name
ORDER BY
    SUBSTR(w_warehouse_name, 1, 20),
    s_ship_mode,
    c_call_center_name
LIMIT 100;
