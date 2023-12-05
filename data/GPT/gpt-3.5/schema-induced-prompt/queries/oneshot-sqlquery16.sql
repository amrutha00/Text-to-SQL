SELECT COUNT(DISTINCT cs1.cs_order_number) AS "order count",
       SUM(cs1.cs_ext_ship_cost) AS "total shipping cost",
       SUM(cs1.cs_net_profit) AS "total net profit"
FROM catalog_sales cs1
JOIN date_dim d ON cs1.cs_sold_date_sk = d.d_date_sk
JOIN customer_address ca ON cs1.cs_ship_addr_sk = ca.ca_address_sk
JOIN call_center cc ON cs1.cs_call_center_sk = cc.cc_call_center_sk
WHERE d.d_date >= '2002-04-01' AND d.d_date <= DATE_ADD('2002-04-01', INTERVAL 60 DAY)
  AND ca.ca_state = 'WV'
  AND (ca.ca_county = 'Ziebach County'
       OR ca.ca_county = 'Luce County'
       OR ca.ca_county = 'Richland County'
       OR ca.ca_county = 'Daviess County'
       OR ca.ca_county = 'Barrow County')
  AND EXISTS (
      SELECT *
      FROM catalog_sales cs2
      WHERE cs1.cs_order_number = cs2.cs_order_number
        AND cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk
    )
  AND NOT EXISTS (
      SELECT *
      FROM catalog_returns cr1
      WHERE cs1.cs_order_number = cr1.cr_order_number
    )
GROUP BY cs1.cs_order_number
ORDER BY "order count" DESC
LIMIT 100;