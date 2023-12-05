SELECT
    COUNT(DISTINCT cs1.cs_order_number) AS "order count",
    SUM(cs1.cs_ship_cost) AS "total shipping cost",
    SUM(cs1.cs_net_profit) AS "total net profit"
FROM
    catalog_sales cs1
    JOIN date_dim dd ON cs1.cs_sold_date_sk = dd.d_date_sk
    JOIN customer_address ca ON cs1.cs_bill_addr_sk = ca.ca_address_sk
    JOIN call_center cc ON cs1.cs_call_center_sk = cc.cc_call_center_sk
WHERE
    dd.d_date >= '2002-04-01'
    AND dd.d_date <= DATEADD(DAY, 60, '2002-04-01')
    AND ca.ca_state = 'WV'
    AND ca.ca_county IN ('Ziebach County', 'Luce County', 'Richland County', 'Daviess County', 'Barrow County')
    AND EXISTS (
        SELECT 1
        FROM catalog_sales cs2
        WHERE cs1.cs_order_number = cs2.cs_order_number
        AND cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk
    )
    AND NOT EXISTS (
        SELECT 1
        FROM catalog_returns cr1
        WHERE cs1.cs_order_number = cr1.cr_order_number
    )
GROUP BY
    ca.ca_state, ca.ca_county
ORDER BY
    "order count" DESC
LIMIT 100;
